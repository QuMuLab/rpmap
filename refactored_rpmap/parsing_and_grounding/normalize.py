from collections.abc import Sequence

import pddl.core as pddl_core
from pddl.action import Action
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.predicates import Predicate
from pddl.logic.terms import Variable, Term
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, NOT_MODL, Agent, RMLOrPredTerm, ListCompVar, ListCompAgents, ListCompVarAgents, Nesting, SeparatedRMLTerm, MODLTermWNesting
from .utils import create_and, cleaned_not


def act_to_pred(action):
    return Predicate(action.name, *action.parameters)

def gather_itn_preds(act_dict, formula):
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
                            # want to keep everything equal and lifted (no grounding or variance in term names)
                            itn_preds.add(act_to_pred(act_dict[fo.term.name]))
        elif isinstance(fo, ForallCondition):
            itn_preds.update(gather_itn_preds(act_dict, [fo.condition]))
        elif isinstance(fo, Forall):
            itn_preds.update(gather_itn_preds(act_dict, [fo.effect]))
        elif isinstance(fo, And):
            for o in fo.operands:
                itn_preds.update(gather_itn_preds(act_dict, [o]))
        elif isinstance(fo, Not):
            itn_preds.update(gather_itn_preds(act_dict, [fo.argument]))
        elif isinstance(fo, When):
            itn_preds.update(gather_itn_preds(act_dict, [fo.condition]))
            itn_preds.update(gather_itn_preds(act_dict, [fo.effect]))
        elif isinstance(fo, ListCompVar) or isinstance(fo, ListCompAgents) or isinstance(fo, ListCompVarAgents):
            itn_preds.update(gather_itn_preds(act_dict, [fo.term]))
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return itn_preds

def create_itn_action_preds(act_dict, problem, anc_effs):
    operators = list(act_dict.values())
    itn_preds = set()
    # find all intention predicates
    itn_preds.update(gather_itn_preds(act_dict, problem.init))
    itn_preds.update(gather_itn_preds(act_dict, problem.goal))
    for a in operators:
        if isinstance(a.derive_condition, SeparatedRMLTerm):
            itn_preds.update(gather_itn_preds(act_dict, [a.derive_condition]))
        itn_preds.update(gather_itn_preds(act_dict, a.precondition.operands))
        itn_preds.update(gather_itn_preds(act_dict, a.effect.operands))
    for ae in anc_effs:
        for fo in ([ae.antecedent.rml] + ae.consequent.rml):
            itn_preds.update(gather_itn_preds(act_dict, [fo]))
    itn_preds = {p.name: p for p in itn_preds}
    action_intention_f = set()
    for i in range(len(operators)):
        if operators[i].name in itn_preds:
            action_iap = SeparatedRMLTerm([NOT_MODL(), Nesting(PossibleActionMODLType.PITN, Agent(Variable("itn_ag", ["agent"])))], itn_preds[operators[i].name])
            operators[i] = Action(operators[i].name, operators[i].parameters, operators[i].precondition, create_and(list(operators[i].effect.operands) + [action_iap]), derive_condition=operators[i].derive_condition)
            action_intention_f.add(act_to_pred(operators[i]))
    return set(operators), action_intention_f

def check_intention_error(srt: SeparatedRMLTerm, action_names: Sequence[str]):
    if srt.nestings:
        n = srt.nestings[-1]
        if isinstance(n, Nesting) and (isinstance(n.mod_type, ActionMODLType) or isinstance(n.mod_type, PossibleActionMODLType)):
            for action_name in action_names:
                if action_name in srt.term.name:
                    return
            raise PDDLValidationError(f"Cannot intend a predicate {srt.term}; you can only intend an action.")

