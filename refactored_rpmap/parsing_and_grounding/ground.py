from .parsing_utils import create_valuations
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, MODL, Agent
from copy import deepcopy
from pddl.action import Action
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant
from pddl.logic.predicates import Predicate


def check_intention_error(modl: MODL, domain):
    action_names = [a.name for a in domain.actions]
    current = deepcopy(modl)
    while isinstance(current.child, MODL):
        current = deepcopy(current.child)
    if isinstance(current.mod_type, ActionMODLType) or isinstance(current.mod_type, PossibleActionMODLType):
        if current.child.name not in action_names:
            raise ValueError("Cannot intend a predicate; you can only intend an action.")

def ground_formula(formula, assignment, domain, problem):
    fluents = []
    for fo in formula:
        fo = deepcopy(fo)
        if isinstance(fo, Predicate):
            fl = Predicate(fo.name, *[Constant(assignment[t.name]) for t in fo.terms])
            fl.negated = fo.negated
            # find the "always known" status by referencing it from the domain predicates
            fl.always_known = False
            for dp in domain.predicates:
                if dp.name == fl.name and len(dp.terms) == len(fl.terms):
                    fl.always_known = dp.always_known
                    break
            fluents.append(fl)
        # change to isinstance
        elif isinstance(fo, ForallCondition):
            vars = {v for v in fo.variables}
            val_generator = create_valuations(domain._agents, problem.objects, vars)
            for valuation in val_generator:
                var_names = [v.name for v in vars]
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                fluents.extend(ground_formula([fo.condition], assignment, domain, problem))
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
            fluents.extend([ground_formula([o], assignment, domain, problem) for o in fo.operands])
        elif isinstance(fo, Not):
            fl = ground_formula([fo.argument], assignment, domain, problem)
            fl.negated = True
            fluents.append(fl)
        elif hasattr(fo, "argument"):
            fluents.append(ground_formula([fo.argument], assignment, domain, problem))
        elif isinstance(fo, MODL):
            # need to set the base predicate of the MODL to the grounded predicate
            # first, convert the MODL to a list of MODLs with no children with the new grounded predicate at the end
            modls = []
            current = deepcopy(fo)
            while isinstance(current, MODL):
                current_no_child = deepcopy(current)
                current_no_child.child = None
                current_no_child.agent = Agent(assignment[current_no_child.agent.name], False)
                modls.append(current_no_child)
                current = deepcopy(current.child)
            modls.append(ground_formula([fo.get_deepest_child()], assignment, domain, problem)[0])
            for i in range(len(modls) - 1, - 1, - 1):
                if isinstance(modls[i], Predicate):
                    continue
                modls[i] = modls[i](modls[i + 1])
            grounded_modl = modls[0]
            check_intention_error(grounded_modl, domain)
            fluents.append(grounded_modl)
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
        
def create_base_operators(domain, problem):
    operators = set()

    for a in domain.actions:
        var_names = [v.name for v in a.parameters]
        val_generator = create_valuations(domain._agents, problem.objects, a.parameters)
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            op_name_suffix = "_".join([assignment[var.name] for var in a.parameters])
            op_name = a.name + "_" + op_name_suffix if op_name_suffix else a.name
            pass_pre = a.precondition.operands if type(a.precondition) is And else [a.precondition]
            precondition = And(*ground_formula(pass_pre, assignment, domain, problem))

            if not isinstance(precondition, And):
                and_ = And(*[])
                and_._operands.append(precondition)
                precondition = and_

            effect = ground_formula([a.effect], assignment, domain, problem) 

            if not isinstance(effect, And):
                and_ = And(*[])
                and_._operands.append(effect)
                effect = and_

            new_a = Action(
                    op_name,
                    None,
                    precondition,
                    effect
                )

            print()
    #         new_a.assignment = assignment
    #         if type(a.derive_condition) is list:
    #             # have a complex derived condition
    #             # need to ensure we handle any variables here
    #             dev_cond_copy = deepcopy(a.derive_condition)
    #             for i in range(len(dev_cond_copy)):
    #                 if type(dev_cond_copy[i]) is list:
    #                     if type(dev_cond_copy[i][0]) is list:
    #                         if dev_cond_copy[i][0][0].type == "QMRK":
    #                             dev_cond_copy[i] = Constant(assignment[dev_cond_copy[i][0][1].value])
    #         new_a.derive_condition = dev_cond_copy
    #         operators.add(new_a)
    # return operators

def ground(domain, problem, grounded_dom_path):
    actions = create_base_operators(domain, problem)
    return domain, problem