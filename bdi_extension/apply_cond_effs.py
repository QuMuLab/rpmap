from copy import deepcopy
from lark.lexer import Token
from pddl.logic.base import And
from pddl.logic.predicates import Predicate
from pddl.logic.effects import When


def modify_predicate_apply_cond_type(old_p, mod_p, cond_type):
    p = modify_predicate(old_p, mod_p)
    if cond_type == 'del':
        p.negated = not p.negated
    print(p, "\n")
    return p

def modify_predicate(old_p, mod_p):
    """ Assuming both predicates have the same "base,"
    modify the old predicate according to the attributes of the new predicate"""
    print(old_p)
    new_pred = Predicate(
        old_p.name,
        *old_p.terms
    )
    # take the original AK (wouldn't be modified)
    new_pred.always_known = old_p.always_known

    # just copy this for now
    new_pred.bdi = deepcopy(old_p.bdi)
    new_pred.negated = old_p.negated

    # broadest case: we are just negating the whole thing
    if mod_p.negate_whole_f:
        if new_pred.bdi:
            if len(new_pred.bdi) > 1: # have a full BDI term
                # need to negate carefully according to the theory
                # check if we're dealing with belief or possible belief
                if new_pred.bdi[1][0].type == "LSQB":
                    new_pred.bdi = [
                        Token('EXC', '!') if not new_pred.bdi[0] else None,
                        [
                            Token('LESSER_OP', '<'),
                            [Token('BELIEF', 'b')],
                            Token('COMMA', ','),
                            Token('NAME', new_pred.bdi[1][3].value),
                            Token('GREATER_OP', '>')
                        ]
                    ]
                else:
                    new_pred.bdi = [
                        Token('EXC', '!') if not new_pred.bdi[0] else None,
                        [
                            Token('LSQB', '['),
                            [Token('BELIEF', 'b')],
                            Token('COMMA', ','),
                            Token('NAME', new_pred.bdi[1][3].value),
                            Token('RSQB', ']')
                        ]
                    ]
            else:
                # only have a negation, just negate that
                new_pred.bdi = None
        else:
            # if no bdi term, then still remember we are negating *belief*,
            # just according to the root agent. so negate the predicate using the
            # "inner" negation.
            new_pred.bdi = [Token('EXC', '!')]
    elif mod_p.bdi:
        new_pred.bdi = deepcopy(mod_p.bdi)
        new_pred.bdi[1][3] = old_p.bdi[1][3]
        # TODO: actually check parameters here?
        # right now we're just assuming one agent
    elif mod_p.negate_term:
        if new_pred.bdi:
            if len(new_pred.bdi) > 1:
                new_pred.bdi[0] = Token('EXC', '!') if not new_pred.bdi[0] else None
            else:
                new_pred.bdi = None
        else:
            new_pred.bdi = [Token('EXC', '!')]
    return new_pred

def get_pos_or_neg_cond_term(cond, term_type):
    new_preds = []
    if term_type == 'pos':
        # note: since we have a condition, we assume we're working with a When
        # we need to grab all predicates that are not negated
        if type(cond) is And:
            new_preds = [p for p in cond.operands if p.negated == False]
        else:
            if cond.negated == False:
                new_preds = [cond]
    else:
        if type(cond) is And:
            new_preds = [p for p in cond.operands if p.negated == True]
        else:
            if cond.negated == True:
                new_preds = [cond]
    return new_preds

def handle_list_comp(ant_pos_cond, ant_neg_cond, list_comp_terms, o):
    if not ant_pos_cond and not ant_neg_cond:
        return []
    matching_lc = None
    # check if the positive condition has a matching list comprehension term
    if ant_pos_cond:
        if type(ant_pos_cond) is list:
            first_cond_term = ant_pos_cond[0]
            if type(first_cond_term) is list:
                if list_comp_terms[4] == first_cond_term[0]:
                    matching_lc = 'pos'
    # if not, check the negative condition
    if not matching_lc and ant_neg_cond:
        if type(ant_neg_cond) is list:
            first_cond_term = ant_neg_cond[0]
            if type(first_cond_term) is list:
                if list_comp_terms[4] == first_cond_term[0]:
                    matching_lc = 'neg'
    # if neither matches, then we don't know what the list comprehension is referring to
    if not matching_lc:
        raise ValueError("No matching list comprehension term found in antecedent conditions.")
    # if we do have a matching term, we need to construct the new list of predicates
    new_preds = get_pos_or_neg_cond_term(o.condition, matching_lc)

    # finally we need to see if any modifications were made to the predicates by looking
    # at the first term of the list comprehension
    for i in range(len(new_preds)):
        new_preds[i] = modify_predicate(new_preds[i], list_comp_terms[0])
    return new_preds