def check_format(formula: Sequence, action_names: Sequence[str]):
    formulas = []
    for fo in formula:
        if isinstance(fo, NOT_MODL) or isinstance(fo, Term):
            formulas.append(fo)
        elif isinstance(fo, Predicate):
            # no predicate should be negated yet, since everything is separated
            if fo.negated:
                raise ValueError("Parsing error. Predicates should not be negated yet, as modalities (including negations) have not yet been applied.")
            formulas.append(fo)
        elif isinstance(fo, ForallCondition):
            formulas.extend(check_format(fo.condition.operands if isinstance(fo.condition, And) else [fo.condition], action_names))
        elif isinstance(fo, Forall):
            formulas.extend(check_format(fo.effect.operands if isinstance(fo.effect, And) else [fo.effect], action_names))
        elif isinstance(fo, And):
            formulas.append(create_and(check_format(fo.operands, action_names)))
        elif isinstance(fo, Not):
            if not isinstance(fo.argument, Predicate) and not isinstance(fo.argument, SeparatedRMLTerm):
                raise PDDLValidationError(f"'Not' was applied to {type(fo.argument)}. 'Not' can only be applied to an SRT or Predicate.")
            formulas.append(cleaned_not(list(check_format([fo.argument], action_names))[0]))
        elif isinstance(fo, When):
            # for formatting/consistency reasons, we want to force this into being an "And"
            condition = create_and(check_format(fo.condition.operands, action_names) if isinstance(fo.condition, And) else check_format([fo.condition], action_names))
            for e in fo.effect.operands if isinstance(fo.effect, And) else [fo.effect]:
                formulas.append(When(condition, create_and(check_format([e], action_names))))
        elif isinstance(fo, SeparatedRMLTerm):
            fo = SeparatedRMLTerm(list(check_format(fo.nestings, action_names)), list(check_format([fo.term], action_names))[0])
            check_intention_error(fo, action_names)
            formulas.append(fo)
        elif isinstance(fo, Nesting):
            if fo.child:
                raise ValueError("Nestings should not yet be nested (stored in a list, not nested with children).")
            formulas.append(Nesting(fo.mod_type, Agent(list(check_format([fo.agent.term], action_names))[0])))
        else:
            raise NotImplementedError("Unknown formula type: " + str(type(fo)))
    return formulas

def check_action_format(action: Action, action_names: Sequence[str]):
    precondition = create_and(check_format(action.precondition.operands, action_names))
    effect = create_and(check_format(action.effect.operands, action_names))
    derive_condition = check_format([action.derive_condition], action_names)[0] if action.derive_condition and isinstance(action.derive_condition, SeparatedRMLTerm) else action.derive_condition
    return Action(action.name, action.parameters, precondition, effect, derive_condition=derive_condition)

def normalize_action_form(action):
    precondition = action.precondition if isinstance(action.precondition, And) else create_and([action.precondition])
    effect = action.effect if isinstance(action.effect, And) else create_and([action.effect])
    # parameters = list(action.parameters)
    # # gather any special derived condition variables (dlr__*) and add them to the parameters list
    # if action.derive_condition:
    #     dc_vars = set()
    #     if isinstance(action.derive_condition, SeparatedRMLTerm):
    #         dc_vars.update([n.agent.term for n in action.derive_condition.nestings if isinstance(n, Nesting)])
    #         dc_vars.update(action.derive_condition.term.terms)
    #     dlr_vars = {v for v in dc_vars if "dlr__" in v.name}
    #     parameters.extend(dlr_vars)
    return Action(action.name, action.parameters, precondition, effect, derive_condition=action.derive_condition)

def apply_and_check_intention(anc_effs, domain, problem):
    # ensure the preconditions and actions are all in "And" form
    actions, action_intention_f = create_itn_action_preds({a.name: a for a in [check_action_format(normalize_action_form(a), [a.name for a in domain.actions]) for a in domain.actions]}, problem, anc_effs)
    domain = pddl_core.Domain(
        name=domain.name,
        requirements=domain.requirements,
        types=domain.types,
        constants=domain.constants,
        predicates=domain.predicates | action_intention_f,
        derived_predicates=domain.derived_predicates,
        functions=domain.functions,
        actions=actions,
        agents=domain.agents
    )
    return domain