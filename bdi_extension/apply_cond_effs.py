from copy import deepcopy
from lark.lexer import Token
from pddl.logic.base import And
from pddl.logic.predicates import Predicate
from pddl.logic.effects import When
from pddl.logic.terms import Constant


class ApplyCondEff:
    def __init__(self, anc_eff, action, agents, depth, predicates):
        self.derived_cond = action.derive_condition
        self.agents = agents
        self.depth = depth
        self.predicates = predicates
        self.name = anc_eff[2].value
        anc_eff = anc_eff[3:-1] # remove parentheses and anceff name    
        # parameters are optional
        if anc_eff[0]:
            self.params = anc_eff[0][1]
        # antecedent
        ant = anc_eff[1][2:-1]
        # positive and negative conditions are optional
        self.ant_pos_cond = ant[0][1] if ant[0] else ant[0]
        self.ant_neg_cond = ant[1][1] if ant[1] else ant[1]
        self.need_awareness = None
        if ant[2]:
            self.need_awareness = True if ant[2][1].value == "true" else False 
        self.ant_rml = ant[3][1]
        self.ant_cond_type = ant[4][1][0].value
        # consequent
        cons = anc_eff[2][2:-1]
        self.cons_pos_cond = cons[0][1] if cons[0] else cons[0]
        self.cons_neg_cond = cons[1][1] if cons[1] else cons[1]
        self.cons_rml = cons[2][1]
        self.cons_cond_type = cons[3][1][0].value

    def modify_predicate_apply_cond_type(self, old_p, agent=None):
        p = self.modify_predicate(old_p, self.cons_rml, agent)
        if self.cons_cond_type == 'del':
            p.negated = not p.negated
        print(p, "\n")
        return p
    
    def merge_bdi(self, mod_p, new_pred):
        mod_p_bdi = mod_p.bdi[1]
        new_pred_bdi = new_pred.bdi[1]
        # easiest case, don't need to collapse
        if mod_p_bdi[3] != new_pred_bdi[3]:
            new_pred.bdi[1] = mod_p_bdi + new_pred_bdi
            return new_pred
        else:
            # if here, both BDI references the same agent
            # next easiest case, they are equal
            if mod_p_bdi == new_pred_bdi:
                return new_pred
            # if we have possible belief then belief, return just the belief
            elif mod_p_bdi[0].type == "LESSER_OP" and new_pred_bdi[0].type == "LSQB":
                return new_pred
            # if we have belief then possible belief, return just the possible belief
            elif mod_p_bdi[0].type == "LSQB" and new_pred_bdi[0].type == "LESSER_OP":
                return new_pred

    def modify_predicate(self, old_p, mod_p, agent=None):
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
        # new_pred.negated = old_p.negated
        # we are just passing in the raw RML.
        # if it's negated, that's indicated by the "del"
        new_pred.negated = False 

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
                if new_pred.bdi:
                    if mod_p.nest:
                        # TODO: we need to figure out what to do with more complex negations
                        if not new_pred.bdi[0] and not mod_p.bdi[0]:
                            mod_p.bdi[1][3] = Token('NAME', agent)
                            new_pred = self.merge_bdi(mod_p, new_pred)
                    else:
                        new_pred.bdi[0] = deepcopy(mod_p.bdi[0])
                        new_pred.bdi[1][:5] = deepcopy(mod_p.bdi[1])
                        new_pred.bdi[1][3] = old_p.bdi[1][3]
                else:
                    if new_pred.always_known:
                        # we don't give "always known" predicates BDI terms.
                        # however a negation can still happen!
                        if mod_p.bdi[0]:
                            new_pred.bdi = [Token('EXC', '!')]
                        return new_pred
                    else:
                        mod_p.bdi[1][3] = Token('NAME', agent)
                        new_pred.bdi = deepcopy(mod_p.bdi)

        elif mod_p.negate_term:
            if new_pred.bdi:
                if len(new_pred.bdi) > 1:
                    new_pred.bdi[0] = Token('EXC', '!') if not new_pred.bdi[0] else None
                else:
                    new_pred.bdi = None
            else:
                new_pred.bdi = [Token('EXC', '!')]
        return new_pred

    def get_pos_or_neg_cond_term(self, cond, term_type):
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

    def handle_list_comp(self, list_comp_terms, next_cond, agent=None):
        if not self.ant_pos_cond and not self.ant_neg_cond:
            return []
        matching_lc = None
        # check if the positive condition has a matching list comprehension term
        if self.ant_pos_cond:
            if type(self.ant_pos_cond) is list:
                first_cond_term = self.ant_pos_cond[0]
                if type(first_cond_term) is list:
                    if list_comp_terms[4] == first_cond_term[0]:
                        matching_lc = 'pos'
        # if not, check the negative condition
        if not matching_lc and self.ant_neg_cond:
            if type(self.ant_neg_cond) is list:
                first_cond_term = self.ant_neg_cond[0]
                if type(first_cond_term) is list:
                    if list_comp_terms[4] == first_cond_term[0]:
                        matching_lc = 'neg'
        # if neither matches, then we don't know what the list comprehension is referring to
        if not matching_lc:
            raise ValueError("No matching list comprehension term found in antecedent conditions.")
        # if we do have a matching term, we need to construct the new list of predicates
        new_preds = self.get_pos_or_neg_cond_term(next_cond.condition, matching_lc)

        # finally we need to see if any modifications were made to the predicates by looking
        # at the first term of the list comprehension
        for i in range(len(new_preds)):
            new_preds[i] = self.modify_predicate(deepcopy(new_preds[i]), list_comp_terms[0], agent)
        return new_preds

    def get_cond_preds(self, cons_cond, next_cond, agent=None):
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
                            cond_preds.extend(self.handle_list_comp(term[0][2:-1], next_cond, agent))
                            continue
                    # we're referencing an antecedent condition
                    if term == self.ant_pos_cond[0]:
                        cond_preds.extend(self.get_pos_or_neg_cond_term(next_cond.condition, 'pos')) 
                        continue 
                    elif term == self.ant_neg_cond[0]:
                        cond_preds.extend(self.get_pos_or_neg_cond_term(next_cond.condition, 'neg')) 
                        continue   
                # regular recursion            
                cond_preds.extend(self.get_cond_preds(term, next_cond))
        return cond_preds

    def create_cond(self, cons_cond, next_cond, agent=None):
        if cons_cond:
            return self.get_cond_preds(cons_cond, next_cond, agent)
        return None

    def create_conds(self, next_cond, agent=None):
        new_pos_cond = self.create_cond(self.cons_pos_cond, next_cond, agent)
        new_neg_cond = self.create_cond(self.cons_neg_cond, next_cond, agent)

        new_cond = []
        if new_pos_cond:
            new_cond.extend(new_pos_cond)
        if new_neg_cond:
            for c in new_neg_cond:
                c.negated = not c.negated
            new_cond.extend(new_neg_cond)
        return new_cond
    
    def create_dcond_pred(self, index, agent):
        d_par_copy = deepcopy(self.derived_cond)
        d_par_copy[index] = Constant(agent)
        d_par_copy = d_par_copy[1:-1]
        p = Predicate(d_par_copy[0].value, *d_par_copy[1:])
        for dp in self.predicates:
            if p.name == dp.name and len(p.terms) == len(dp.terms):
                p.always_known = dp.always_known
                break
        p.negated = False
        return p
    
    def get_derived_cond_preds(self, agent=None):
        if type(self.derived_cond) is list:
            var = None
            for i in range(len(self.derived_cond)):
                if type(self.derived_cond[i]) is list:
                    if self.derived_cond[i][0].type == "DLR":
                        # TODO: assuming only one var for now
                        var = self.derived_cond[i][1]
                        break
            if var: 
                # just want for a specific agent
                if agent:
                    return [self.create_dcond_pred(i, agent)]
                else:
                    grounded_dconds = []
                    # want for all agents (generic)
                    # need to ground this
                    # TODO: assuming only agents for now
                    # TODO: assuming no bdi terms for now
                    # replace the ith term with the grounded variable
                    for a in self.agents:
                        p = self.create_dcond_pred(i, a)
                        grounded_dconds.append((p, a))
                    return grounded_dconds
                # create a new 
        elif self.derived_cond.value == "ALWAYS":
            pass
        elif self.derived_cond.value == "NEVER":
            return []

    def create_consequent(self, next_cond):
        consequent_preds = []
        if type(next_cond) is When:
            if type(next_cond.effect) is not Predicate:
                raise NotImplementedError("Handle complex when effects later?")
            # if we are dealing with a situation where the consequent references an agent parameter
            # and the antecedent doesn't, then this parameter should be iterated through
            # to create separate consequents that reference ALL agents! 
            if not self.ant_rml.bdi and (type(self.cons_pos_cond) is list or type(self.cons_neg_cond) is list):
                for a in self.agents:
                    cond = self.create_conds(next_cond, a)
                    # also need to do derived conditions here since that might
                    # have a matching agent parameter.
                    if self.need_awareness and self.derived_cond:
                        cond = set(cond + self.get_derived_cond_preds(a))
                    and_cond = And(*[])
                    and_cond._operands.extend(cond)
                    consequent_preds.append(When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect), a)))
                return consequent_preds
            else:
                base_conds = self.create_conds(next_cond)
                derived_cond_preds = None
                if self.need_awareness and self.derived_cond:
                    derived_cond_preds = self.get_derived_cond_preds()
                if derived_cond_preds:
                    for (p, agent) in derived_cond_preds:
                        # for formatting reasons we want to force this into being an "And"
                        cond = set(base_conds + [p])
                        if len(cond) == 1:
                            continue
                        and_cond = And(*[])
                        and_cond._operands.extend(cond)
                        consequent_preds.append(When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect), agent)))
                    return consequent_preds
                else:
                    and_cond = And(*[])
                    and_cond._operands.extend(base_conds)
                    return When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect)))
        else:
            return self.modify_predicate_apply_cond_type(deepcopy(next_cond))

    def check_ant_format(self, next_cond) -> bool:
        """
        When we just have a predicate, we assume the antecedent conditions are empty. however,
        the RML can still be applied, but we have to check the predicate against the RML format.

        When we have a "When," we have to check the when effect against the RML format.

        Another note: it's OK if the RML has no BDI term and the predicate does.
        In that case, the RML functions as a general "catch-all." 
        However, if the RML has a BDI term, then the BDI term is of some relevance,
        and the predicate is expected to match it.
        """
    
        if type(next_cond) is When:
            # check the when effect against the rml 
            next_cond = next_cond.effect
            if type(next_cond) is not Predicate:
                raise NotImplementedError("Handle complex when effects later?")

        # easiest thing to check first is the cond_type.
        # if the cond_type is 'add', but the predicate is negated, 
        # or vice versa, we know it doesn't match.
        if self.ant_cond_type == 'add' and next_cond.negated or self.ant_cond_type == 'del' and not next_cond.negated:
            return False
        
        # explained in the docstring
        if self.ant_rml.bdi and not next_cond.bdi:
            return False
        
        # since we've already checked the outer negation and the inner negation
        # is only relevant if there's a BDI term, then at this point,
        # we can assume the RML is blank if it has no BDI term, e.g. (rml)
        if (not self.ant_rml.bdi and next_cond.bdi) or (not self.ant_rml.bdi and not next_cond.bdi):
            return True

        # if we've gotten to this point, both have bdi.
        # however these could still be different kinds (e.g. just negation vs. full bdi term).
        # let's just check that they're the same length to proceed.
        if len(self.ant_rml.bdi) != len(next_cond.bdi):
            return False
        # now we can check the full bdi terms.
        # we only need to check that the antecedent matches the outermost term!
        rml_negated_bdi = deepcopy(self.ant_rml.bdi[0])
        rml_bdi_body = deepcopy(self.ant_rml.bdi[1])
        o_negated_bdi = deepcopy(next_cond.bdi[0])
        o_bdi_body = deepcopy(next_cond.bdi[1])
        # we are assuming the parameters are general/don't matter
        del rml_bdi_body[3]
        del o_bdi_body[3]
        return rml_negated_bdi == o_negated_bdi and rml_bdi_body == o_bdi_body[:len(rml_bdi_body)]

