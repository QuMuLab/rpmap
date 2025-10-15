from pddl.logic.predicates import Predicate
from pddl.logic.effects import When, Forall
from pddl.logic.base import Not

def create_consequent(rml, o):
    new_pred = Predicate(
        o.name,
        *o.terms
    )
    new_pred.always_known = o.always_known
    new_pred.bdi = rml.bdi
    new_pred.negated = rml.negated
    return new_pred

def check_rml_format(rml, o) -> bool:
    # when we just have a predicate, we assume the antecedent conditions are empty. however,
    # the RML can still be applied
    # first, check the bdi. if one of them has bdi but not the other, we know they don't match
    if (rml.bdi == [None]) ^ (o.bdi == [None]):
        return False
    # if both don't have bdi, just check the negation status
    if rml.bdi == [None] and o.bdi == [None]:
        return rml.negated == o.negated
    # if we've gotten to this point, both have bdi
    rml_negated_bdi = rml.bdi[0]
    rml_bdi_body = rml.bdi[1]
    o_negated_bdi = o.bdi[0]
    o_bdi_body = o.bdi[1]
    # we are assuming the parameters are general/don't matter
    del rml_bdi_body[3]
    del o_bdi_body[3]
    return rml_negated_bdi == o_negated_bdi and rml_bdi_body == o_bdi_body and rml.always_known == o.always_known and rml.negated == o.negated

def apply_cond_effs(anc_effs, domain, problem):
    for action in domain._actions:
        for anc_eff in anc_effs._anceffs:
            # first do negation removal
            if anc_eff[2].value in ['negation-removal']:
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
                        # thus we actually have to check the when condition against the rml format.
                        if check_rml_format(ant_rml, o.condition):
                            new_cons = create_consequent(cons_rml, o.effect)
                            if cons_cond_type == 'del':
                                new_cons.negated = not new_cons.negated
                            action.effect._operands.append(When(o.condition, new_cons))

                                
        
