from .core.anc_eff import RMLTerm, PredTerm, RMLTermNegated, PredTermNegated, SeparatedRMLTerm
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import Not
from pddl.logic.effects import When
from copy import deepcopy


def gen_id(cond):
    """Generate a unique ID for a condition based on its string representation."""
    # make it a unique 5-character hash
    import hashlib

    m = hashlib.md5()
    m.update(str(hash(cond)).encode("utf-8"))
    return m.hexdigest()[:8]

def check_ant_format(ant_rml: SeparatedRMLTerm, ant_rml_type: str, next_cond):
    cond = deepcopy(next_cond)
    # compare Not status with the antecedent type status
    if (ant_rml_type == "del" and type(next_cond) is not Not) or (type(next_cond) is Not and ant_rml_type != "del"):
        return False
    # if dealing with a Not statement, we need to compare against the argument.
    if isinstance(next_cond, Not): 
        cond = next_cond.argument
    # if dealing with a When statement, we need to compare against the When effect.
    elif isinstance(next_cond, When):
        cond = next_cond.effect.operands
        if len(cond) > 1:
            raise NotImplementedError("Handle When clauses with plural effects?")
        cond = cond[0]

    if isinstance(ant_rml.term, RMLTerm):
        if ant_rml.nestings:
            # need to check if the antecedent nestings "begin" the cond nestings
            # first check if this is even possible, through length
            if len(ant_rml.nestings) > len(cond.nestings):
                return False
            for i in range(len(ant_rml.nestings)):
                if ant_rml.nestings[i] != cond.nestings[i]:
                    return False
            return True
        # if there's no antecedent nestings, then anything can be matched.
        else:
            return True
    elif isinstance(ant_rml.term, PredTerm):
        if ant_rml.nestings:
            # need to check if the antecedent nestings matches the nestings exactly
            # first check if this is even possible, through length
            if len(ant_rml.nestings) != len(cond.nestings):
                return False
            for i in range(len(ant_rml.nestings)):
                if ant_rml.nestings[i] != cond.nestings[i]:
                    return False
            return True
        else:
            return isinstance(cond.term, Predicate)
    elif isinstance(ant_rml.term, RMLTermNegated):
        print()
    elif isinstance(ant_rml.term, PredTermNegated):
        print()
    else:
        raise PDDLValidationError(f"Unknown Antecedent RML type {type(ant_rml)}")

def apply_cond_eff(anc_effs, o):
    o.id = gen_id(o)
    o.parent = None
    condleft = [o]
    processed_conds = set()
    
    while condleft:
        next_cond = condleft.pop(0)
        if next_cond not in processed_conds:
            processed_conds.add(next_cond)
            for anc_eff in anc_effs:
                if check_ant_format(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_cond):
                    print(f"{next_cond} passed the antecedent {anc_eff.antecedent.rml}")


def apply_cond_effs(anc_effs, domain, problem, effs_to_apply=None):
    anc_effs = {a.name: a for a in anc_effs.anceffs}
    anc_effs_to_apply = (
        [anc_effs[a] for a in anc_effs if a in effs_to_apply]
        if effs_to_apply
        else list(anc_effs.values())
    )
    for action in domain.actions:
        for o in action.effect.operands:
            new_rmls = apply_cond_eff(anc_effs_to_apply, o)