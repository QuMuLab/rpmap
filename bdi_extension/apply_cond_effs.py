from copy import deepcopy
from lark.lexer import Token
from pddl.logic.base import And
from pddl.logic.predicates import Predicate
from pddl.logic.effects import When

def handle_list_comp(list_comp_terms):
    pass

def create_cond(ant_pos_cond, ant_neg_cond, cons_cond):
    # iterate through the positive consequent condition
    new_cond = []
    for term in cons_cond:
        if type(term) is list:
            for token in term:
                if token == "COMPOUND":
                    continue
                if token.type == "LCRL":
                    # we're in a list comp
                    new_cond.extend(handle_list_comp(term[2:-1]))
                    break
        if type(term) is Token:
            if term.type == "PLUS":
                pass
        if type(term) is Predicate:
            new_cond.append(term)
    return And(*new_cond)

def create_conds(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond):
    new_pos_cond = create_cond(ant_pos_cond, ant_neg_cond, cons_pos_cond) if ant_pos_cond != cons_pos_cond else ant_pos_cond
    new_neg_cond = create_cond(ant_pos_cond, ant_neg_cond, cons_neg_cond) if ant_neg_cond != cons_neg_cond else ant_neg_cond
    return new_pos_cond, new_neg_cond

def create_consequent(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond, cons_rml, cons_cond_type, o):
    if type(o) is When:
        new_pos_cond, new_neg_cond = create_conds(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond)
        # TODO: create new condition from these, and return a When formula
        o = o.effect
        if type(o) is not Predicate:
            raise NotImplementedError("Handle complex when effects later?")

    new_pred = Predicate(
        o.name,
        *o.terms
    )
    # take the original AK (wouldn't be specified in the RML)
    new_pred.always_known = o.always_known
    if cons_cond_type == 'del':
        new_pred.negated = not new_pred.negated
    # just copy this for now
    new_pred.bdi = deepcopy(o.bdi)
    # the BDI is trickier. if we just have a negation, we are negating the existing BDI.
    # otherwise, we assume we are replacing the whole BDI term.
    if cons_rml.bdi:
        if len(cons_rml.bdi) == 1: # just have negation
            if new_pred.bdi:
                new_pred.bdi[0] = cons_rml.bdi[0]
            else:
                new_pred.bdi = cons_rml.bdi
        else:
            new_pred.bdi = cons_rml.bdi

    
    return new_pred

def check_ant_format(rml, cond_type, o) -> bool:
    """
    When we just have a predicate, we assume the antecedent conditions are empty. however,
    the RML can still be applied, but we have to check the predicate against the RML format.

    When we have a "When," we have to check the when effect against the RML format.

    Another note: it's OK if the RML has no BDI term and the predicate does.
    In that case, the RML functions as a general "catch-all." 
    However, if the RML has a BDI term, then the BDI term is of some relevance,
    and the predicate is expected to match it.
    """
   
    if type(o) is When:
        # check the when effect against the rml 
        o = o.effect
        if type(o) is not Predicate:
            raise NotImplementedError("Handle complex when effects later?")

    # easiest thing to check first is the cond_type.
    # if the cond_type is 'add', but the predicate is negated, 
    # or vice versa, we know it doesn't match.
    if cond_type == 'add' and o.negated or cond_type == 'del' and not o.negated:
        return False
    
    # explained in the docstring
    if rml.bdi and not o.bdi:
        return False
    
    # since we've already checked the outer negation and the inner negation
    # is only relevant if there's a BDI term, then at this point,
    # we can assume the RML is blank if it has no BDI term, e.g. (rml)
    if (not rml.bdi and o.bdi) or (not rml.bdi and not o.bdi):
        return True

    # if we've gotten to this point, both have bdi.
    # however these could still be different kinds (e.g. just negation vs. full bdi term).
    # let's just check that they're the same length to proceed.
    if len(rml.bdi) != len(o.bdi):
        return False
    # now we can check the full bdi terms.
    rml_negated_bdi = deepcopy(rml.bdi[0])
    rml_bdi_body = deepcopy(rml.bdi[1])
    o_negated_bdi = deepcopy(o.bdi[0])
    o_bdi_body = deepcopy(o.bdi[1])
    # we are assuming the parameters are general/don't matter
    del rml_bdi_body[3]
    del o_bdi_body[3]
    return rml_negated_bdi == o_negated_bdi and rml_bdi_body == o_bdi_body and rml.always_known == o.always_known and rml.negated == o.negated

def apply_cond_effs(anc_effs, domain, problem):
    for action in domain._actions:
        for anc_eff in anc_effs._anceffs:
            # first do negation removal
            if anc_eff[2].value in ['uncertain-firing']:#['negation-removal', 'kd45closure', 'kd45-un-closure']:
                print(anc_eff[2].value)
                anc_eff = anc_eff[3:-1] # remove parentheses and anceff name    
                # parameters are optional
                if anc_eff[0]:
                    params = anc_eff[0][1]
                # antecedent
                ant = anc_eff[1][2:-1]
                # positive and negative conditions are optional
                ant_pos_cond = ant[0][1] if ant[0] else ant[0]
                ant_neg_cond = ant[1][1] if ant[1] else ant[1]
                ant_rml = ant[3][1]
                ant_cond_type = ant[4][1][0].value
                # consequent
                cons = anc_eff[2][2:-1]
                cons_pos_cond = cons[0][1] if cons[0] else cons[0]
                cons_neg_cond = cons[1][1] if cons[1] else cons[1]
                cons_rml = cons[2][1]
                cons_cond_type = cons[3][1][0].value
            
                for o in action.effect.operands:
                    # check the antecedent format
                    if check_ant_format(ant_rml, ant_cond_type, o):
                        # apply the consequent
                        action.effect._operands.append(create_consequent(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond, cons_rml, cons_cond_type, o))
