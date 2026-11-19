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


def create_itn_action_preds(operators, predicates_dict):
    for i in range(len(operators)):
        if operators[i].name in predicates_dict:
            action_iap = SeparatedRMLTerm([NOT_MODL(), Nesting(PossibleActionMODLType.PITN, Agent(Variable("itn_ag", ["agent"])))], predicates_dict[operators[i].name])
            operators[i] = Action(operators[i].name, operators[i].parameters, operators[i].precondition, create_and(list(operators[i].effect.operands) + [action_iap]), derive_condition=operators[i].derive_condition)
    return set(operators)

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
    return Action(action.name, action.parameters, precondition, effect, derive_condition=action.derive_condition)

def apply_and_check_intention(domain):
    # ensure the preconditions and actions are all in "And" form
    actions = create_itn_action_preds([check_action_format(normalize_action_form(a), [o.name for o in domain.actions]) for a in domain.actions], {p.name: p for p in domain.predicates})
    domain = pddl_core.Domain(
        name=domain.name,
        requirements=domain.requirements,
        types=domain.types,
        constants=domain.constants,
        predicates=domain.predicates,
        derived_predicates=domain.derived_predicates,
        functions=domain.functions,
        actions=actions,
        agents=domain.agents
    )
    return domain