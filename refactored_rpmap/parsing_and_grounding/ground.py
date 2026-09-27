from collections.abc import Sequence
from .utils import create_valuations, cleaned_not, create_and
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, NOT_MODL, Agent, RMLOrPredTerm, ListCompVar, ListCompAgents, ListCompVarAgents, Nesting, SeparatedRMLTerm
from pddl.action import Action
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant, Variable
from pddl.logic.predicates import Predicate
import pddl.core as pddl_core


def check_intention_error(srt: SeparatedRMLTerm, domain):
    action_names = [a.name for a in domain.actions]
    if srt.nestings:
        n = srt.nestings[-1]
        if isinstance(n, Nesting) and (isinstance(n.mod_type, ActionMODLType) or isinstance(n.mod_type, PossibleActionMODLType)) and srt.term.name not in action_names:
            raise PDDLValidationError(f"Cannot intend a predicate {srt.term}; you can only intend an action.")

def ground_formula(formula: Sequence, assignment, domain, problem):
    grounded_formulas = []
    for fo in formula:
        if isinstance(fo, Constant):
            grounded_formulas.append(fo)
        elif isinstance(fo, Variable):
            if "dlr__" not in fo.name:
                if fo.name not in assignment:
                    raise PDDLValidationError(f"Variable {fo.name} not defined; cannot ground.")
                grounded_formulas.append(assignment[fo.name])
            else:
                grounded_formulas.append(fo)
        elif isinstance(fo, Predicate):
            # no predicate should be negated yet, since everything is separated
            if fo.negated:
                raise ValueError("Parsing error. Predicates should not be negated yet, as modalities (including negations) have not yet been applied.")
            terms = ground_formula(fo.terms, assignment, domain, problem)
            # turn action predicate into atomic predicate
            if fo.name in domain.lifted_action_names:
                grounded_formulas.append(Predicate(f"{fo.name}_{'_'.join(t.name for t in terms)}"))
            else:
                grounded_formulas.append(Predicate(fo.name, *terms, always_known=fo.always_known, negated=fo.negated))
        elif isinstance(fo, ForallCondition):
            variables = {v for v in fo.variables}
            val_generator = create_valuations(domain.gathered_constants, variables)
            for valuation in val_generator:
                var_names = [v.name for v in variables]
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                grounded_formulas.extend(ground_formula(fo.condition.operands if isinstance(fo.condition, And) else [fo.condition], assignment, domain, problem))
            assignment = {}
        elif isinstance(fo, Forall):
            var_names = [v.name for v in fo.variables]
            val_generator = create_valuations(domain.gathered_constants, fo.variables)
            for valuation in val_generator:
                # need to add onto the existing assignment so we retain knowledge of outer variables
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                grounded_formulas.extend(ground_formula(fo.effect.operands if isinstance(fo.effect, And) else [fo.effect], assignment, domain, problem))
            assignment = {}
        elif isinstance(fo, And):
            for o in fo.operands:
                grounded_formulas.extend(ground_formula([o], assignment, domain, problem))
        elif isinstance(fo, Not):
            if not isinstance(fo.argument, Predicate) and not isinstance(fo.argument, SeparatedRMLTerm):
                raise PDDLValidationError(f"'Not' was applied to {type(fo.argument)}. 'Not' can only be applied to an SRT or Predicate.")
            grounded_formulas.append(cleaned_not(list(ground_formula(fo.argument.operands if isinstance(fo.argument, And) else [fo.argument], assignment, domain, problem))[0]))
        elif isinstance(fo, When):
            cond = ground_formula([fo.condition], assignment, domain, problem)
            # for formatting/consistency reasons, we want to force this into being an "And"
            eff = ground_formula([fo.effect], assignment, domain, problem)
            for e in eff:
                grounded_formulas.append(When(create_and(cond), create_and([e])))
        elif isinstance(fo, SeparatedRMLTerm):
            check_intention_error(fo, domain)
            fo = SeparatedRMLTerm(list(ground_formula(fo.nestings, assignment, domain, problem)), list(ground_formula([fo.term], assignment, domain, problem))[0])
            grounded_formulas.append(fo)
        elif isinstance(fo, Nesting):
            if fo.child:
                raise ValueError("Nestings should not yet be nested (stored in a list, not nested with children).")
            grounded_formulas.append(Nesting(fo.mod_type, Agent(ground_formula([fo.agent.term], assignment, domain, problem)[0])))
        elif isinstance(fo, NOT_MODL):
            grounded_formulas.append(fo)
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return grounded_formulas

def create_grounded_fluents(domain, problem):
    formulas = set()
    for p in domain.predicates:
        val_generator = create_valuations(domain.gathered_constants, p.terms)
        variables = p.terms if isinstance(p, Predicate) else p._get_root().terms
        var_names = [v.name for v in variables]
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            formulas.update(ground_formula([p], assignment, domain, problem))
    return formulas

def ground_action(a, domain, problem, assignment):
    op_name_suffix = "_".join([assignment[var.name].name for var in a.parameters])
    op_name = a.name + "_" + op_name_suffix if op_name_suffix else a.name
    precondition = ground_formula(a.precondition.operands if isinstance(a.precondition, And) else [a.precondition], assignment, domain, problem)
    if not isinstance(precondition, And):
        precondition = create_and(precondition)
    effect = ground_formula(a.effect.operands if isinstance(a.effect, And) else [a.effect], assignment, domain, problem) 
    if not isinstance(effect, And):
        effect = create_and(effect)
    derive_condition = (a.derive_condition if type(a.derive_condition) is str else list(ground_formula([a.derive_condition], assignment, domain, problem))[0]) if a.derive_condition else None
    new_a = Action(
            op_name,
            None,
            precondition,
            effect,
            derive_condition=derive_condition
        )
    
    return new_a

