from collections.abc import Sequence
from .utils import create_valuations
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, NOT_MODL, Agent, RMLOrPredTerm, ListCompVar, ListCompAgents, RML, Nesting, SeparatedRMLTerm
from copy import deepcopy
from pddl.action import Action
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant, Variable
from pddl.logic.predicates import Predicate
import pddl.core as pddl_core


def check_intention_error(rml: RML, domain):
    action_names = [a.name for a in domain.actions]
    current = deepcopy(rml)
    while isinstance(current.child, RML):
        current = deepcopy(current.child)
    if isinstance(current.mod_type, ActionMODLType) or isinstance(current.mod_type, PossibleActionMODLType):
        if current.child.name not in action_names:
            raise PDDLValidationError("Cannot intend a predicate; you can only intend an action.")

def set_rml_deepest_child(rml: RML, new_child, assignment = None):
    nestings = []
    current = deepcopy(rml)
    while isinstance(current, RML):
        current_no_child = deepcopy(current)
        current_no_child.child = None
        if assignment:
            current_no_child.agent = Agent(Constant(assignment[current_no_child.agent.term.name], "agent"))
        nestings.append(Nesting(current_no_child.mod_type, current_no_child.agent))
        current = deepcopy(current.child)
    nestings.append(new_child)
    for i in range(len(nestings) - 1, - 1, - 1):
        if isinstance(nestings[i], Predicate):
            continue
        nestings[i] = nestings[i](nestings[i + 1])
    return nestings[0]

def ground_formula(formula: Sequence, assignment, domain, problem):
    grounded_formulas = []
    for fo in formula:
        fo = deepcopy(fo)
        if isinstance(fo, Predicate):
            # no predicate should be negated yet, since everything is separated
            if fo.negated:
                raise ValueError("Parsing error. Predicates should not be negated yet, as modalities (including negations) have not yet been applied.")
            # turn action predicate into atomic predicate
            if fo.name in domain.lifted_action_names:
                grounded_formulas.append(Predicate(f"{fo.name}_{'_'.join(t.name for t in fo.terms)}"))
            else:
                terms = list(fo.terms)
                for i in range(len(terms)):
                    terms[i] = Constant(assignment[terms[i].name]) if isinstance(terms[i], Variable) else terms[i]
                p = Predicate(fo.name, *terms)
                p.negated = fo.negated
                p.always_known = fo.always_known
                grounded_formulas.append(p)
        elif isinstance(fo, RML):
            # need to set the base predicate of the RML to the grounded predicate
            grounded_predicate = list(ground_formula([fo._get_predicate()], assignment, domain, problem))[0]
            grounded_rml = set_rml_deepest_child(fo, grounded_predicate, assignment)
            # need to ground the agents in the MODLs as well
            check_intention_error(grounded_rml, domain)
            grounded_formulas.append(grounded_rml)
        elif isinstance(fo, ForallCondition):
            vars = {v for v in fo.variables}
            val_generator = create_valuations(domain._agents.keys(), domain.gathered_constants, vars)
            for valuation in val_generator:
                var_names = [v.name for v in vars]
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                    grounded_formulas.extend(ground_formula([fo.condition], assignment, domain, problem))
            assignment = {}
        elif isinstance(fo, Forall):
            var_names = [v.name for v in fo.variables]
            val_generator = create_valuations(domain._agents.keys(), domain.gathered_constants, fo.variables)
            for valuation in val_generator:
                # need to add onto the existing assignment so we retain knowledge of outer variables
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                    grounded_formulas.extend(ground_formula([fo.effect], assignment, domain, problem))
            assignment = {}
        elif isinstance(fo, And):
            for o in fo.operands:
                grounded_formulas.extend(ground_formula([o], assignment, domain, problem))
        elif isinstance(fo, Not):
            if not isinstance(fo.argument, RML) and not isinstance(fo.argument, Predicate) and not isinstance(fo.argument, SeparatedRMLTerm):
                raise PDDLValidationError(f"'Not' was applied to {type(fo.argument)}. 'Not' can only be applied to an RML or Predicate.")
            grounded_formulas.append(Not(list(ground_formula([fo.argument], assignment, domain, problem))[0]))
        elif isinstance(fo, When):
            cond = ground_formula([fo.condition], assignment, domain, problem)
            # for formatting/consistency reasons, we want to force this into being an "And"
            eff = ground_formula([fo.effect], assignment, domain, problem)
            and_term_eff = And(*[])
            and_term_eff._operands.extend(eff)
            for c in cond:
                and_term_cond = And(*[])
                and_term_cond._operands.append(c)
                grounded_formulas.append(When(and_term_cond, and_term_eff))
        elif isinstance(fo, SeparatedRMLTerm):
            grounded_formulas.append(SeparatedRMLTerm(list(ground_formula(fo.nestings, assignment, domain, problem)), list(ground_formula([fo.term], assignment, domain, problem))[0]))
        elif isinstance(fo, Nesting):
            if fo.child:
                raise ValueError("Nestings should not yet be nested (stored in a list, not nested with children).")
            fo.agent.term = Constant(assignment[fo.agent.term.name]) if isinstance(fo.agent.term, Variable) else fo.agent.term
            grounded_formulas.append(fo)
        elif isinstance(fo, NOT_MODL):
            grounded_formulas.append(fo)
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return grounded_formulas

