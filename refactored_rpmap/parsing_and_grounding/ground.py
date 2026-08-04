from .parsing_utils import create_valuations
from .core.anc_eff import Agent, ActionMODLType, PossibleActionMODLType
from copy import deepcopy
from pddl.action import Action
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant
from pddl.logic.predicates import Predicate, ForallCondition


def ground_formula(domain, problem, formula, assignment):
    if type(formula) is Predicate:
        return predicates_to_fluents([formula], assignment, domain, problem)[0]
    elif type(formula) is Not:
        p = ground_formula(domain, problem, formula.argument, assignment)
        if type(p) is Predicate:
            p.negated = True
            return p
        else:
            raise NotImplementedError("Deal with a complex Not formula?")
    elif type(formula) is And:
        return And(*[ground_formula(domain, problem, o, assignment)  for o in formula.operands])
    elif type(formula) is Forall:
        # need to get all values for this variable
        grounded = []
        var_names = [v.name for v in formula.variables]
        val_generator = create_valuations(domain._agents, problem.objects, formula.variables)
        for valuation in val_generator:
            # need to add onto the existing assignment so we retain knowledge of outer variables
            for var_name, val in zip(var_names, valuation):
                assignment[var_name] = val
            grounded.append(ground_formula(domain, problem, formula.effect, assignment))
        return And(*grounded)
    elif type(formula) is When:
        cond = ground_formula(domain, problem, formula.condition, assignment)
        if type(cond) is Predicate:
            # for formatting reasons we want to force this into being an "And"
            and_term = And(*[])
            and_term._operands.append(cond)
            cond = and_term
        return When(cond, ground_formula(domain, problem, formula.effect, assignment))

def check_intention_error(f: Predicate, domain):
    # TODO: fix this.
    action_names = [a.name for a in domain.actions]
    if isinstance(f.get_deepest_child(), ActionMODLType) or isinstance(f.get_deepest_child(), PossibleActionMODLType) and f.get_deepest_child().name not in action_names:
        raise ValueError("Cannot intend a predicate; you can only intend an action.")

def predicates_to_fluents(predicates: list[Predicate], assignment, domain, problem):
    fluents = []
    for p in predicates:
        p = deepcopy(p)
        new_terms = []
        # change to isinstance
        if type(p) is ForallCondition:
            vars = {v for v in p.variables}
            val_generator = create_valuations(domain._agents, problem.objects, vars)
            for valuation in val_generator:
                var_names = [v.name for v in vars]
                for var_name, val in zip(var_names, valuation):
                    assignment[var_name] = val
                fluents.extend(predicates_to_fluents([p.condition], assignment, domain, problem))
            return fluents
        elif type(p) is And:
            for o in p.operands:
                fluents.extend(predicates_to_fluents([o], assignment, domain, problem) )
            return fluents
        elif type(p) is Predicate:
            terms = p.terms
        elif type(p) is MODL:
            print()
        elif hasattr(p, "argument"):
            outside_formula_type = type(p)
            terms = p.argument.terms
        else:
            raise ValueError("Unknown predicate type?")
        for t in terms:
            new_terms.append(Constant(assignment[t.name]))
        
        if type(p) is not Predicate:
            f = Predicate(p.argument.name, *new_terms)
            f.negated = p.argument.negated
            f.always_known = p.argument.always_known
            f = outside_formula_type(f)
        else:
            f = Predicate(p.name, *new_terms)
            if p.modl:  
                if p.modl.agent.var:
                    p.modl.agent = Agent(assignment[p.modl.agent.name], False)   
                if p.modl.nested:
                    for i in range(len(p.modl.nested)):
                        p.modl.nested[i].agent = Agent(assignment[p.modl.nested[i].agent.name], False)
            f.modl = p.modl
            f.negated = (p.negated == True) # become False if it's None
            # find the "always known" status by referencing it from the domain predicates
            f.always_known = False
            for dp in domain.predicates:
                if dp.name == f.name and len(dp.terms) == len(f.terms):
                    f.always_known = dp.always_known
                    break
            if not f.always_known and f.negated:
                f.negated = False
                if f.modl:
                    if f.modl.nested:
                        f.modl.nested[-1].negate_inner_rml = not p.modl.nested[-1].negate_inner_rml
                    else:
                        f.modl.negate_inner_rml = not f.modl.negate_inner_rml
                else:
                    pass
                    # f.modl = NegateOnly(True)
        if f.modl:
            check_intention_error(f, domain)
        fluents.append(f)
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
            # TODO: handle other types of formulas?
            pass_pre = a.precondition.operands if type(a.precondition) is And else [a.precondition]
            precondition = And(*predicates_to_fluents(pass_pre, assignment, domain, problem))

            print()
    #         and_ = And(*[])
    #         if type(precondition) is And:
    #             and_._operands.extend(precondition._operands)
    #         else:
    #             and_._operands.append(precondition)
    #         precondition = and_

    #         effect = ground_formula(domain, problem, a.effect, assignment) 
            
    #         and_ = And(*[])
    #         if type(effect) is And:
    #             and_._operands.extend(effect._operands)
    #         else:
    #             and_._operands.append(effect)
    #         effect = and_

    #         new_a = Action(
    #                 op_name,
    #                 None,
    #                 precondition,
    #                 effect
    #             )
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