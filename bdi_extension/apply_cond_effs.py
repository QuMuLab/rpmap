from copy import deepcopy
from .anc_eff import NegateOnly, Agent, ModRML
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
        return p

    # @staticmethod
    # def negate_nested(pred):
    #     # if so, now we need to flip everything to apply the negation!
    #     pred.bdi.negate()
    #     for b in pred.bdi.nested:
    #         b.negate()
        # return pred
    
    def merge_bdi(self, mod_p, new_pred, old_p):
        # we only want to nest by adding a NEGATIVE BDI term IF
        # the original BDI term is NOT a belief of the corresponding
        # agent (positive or negative)
        if mod_p.negate_whole_term and mod_p.bdi.agent == new_pred.bdi.agent:
            # need this for the original negation status.
            # in the case where we are modifying a raw RML (rml without the negation
            # status) because the antecedent cond type is "del" and we need to
            # return the original formula, we need to restore the negation status.
            return old_p
        # easiest case, don't need to collapse
        if mod_p.bdi.agent != new_pred.bdi.agent:
            new_nested = [new_pred.bdi, *new_pred.bdi.nested]
            new_pred.bdi = mod_p.bdi
            new_pred.bdi.nested = new_nested
            # first, check if we have a new negation added
            if new_pred.bdi.negate_inner_rml:
                # WOOOOO time to negate by flipping everything???
                # return ApplyCondEff.negate_nested(new_pred)
                new_pred.bdi.negate(True)
            return new_pred
        else:
            # if here, both BDI references the same agent
            # next easiest case, they are equal
            if mod_p.bdi == new_pred.bdi:
                return old_p
            # if we have possible belief then belief, return just the belief
            elif not mod_p.bdi.hard_bdi and new_pred.bdi.hard_bdi:
                return old_p
            # if we have belief then possible belief, return just the possible belief
            elif mod_p.bdi.hard_bdi and not new_pred.bdi.hard_bdi:
                return old_p

    def modify_predicate(self, old_p, mod_p, agent=None):
        """ Assuming both predicates have the same "base,"
        modify the old predicate according to the attributes of the new predicate"""
        mod_p = deepcopy(mod_p)
        new_pred = deepcopy(old_p)
        
        
        # new_pred = Predicate(
        #     old_p.name,
        #     *old_p.terms
        # )
        # # take the original AK (wouldn't be modified)
        # new_pred.always_known = old_p.always_known

        # just copy this for now
        # new_pred.bdi = deepcopy(old_p.bdi)
        # new_pred.negated = old_p.negated
        # we are just passing in the raw RML.
        # if it's negated, that's indicated by the "del"

        # if the antecedent has a type "del," then we only want to
        # pass in the "raw" RML, a.k.a. leave the negation at the door.
        if self.ant_cond_type == 'del':
            new_pred.negated = False
        # new_pred.negated = False 

        # broadest case: we are just negating the whole thing
        if mod_p.negate_whole_term:
            if new_pred.bdi:
                new_pred.bdi.negate()
                # ApplyCondEff.negate_nested(new_pred)                   
            else:
                # if no bdi term, then still remember we are still negating the BDI term,
                # just according to the root agent. so negate the predicate using the
                # "inner" negation.
                new_pred.bdi = NegateOnly(True)
        elif mod_p.bdi:
                if new_pred.bdi:
                    if mod_p.nest:
                        mod_p.bdi.agent = Agent(agent)
                        new_pred = self.merge_bdi(mod_p, new_pred, old_p)
                    else:
                        # we only want to affect the outer BDI
                        new_pred.bdi = deepcopy(mod_p.bdi)
                        new_pred.bdi.agent = deepcopy(old_p.bdi.agent)
                        new_pred.bdi.nested = deepcopy(old_p.bdi.nested)
                else:
                    if new_pred.always_known:
                        # we don't give "always known" predicates BDI terms.
                        # however a negation can still happen!
                        if mod_p.bdi.negate_inner_rml:
                            new_pred.bdi = NegateOnly(True)
                        return new_pred
                    else:
                        mod_p.bdi.agent = Agent(agent)
                        new_pred.bdi = deepcopy(mod_p.bdi)
        elif mod_p.negate_inner_rml:
            if new_pred.bdi:
                new_pred.bdi.negate()
                # ApplyCondEff.negate_nested(new_pred)
            else:
                new_pred.bdi = NegateOnly(True)
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
        new_preds = self.get_pos_or_neg_cond_term(next_cond, matching_lc)

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
                        cond_preds.extend(self.get_pos_or_neg_cond_term(next_cond, 'pos')) 
                        continue 
                    elif term == self.ant_neg_cond[0]:
                        cond_preds.extend(self.get_pos_or_neg_cond_term(next_cond, 'neg')) 
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
            # TODO: when are we checking for these first two cases?
            if self.derived_cond[0] == Token("ALWAYS", "always"):
                return []
            elif self.derived_cond[0] == Token("NEVER", "never"):
                return []
            else:
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
    
    @staticmethod
    def bdi_in_cond(cond):
        if not cond:
            return False
        elif type(cond) is ModRML:
            if cond.bdi and type(cond.bdi) is not NegateOnly:
                return True
        elif type(cond) is list:
            for t in cond:
                check = ApplyCondEff.bdi_in_cond(t)
                if check:
                    return True

    def create_consequent(self, next_cond):
        bdi_in_cons_pos = ApplyCondEff.bdi_in_cond(self.cons_pos_cond)
        bdi_in_cons_neg = ApplyCondEff.bdi_in_cond(self.cons_neg_cond)
        bdi_in_cons_rml = ApplyCondEff.bdi_in_cond(self.cons_rml)
        consequent_preds = []
        if type(next_cond) is When:
            
            if type(next_cond.effect) is not Predicate:
                raise NotImplementedError("Handle complex when effects later?")
            # if we are dealing with a situation where the consequent references an agent parameter
            # and the antecedent doesn't, then this parameter should be iterated through
            # to create separate consequents that reference ALL agents! 
            if not self.ant_rml.bdi and (bdi_in_cons_pos or bdi_in_cons_neg or bdi_in_cons_rml):
                for a in self.agents:
                    cond = self.create_conds(next_cond.condition, a)
                    # also need to do derived conditions here since that might
                    # have a matching agent parameter.
                    if self.need_awareness and self.derived_cond:
                        cond = set(cond + self.get_derived_cond_preds(a))
                    and_cond = And(*[])
                    and_cond._operands.extend(sorted(cond))
                    consequent_preds.append(When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect), a)))
                return consequent_preds
            else:
                base_conds = self.create_conds(next_cond.condition)
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
                        and_cond._operands.extend(sorted(cond))
                        consequent_preds.append(When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect), agent)))
                    return consequent_preds
                else:
                    and_cond = And(*[])
                    and_cond._operands.extend(sorted(base_conds))
                    return [When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect)))]
        else:
            if not self.ant_rml.bdi and (bdi_in_cons_pos or bdi_in_cons_neg or bdi_in_cons_rml):
                for a in self.agents:
                    # we have an empty condition, so don't worry about that
                    # BUT we need to do derived conditions here since that might
                    # have a matching agent parameter.
                    if self.need_awareness and self.derived_cond:
                        cond = set(self.get_derived_cond_preds(a))
                    if cond:
                        if len(cond) == 1:
                            if list(cond)[0] == next_cond:
                                continue
                        and_cond = And(*[])
                        and_cond._operands.extend(sorted(cond))
                        consequent_preds.append(When(and_cond, self.modify_predicate_apply_cond_type(deepcopy(next_cond), a)))
                        raise NotImplementedError("Check if working correctly.")
                    else:
                        consequent_preds.append(self.modify_predicate_apply_cond_type(deepcopy(next_cond), a))
                return consequent_preds
            return [self.modify_predicate_apply_cond_type(deepcopy(next_cond))]

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

        if (not self.ant_rml.bdi and next_cond.bdi) or (not self.ant_rml.bdi and not next_cond.bdi):
            return True

        # if we've gotten to this point, both have bdi.
        # however these could still be different kinds.
        if type(self.ant_rml.bdi) != type(next_cond.bdi):
            return False
        
        # now we can check the full bdi terms, knowing they're the same type.
        # note: we don't care what the agent is, we're just checking for the overall structure
        return self.ant_rml.bdi.negate_inner_rml == next_cond.bdi.negate_inner_rml and \
            self.ant_rml.bdi.hard_bdi == next_cond.bdi.hard_bdi 

def check_nesting(cons, depth):
    if type(cons) is When:
            return check_nesting(cons.condition, depth) and check_nesting(cons.effect, depth)
    elif type(cons) is And:
        for o in cons.operands:
            if not check_nesting(o, depth):
                return False
        return True
    elif type(cons) is Predicate:
        if not cons.bdi or type(cons.bdi) is NegateOnly:
            return True
        else:
            return len(cons.bdi.nested) + 1 <= depth

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
                if anc_eff_data.name not in ["negation-removal", "mutual-awareness-pos", "mutual-awareness-neg"]: # "negation-removal", "kd45-un-closure", "uncertain-firing", 
                    continue
                if anc_eff_data.check_ant_format(next_cond):
                    print(anc_eff_data.name)
                    print(f"next cond: {next_cond}")
                    cons = set(anc_eff_data.create_consequent(deepcopy(next_cond)))
                    for c in cons:
                        if check_nesting(c, depth):
                            if c not in processed_conds and c not in condleft:
                                print(c)
                            condleft.append(c)
                    print("----")
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