def get_cond_preds(ant_pos_cond, ant_neg_cond, cons_cond, o):
    # recursively iterate through the condition structure
    if type(cons_cond) is Predicate:   
        return [cons_cond]
    elif type(cons_cond) is Token:
        if cons_cond.type == 'PLUS':
            return []

    elif type(cons_cond) is list:
        cond_preds = []
        for term in cons_cond:
            if type(term) is list:
                if type(term[0]) is list:
                    if term[0][0] == "COMPOUND":
                        # we're dealing with a list comprehension
                        cond_preds.extend(handle_list_comp(ant_pos_cond, ant_neg_cond, term[0][2:-1], o))
                        continue
                # we're referencing an antecedent condition
                if term == ant_pos_cond[0]:
                    cond_preds.extend(get_pos_or_neg_cond_term(o.condition, 'pos')) 
                    continue 
                elif term == ant_neg_cond[0]:
                    cond_preds.extend(get_pos_or_neg_cond_term(o.condition, 'neg')) 
                    continue   
            # regular recursion            
            cond_preds.extend(get_cond_preds(ant_pos_cond, ant_neg_cond, term, o))
    return cond_preds

def create_cond(ant_pos_cond, ant_neg_cond, cons_cond, o):
    if cons_cond:
        return get_cond_preds(ant_pos_cond, ant_neg_cond, cons_cond, o)
    return None

def create_conds(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond, o):
    new_pos_cond = create_cond(ant_pos_cond, ant_neg_cond, cons_pos_cond, o)
    new_neg_cond = create_cond(ant_pos_cond, ant_neg_cond, cons_neg_cond, o)

    new_cond = []
    if new_pos_cond:
        new_cond.extend(new_pos_cond)
    if new_neg_cond:
        for c in new_neg_cond:
            c.negated = not c.negated
        new_cond.extend(new_neg_cond)
    # note: we assume we have at least some condition, because this is being called
    # to create consequent conditions for a When formula, which must have some condition
    # for formatting reasons we want to force this into being an "And"
    and_term = And(*[])
    and_term._operands.extend(new_cond)
    return and_term

def create_consequent(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond, cons_rml, cons_cond_type, o):
    if type(o) is When:
        cond = create_conds(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond, o)
        # return a When formula
        if type(o.effect) is not Predicate:
            raise NotImplementedError("Handle complex when effects later?")
        f = When(cond, modify_predicate_apply_cond_type(o.effect, cons_rml, cons_cond_type)) 
        return f   
    return modify_predicate_apply_cond_type(o, cons_rml, cons_cond_type)

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
    return rml_negated_bdi == o_negated_bdi and rml_bdi_body == o_bdi_body

def apply_cond_eff(ant_pos_cond, ant_neg_cond, ant_rml, ant_cond_type, cons_pos_cond, cons_neg_cond, cons_rml, cons_cond_type, o):
    """Adapted from pdlb.actions.Action._expand."""
    condleft = [o]
    processed_conds = set()
    while condleft:
        next_cond = condleft.pop(0)
        # check the antecedent format
        # TODO: need to check against ALL antecedent formats, not just the most recent
        if next_cond not in processed_conds:
            processed_conds.add(next_cond)
            if check_ant_format(ant_rml, ant_cond_type, next_cond):
                condleft.append(create_consequent(ant_pos_cond, ant_neg_cond, cons_pos_cond, cons_neg_cond, cons_rml, cons_cond_type, deepcopy(next_cond)))
    return list(processed_conds - {o}) # already have o

def apply_cond_effs(anc_effs, domain, problem):
    for action in domain._actions:
        if action.name == "share_a_b_l1":
            print()
        for anc_eff in anc_effs._anceffs:
            # first do negation removal
            if anc_eff[2].value in ['uncertain-firing', 'negation-removal', 'kd45closure', 'kd45-un-closure']:

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
                    new_preds = apply_cond_eff(ant_pos_cond, ant_neg_cond, ant_rml, ant_cond_type,
                                             cons_pos_cond, cons_neg_cond, cons_rml, cons_cond_type, o)
                    if new_preds:
                        # apply the consequent
                        action.effect._operands.extend(new_preds)
        # in case of duplicate effects, remove them
        action.effect._operands = set(action.effect._operands)