def check_nesting(cons, depth):
    if type(cons) is When:
            return check_nesting(cons.condition, depth) and check_nesting(cons.effect, depth)
    elif type(cons) is And:
        for o in cons.operands:
            if not check_nesting(o, depth):
                return False
        return True
    elif type(cons) is Predicate:
        if not cons.bdi:
            return True
        else:
            if len(cons.bdi) == 1:
                return True
            return len([t for t in cons.bdi[1] if t in [Token("LSQB", "["), Token("LESSER_OP", "<")]]) <= depth
    print()

def apply_cond_eff(anc_effs, o, action, agents, depth, predicates):
    """Adapted from pdlb.actions.Action._expand."""
    condleft = [o]
    processed_conds = set()
    while condleft:
        next_cond = condleft.pop(0)
        # check the antecedent format
        if next_cond not in processed_conds:
            processed_conds.add(next_cond)
            for anc_eff in anc_effs._anceffs:
                anc_eff_data = ApplyCondEff(anc_eff, action, agents, depth, predicates)
                if anc_eff_data.name not in ["kd45closure", "mutual-awareness-pos", "mutual-awareness-neg"]: # "negation-removal", "kd45-un-closure", "uncertain-firing", 
                    continue
                if anc_eff_data.check_ant_format(next_cond):
                    cons = anc_eff_data.create_consequent(deepcopy(next_cond))
                    check_nesting(cons, depth)
                    if type(cons) is list:
                        for c in cons:
                            if check_nesting(c, depth):
                                condleft.append(c)
                    else:
                        if check_nesting(cons, depth):
                            condleft.append(cons)
    return list(processed_conds - {o}) # already have o

def apply_cond_effs(anc_effs, domain, problem):
    for action in domain._actions:   
        if action.name != "share_a_b_l1":
            continue
        for o in action.effect.operands:
            new_preds = apply_cond_eff(anc_effs, o, action, domain._agents, problem.depth, domain.predicates)
            if new_preds:
                # apply the consequent
                action.effect._operands.extend(new_preds)
        # in case of duplicate effects, remove them
        action.effect._operands = set(action.effect._operands)
