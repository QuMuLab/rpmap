from copy import deepcopy
from pddl.logic.predicates import Predicate
from pddl.logic.effects import When


def create_consequent(rml, o):
    new_pred = Predicate(
        o.name,
        *o.terms
    )
    # take the original AK (wouldn't be specified in the RML)
    new_pred.always_known = o.always_known
    # RML negation takes precedence
    new_pred.negated = rml.negated
    # just copy this for now
    new_pred.bdi = deepcopy(o.bdi)
    # the BDI is trickier. if we just have a negation, we are negating the existing BDI.
    # otherwise, we assume we are replacing the whole BDI term.
    if rml.bdi:
        if len(rml.bdi) == 1: # just have negation
            if new_pred.bdi:
                new_pred.bdi[0] = rml.bdi[0]
            else:
                new_pred.bdi = rml.bdi
        else:
            new_pred.bdi = rml.bdi
    return new_pred

def check_rml_format(rml, o) -> bool:
    # when we just have a predicate, we assume the antecedent conditions are empty. however,
    # the RML can still be applied.

    # first, check the bdi. if one of them has bdi but not the other, we know they don't match.
    if (not rml.bdi) ^ (not o.bdi):
        return False
    # if both don't have bdi, just check the negation status
    if not rml.bdi and not o.bdi:
        return rml.negated == o.negated
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
            if anc_eff[2].value in ['negation-removal']:#, 'kd45closure', 'kd45-un-closure']:
                print(anc_eff[2].value)
                anc_eff = anc_eff[3:-1] # remove parentheses and anceff name    
                # parameters are optional
                if anc_eff[0]:
                    params = anc_eff[0][1]
                # antecedent
                ant = anc_eff[1][2:-1]
                ant_pos_cond = ant[0][1]
                ant_neg_cond = ant[1][1]
                ant_rml = ant[3][1]
                ant_cond_type = ant[4][1][0].value
                # consequent
                cons = anc_eff[2][2:-1]
                cons_pos_cond = cons[0][1]
                cons_neg_cond = cons[1][1]
                cons_rml = cons[2][1]
                cons_cond_type = cons[3][1][0].value
            
                for o in action.effect.operands:
                    # check the individual predicate effects against the antecedent format
                    if type(o) is Predicate:
                        if check_rml_format(ant_rml, o):
                            # apply the consequent to the effect
                            new_cons = create_consequent(cons_rml, o)
                            if cons_cond_type == 'del':
                                new_cons.negated = not new_cons.negated
                            action.effect._operands.append(new_cons)
                    elif type(o) is When:
                        # when we have a "When," then the when condition (positive or negative) acts as the antecedent condition
                        # thus we actually have to check the when condition against the pos/neg conditions
                        # then we apply changes to the when effect, which is the consequent
                        if check_rml_format(ant_rml, o.condition):
                            new_cons = create_consequent(cons_rml, o.effect)
                            if cons_cond_type == 'del':
                                new_cons.negated = not new_cons.negated
                            action.effect._operands.append(When(o.condition, new_cons))
                print()
                                
