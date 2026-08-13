from collections.abc import Sequence
from .utils import create_valuations
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, MODL, NOT_MODL, Agent
from copy import deepcopy
from pddl.action import Action
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant, Variable
from pddl.logic.predicates import Predicate
import pddl.core as pddl_core


# def get_always_known_assigned(fl, domain):
#     fl = deepcopy(fl)
#     # find the "always known" status by referencing it from the domain predicates
#     for dp in domain.predicates:
#         if dp.name == fl.name and len(dp.terms) == len(fl.terms):
#             fl.always_known = dp.always_known
#             return fl
#     raise ValueError(f"Predicate {fl.name} with terms {fl.terms} terms not found in domain predicates.")

def check_intention_error(modl: MODL, domain):
    action_names = [a.name for a in domain.actions]
    current = deepcopy(modl)
    while isinstance(current.child, MODL):
        current = deepcopy(current.child)
    if isinstance(current.mod_type, ActionMODLType) or isinstance(current.mod_type, PossibleActionMODLType):
        if current.child.name not in action_names:
            raise ValueError("Cannot intend a predicate; you can only intend an action.")

def set_modl_deepest_child(modl, new_child, assignment = None):
        modls = []
        current = deepcopy(modl)
        while isinstance(current, MODL):
            current_no_child = deepcopy(current)
            current_no_child.child = None
            if assignment:
                current_no_child.agent = Agent(assignment[current_no_child.agent.name], False)
            modls.append(current_no_child)
            current = deepcopy(current.child)
        modls.append(new_child)
        for i in range(len(modls) - 1, - 1, - 1):
            if isinstance(modls[i], Predicate):
                continue
            modls[i] = modls[i](modls[i + 1])
        return modls[0]

def ground_formula(formula: Sequence, assignment, domain, problem):
    grounded_formulas = set()
    for fo in formula:
        fo = deepcopy(fo)
        if isinstance(fo, Predicate):
            # turn action predicate into atomic predicate
            if fo.name in domain.lifted_action_names:
                grounded_formulas.add(Predicate(f"{fo.name}_{'_'.join(t.name for t in fo.terms)}"))
            else:
                terms = list(fo.terms)
                for i in range(len(terms)):
                    terms[i] = Constant(assignment[terms[i].name]) if isinstance(terms[i], Variable) else terms[i]
                fl = Predicate(fo.name, *terms)
                fl.negated = fo.negated
                grounded_formulas.add(fl)
                # grounded_formulas.add(get_always_known_assigned(fl, domain))
        elif isinstance(fo, MODL):
            # need to set the base predicate of the MODL to the grounded predicate
            grounded_predicate = list(ground_formula([fo._get_predicate()], assignment, domain, problem))[0]
            grounded_modl = set_modl_deepest_child(fo, grounded_predicate, assignment)
            # need to ground the agents in the MODLs as well
            check_intention_error(grounded_modl, domain)
            grounded_formulas.add(grounded_modl)
        elif isinstance(fo, ForallCondition):
            vars = {v for v in fo.variables}
            val_generator = create_valuations(domain._agents, problem.objects, vars)
            for valuation in val_generator:
                var_names = [v.name for v in vars]
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                    grounded_formulas.update(ground_formula([fo.condition], assignment, domain, problem))
        elif isinstance(fo, Forall):
            var_names = [v.name for v in fo.variables]
            val_generator = create_valuations(domain._agents, problem.objects, fo.variables)
            for valuation in val_generator:
                # need to add onto the existing assignment so we retain knowledge of outer variables
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                    grounded_formulas.update(ground_formula([fo.effect], assignment, domain, problem))
        elif isinstance(fo, And):
            for o in fo.operands:
                grounded_formulas.update(ground_formula([o], assignment, domain, problem))
        elif isinstance(fo, Not):
            if not isinstance(fo.argument, MODL) and not isinstance(fo.argument, Predicate):
                raise ValueError(f"`Not` was applied to {type(fo.argument)}. `Not` can only be applied to a MODL or Predicate.")
            grounded_formulas.add(Not(list(ground_formula([fo.argument], assignment, domain, problem))[0]))
        elif isinstance(fo, When):
            cond = ground_formula([fo.condition], assignment, domain, problem)
            # for formatting reasons we want to force this into being an "And"
            and_term = And(*[])
            and_term._operands.extend(cond)
            cond = and_term
            eff = ground_formula([fo.effect], assignment, domain, problem)
            and_term = And(*[])
            and_term._operands.extend(eff)
            eff = and_term
            grounded_formulas.add(When(cond, eff))
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return grounded_formulas

def create_grounded_fluents(domain, problem):
    formulas = set()
    for p in domain.predicates:
        val_generator = create_valuations(domain._agents, problem.objects, p.terms)
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
        var_names = [v.name for v in vars]
        if a.derive_condition and not isinstance(a.derive_condition, str):
            for term in a.derive_condition.terms:
                if term.name not in var_names:
                    vars.add(term)
        var_names = [v.name for v in vars]
        val_generator = create_valuations(domain._agents, problem.objects, vars)
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
        if isinstance(fo, MODL):
            if isinstance(fo.mod_type, ActionMODLType) or isinstance(fo.mod_type, PossibleActionMODLType):
                itn_preds.add(fo._get_predicate())
        elif isinstance(fo, Predicate):
            pass
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
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return itn_preds

def create_itn_action_preds(operators, agents, goal):
    operators = list(operators)
    itn_preds = set()
    # find all intention predicates in the goal or in action preconditions
    itn_preds.update(gather_itn_preds(goal))
    for a in operators:
        itn_preds.update(gather_itn_preds(a.precondition.operands))
    itn_preds_strs = [str(p) for p in itn_preds]
    action_intention_f = set()
    for i in range(len(operators)):
        o_name = f"({operators[i].name})"
        if o_name in itn_preds_strs:
            action_iaps = []
            for ag in agents:
                iap = NOT_MODL()(MODL(PossibleActionMODLType.PITN, Agent(ag, False))(Predicate(operators[i].name)))
                action_iaps.append(iap)
            operators[i].effect._operands.extend(action_iaps)
        action_intention_f.add(Predicate(operators[i].name))
    return set(operators), action_intention_f

def ground(domain, problem):
    lifted_action_names = {a.name for a in domain.actions}
    domain.lifted_action_names = lifted_action_names
    g_formulas = create_grounded_fluents(domain, problem)
    g_operators = create_grounded_operators(domain, problem)
    g_operators, action_intention_f = create_itn_action_preds(g_operators, domain._agents, problem.goal)
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