def create_grounded_operators(domain, problem):
    operators = set()
    for a in domain.actions:
        variables = set(a.parameters)
        if a.derive_condition and not isinstance(a.derive_condition, str):
            if not isinstance(a.derive_condition, SeparatedRMLTerm):
                raise PDDLValidationError(f"Unknown type {type(a.derive_condition)}.")
            dc_pred = a.derive_condition.term
            variables.update(dc_pred.terms)
            for n in a.derive_condition.nestings:
                variables.add(n.agent.term)
        var_names = [v.name for v in variables]
        val_generator = create_valuations(domain.gathered_constants, variables)
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            operators.add(ground_action(a, domain, problem, assignment))
    return operators

def gather_itn_preds(formula):
    itn_preds = set()
    for fo in formula:
        if isinstance(fo, Predicate):
            pass
        elif isinstance(fo, SeparatedRMLTerm):
            if not isinstance(fo.term, RMLOrPredTerm):
                if fo.nestings:
                    for n in fo.nestings:
                        if isinstance(n, NOT_MODL):
                            continue
                        elif isinstance(n, Nesting):
                            mod_type = n.mod_type
                        elif isinstance(n, MODLTermWNesting):
                            mod_type = n.modl.mod_type
                        else:
                            raise PDDLValidationError(f"Unknown nesting type {type(n)}.")
                        if isinstance(mod_type, ActionMODLType) or isinstance(mod_type, PossibleActionMODLType):
                            itn_preds.add(fo.term)
        elif isinstance(fo, ForallCondition):
            itn_preds.update(gather_itn_preds([fo.condition]))
        elif isinstance(fo, Forall):
            itn_preds.update(gather_itn_preds([fo.effect]))
        elif isinstance(fo, And):
            for o in fo.operands:
                itn_preds.update(gather_itn_preds([o]))
        elif isinstance(fo, Not):
            itn_preds.update(gather_itn_preds([fo.argument]))
        elif isinstance(fo, When):
            itn_preds.update(gather_itn_preds([fo.condition]))
            itn_preds.update(gather_itn_preds([fo.effect]))
        elif isinstance(fo, ListCompVar) or isinstance(fo, ListCompAgents) or isinstance(fo, ListCompVarAgents):
            itn_preds.update(gather_itn_preds([fo.term]))
        elif isinstance(fo, SeparatedRMLTerm):
            continue
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return itn_preds

def create_itn_action_preds(operators, agents, problem, anc_effs):
    operators = list(operators)
    itn_preds = set()
    # find all intention predicates
    itn_preds.update(gather_itn_preds(problem.init))
    itn_preds.update(gather_itn_preds(problem.goal))
    for a in operators:
        itn_preds.update(gather_itn_preds(a.precondition.operands))
        itn_preds.update(gather_itn_preds(a.effect.operands))
    for ae in anc_effs:
        for fo in ([ae.antecedent.rml] + ae.consequent.rml):
            itn_preds.update(gather_itn_preds([fo]))
    itn_preds_strs = [str(p) for p in itn_preds]
    action_intention_f = set()
    for i in range(len(operators)):
        o_name = f"({operators[i].name})"
        if o_name in itn_preds_strs:
            action_iaps = [SeparatedRMLTerm([NOT_MODL(), Nesting(PossibleActionMODLType.PITN, Agent(ag))], Predicate(operators[i].name)) for ag in agents]
            operators[i] = Action(operators[i].name, operators[i].parameters, operators[i].precondition, create_and(list(operators[i].effect.operands) + action_iaps))
        action_intention_f.add(Predicate(operators[i].name))
    return set(operators), action_intention_f

def ground(anc_effs, domain, problem):
    constants = set(domain.constants) | set(problem.objects) | set(domain.agents.values())
    domain.gathered_constants = constants
    lifted_action_names = {a.name for a in domain.actions}
    domain.lifted_action_names = lifted_action_names

    g_formulas = create_grounded_fluents(domain, problem)
    g_operators = create_grounded_operators(domain, problem)
    g_operators, action_intention_f = create_itn_action_preds(g_operators, domain.agents.values(), problem, anc_effs)
    g_formulas.update(action_intention_f)
    grounded_domain = pddl_core.Domain(
        name=domain.name,
        requirements=domain.requirements,
        types=domain.types,
        constants=domain.constants,
        predicates=g_formulas,
        derived_predicates=domain.derived_predicates,
        functions=domain.functions,
        actions=g_operators,
        agents=domain.agents
    )

    grounded_domain.gathered_constants = constants
    grounded_domain.lifted_action_names = lifted_action_names
    g_init = ground_formula(problem.init, {}, grounded_domain, problem)
    g_goal = ground_formula(problem.goal, {}, grounded_domain, problem)
    grounded_problem = pddl_core.Problem(
        name=problem.name,
        domain=grounded_domain,
        domain_name=grounded_domain.name,
        requirements=domain.requirements,
        objects=problem.objects,
        init=g_init,
        goal=g_goal,
        metric=problem.metric,
        depth=problem.depth,
        task=problem.task,
        init_type=problem.init_type,
        plan=problem.plan,
        projection=problem.projection
    )
    return grounded_domain, grounded_problem