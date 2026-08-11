from collections.abc import Sequence
from .utils import create_valuations
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, MODL, NOT_MODL, Agent
from copy import deepcopy
from pddl.action import Action
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant
from pddl.logic.predicates import Predicate
import pddl.core as pddl_core


def assign_always_known(fl, domain):
    # find the "always known" status by referencing it from the domain predicates
    for dp in domain.predicates:
        if dp.name == fl.name and len(dp.terms) == len(fl.terms):
            fl.always_known = dp.always_known
            return
    raise ValueError(f"Predicate {fl.name} with terms {fl.terms} terms not found in domain predicates.")

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
    fluents = set()
    for fo in formula:
        fo = deepcopy(fo)
        if isinstance(fo, Predicate):
            fl = Predicate(fo.name, *[Constant(assignment[t.name]) for t in fo.terms])
            fl.negated = fo.negated
            assign_always_known(fl, domain)
            fluents.add(fl)
        elif isinstance(fo, MODL):
            # need to set the base predicate of the MODL to the grounded predicate
            grounded_predicate = list(ground_formula([fo._get_predicate()], assignment, domain, problem))[0]
            grounded_modl = set_modl_deepest_child(fo, grounded_predicate, assignment)
            # need to ground the agents in the MODLs as well
            check_intention_error(grounded_modl, domain)
            fluents.add(grounded_modl)
        elif isinstance(fo, ForallCondition):
            vars = {v for v in fo.variables}
            val_generator = create_valuations(domain._agents, problem.objects, vars)
            for valuation in val_generator:
                var_names = [v.name for v in vars]
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                fluents.update(ground_formula([fo.condition], assignment, domain, problem))
        elif isinstance(fo, Forall):
            grounded = []
            var_names = [v.name for v in fo.variables]
            val_generator = create_valuations(domain._agents, problem.objects, fo.variables)
            for valuation in val_generator:
                # need to add onto the existing assignment so we retain knowledge of outer variables
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                grounded.append(ground_formula([fo.effect], assignment, domain, problem))
            return And(*grounded)
        elif isinstance(fo, And):
            for o in fo.operands:
                fluents.update(ground_formula([o], assignment, domain, problem))
        elif isinstance(fo, Not):
            if not isinstance(fo.argument, MODL) and not isinstance(fo.Predicate):
                raise ValueError("Not can only be applied to a MODL or Predicate.")
            fl = ground_formula([fo.argument], assignment, domain, problem)
            fl.negated = True
            fluents.add(fl)
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
            return When(cond, eff)
        else:
            raise ValueError("Unknown formula type: " + str(type(fo)))
    return fluents

def ground_problem_rmls(all_fo, domain):
    # TODO: allow for Not, Forall, etc. here
    all_fo = list(all_fo)
    for i in range(len(all_fo)):
        if isinstance(all_fo[i], Predicate):
            assign_always_known(all_fo[i], domain)
        elif isinstance(all_fo[i], MODL):
            assign_always_known(all_fo[i]._get_predicate(), domain)
            all_fo[i] = set_modl_deepest_child(all_fo[i], all_fo[i]._get_predicate())
        elif isinstance(all_fo[i], Forall):
            print()
        elif isinstance(all_fo[i], And):
            print()
        elif isinstance(all_fo[i], Not):
            print()
            # if init:
            #     raise ValueError("Cannot have Not formulas in the initial state.")
            # if not isinstance(all_fo[i].argument, MODL) and not isinstance(all_fo[i].Predicate):
            #     raise ValueError("Not can only be applied to a MODL or Predicate.")
            # all_fo[i] = all_fo[i].argument
            # all_fo[i].negated = True
    return frozenset(all_fo)

def create_grounded_fluents(domain, problem):
    fluents = set()
    for p in domain.predicates:
        val_generator = create_valuations(domain._agents, problem.objects, p.terms)
        vars = p.terms if isinstance(p, Predicate) else p._get_predicate().terms
        var_names = [v.name for v in vars]
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            fluents.update(ground_formula([p], assignment, domain, problem))
    return fluents

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

def create_itn_action_preds(operators, agents, goal):
    operators = list(operators)
    itn_preds = set()
    # find all intention predicates in the goal or in action preconditions
    for rml in goal:
        if isinstance(rml, MODL):
            if isinstance(rml.mod_type, ActionMODLType) or isinstance(rml.mod_type, PossibleActionMODLType):
                itn_preds.add(rml._get_predicate())
    for a in operators:
        for rml in a.precondition.operands:
            if isinstance(rml, MODL):
                if isinstance(rml.mod_type, ActionMODLType) or isinstance(rml.mod_type, PossibleActionMODLType):
                    itn_preds.add(rml._get_predicate())
    action_intention_f = set()
    for i in range(len(operators)):
        o_name = operators[i].name.split("_")
        intend_action_p = Predicate(o_name[0], *[Constant(n) for n in o_name[1:]])
        intend_action_p.always_known = False
        intend_action_p.negated = False
        if intend_action_p in itn_preds:
            itn_preds.remove(intend_action_p)
            # all_iaps = []
            action_iaps = []
            for ag in agents:
                iap = NOT_MODL()(MODL(PossibleActionMODLType.PITN, Agent(ag, False))(intend_action_p))
                action_iaps.append(iap)
                # all_iaps.append(iap)
                # # these are to add to the domain
                # all_iaps.append((MODL(ActionMODLType.ITN, Agent(ag, False))(intend_action_p)))
                # all_iaps.append(MODL(PossibleActionMODLType.PITN, Agent(ag, False))(NOT_MODL()(intend_action_p)))
                # all_iaps.append(MODL(PossibleActionMODLType.PITN, Agent(ag, False))(intend_action_p))
            operators[i].effect._operands.extend(action_iaps)
            action_intention_f.add(intend_action_p)
    if itn_preds:
        raise ValueError(f"One or more of these intentions references an action not in the grounded domain: {itn_preds}")
    return set(operators), action_intention_f


def ground(domain, problem):
    g_fluents = create_grounded_fluents(domain, problem)
    g_operators = create_grounded_operators(domain, problem)
    g_operators, action_intention_f = create_itn_action_preds(g_operators, domain._agents, problem.goal)
    g_fluents.update(action_intention_f)
    grounded_domain = pddl_core.Domain(
        name=domain.name,
        requirements=domain.requirements,
        types=domain.types,
        constants=domain.constants,
        predicates=g_fluents,
        derived_predicates=domain.derived_predicates,
        functions=domain.functions,
        actions=g_operators,
        agents=domain._agents
    )
    g_init = ground_problem_rmls(problem.init, grounded_domain)
    g_goal = ground_problem_rmls(problem.goal, grounded_domain)
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