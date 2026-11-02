import pddl.core as pddl_core
from pddl.action import Action
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import And, Not, ForallCondition
from pddl.logic.effects import Forall, When
from pddl.logic.predicates import Predicate
from pddl.logic.terms import Constant, Variable
from .core.anc_eff import ActionMODLType, PossibleActionMODLType, NOT_MODL, Agent, RMLOrPredTerm, ListCompVar, ListCompAgents, ListCompVarAgents, Nesting, SeparatedRMLTerm, MODLTermWNesting
from .utils import create_and


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

def normalize_action_form(action):
    precondition = action.precondition if isinstance(action.precondition, And) else create_and([action.precondition])
    effect = action.effect if isinstance(action.effect, And) else create_and([action.effect])
    return Action(action.name, action.parameters, precondition, effect, derive_condition=action.derive_condition)

def apply_action_modls(anc_effs, domain, problem):
    # ensure the preconditions and actions are all in "And" form
    actions, action_intention_f = create_itn_action_preds({a.name: a for a in [normalize_action_form(a) for a in domain.actions]}, problem, anc_effs)
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