def create_grounded_fluents(domain, problem):
    formulas = set()
    for p in domain.predicates:
        val_generator = create_valuations(domain._agents.keys(), domain.gathered_constants, p.terms)
        vars = p.terms if isinstance(p, Predicate) else p._get_predicate().terms
        var_names = [v.name for v in vars]
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            formulas.update(ground_formula([p], assignment, domain, problem))
    return formulas

def create_grounded_operators(domain, problem):
    operators = set()
    for a in domain.actions:
        vars = set(a.parameters)
        if a.derive_condition and not isinstance(a.derive_condition, str):
            if not isinstance(a.derive_condition, SeparatedRMLTerm):
                raise PDDLValidationError(f"Unknown type {type(a.derive_condition)}.")
            dc_pred = a.derive_condition.term
            vars.update(dc_pred.terms)
            for n in a.derive_condition.nestings:
                vars.add(n.agent.term)
        var_names = [v.name for v in vars]
        val_generator = create_valuations(domain._agents.keys(), domain.gathered_constants, vars)
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            op_name_suffix = "_".join([assignment[var.name] for var in a.parameters])
            op_name = a.name + "_" + op_name_suffix if op_name_suffix else a.name
            pass_pre = a.precondition.operands if type(a.precondition) is And else [a.precondition]
            precondition = ground_formula(pass_pre, assignment, domain, problem)
            if not isinstance(precondition, And):
                and_ = And(*[])
                and_._operands.extend(precondition)
                precondition = and_
            effect = ground_formula([a.effect], assignment, domain, problem) 
            if not isinstance(effect, And):
                and_ = And(*[])
                and_._operands.extend(effect)
                effect = and_
            new_a = Action(
                    op_name,
                    None,
                    precondition,
                    effect
                )
            new_a.assignment = assignment
            if a.derive_condition:
                new_a.derive_condition = a.derive_condition if type(a.derive_condition) is str else list(ground_formula([a.derive_condition], assignment, domain, problem))[0]
            operators.add(new_a)
    return operators

def gather_itn_preds(formula):
    itn_preds = set()
    for fo in formula:
        if isinstance(fo, Predicate):
            pass
        elif isinstance(fo, RML):
            if isinstance(fo.mod_type, ActionMODLType) or isinstance(fo.mod_type, PossibleActionMODLType):
                pred = fo._get_predicate()
                if not isinstance(pred, RMLOrPredTerm):
                    itn_preds.add(pred)
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
        elif isinstance(fo, SeparatedRMLTerm):
            continue
        else:
            print()
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
    for ae in anc_effs.anceffs:
        for fo in ([ae.antecedent.rml] + ae.consequent.rml):
            if isinstance(fo, ListCompVar) or isinstance(fo, ListCompAgents):
                itn_preds.update(gather_itn_preds([fo.term]))
            else:
                itn_preds.update(gather_itn_preds([fo]))
    itn_preds_strs = [str(p) for p in itn_preds]
    action_intention_f = set()
    for i in range(len(operators)):
        o_name = f"({operators[i].name})"
        if o_name in itn_preds_strs:
            action_iaps = []
            for ag in agents:
                iap = NOT_MODL()(RML(PossibleActionMODLType.PITN, Agent(Constant(ag, "agent")), Predicate(operators[i].name)))
                action_iaps.append(iap)
            operators[i].effect._operands.extend(action_iaps)
            action_intention_f.update(action_iaps)
    return set(operators), action_intention_f

def ground(anc_effs, domain, problem):
    constants = set(domain.constants) | set(problem.objects) | set(domain._agents.values())
    domain.gathered_constants = constants
    lifted_action_names = {a.name for a in domain.actions}
    domain.lifted_action_names = lifted_action_names

    g_formulas = create_grounded_fluents(domain, problem)
    g_operators = create_grounded_operators(domain, problem)
    g_operators, action_intention_f = create_itn_action_preds(g_operators, domain._agents.keys(), problem, anc_effs)
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
        agents=domain._agents
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