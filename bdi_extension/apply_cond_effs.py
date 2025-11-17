from copy import deepcopy
from .anc_eff import NegateOnly, Agent, ModRML, Belief, Desire, BDI
from lark.lexer import Token
from lark.tree import Tree
from pddl.core import Domain, Problem
from pddl.logic.base import And
from pddl.logic.predicates import Predicate
from pddl.logic.effects import When
from pddl.logic.terms import Constant, Variable


class ApplyCondEff:
    def __init__(self, anc_eff, derive_condition, agents, depth, predicates):
        self.derived_cond = derive_condition
        self.agents = agents
        self.depth = depth
        self.predicates = predicates
        self.assignment = {}
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
        self.ant_rml = ant[3][1][0]
        self.ant_cond_type = ant[4][1][0].value
        # consequent
        cons = anc_eff[2][2:-1]
        self.cons_pos_cond = cons[0][1] if cons[0] else cons[0]
        self.cons_neg_cond = cons[1][1] if cons[1] else cons[1]
        self.cons_rml = cons[2][1:]
        # if len(self.cons_rml) > 1:
        #     self.cons_rml = self.handle_agent_list_comp(self.cons_rml)
        #     for r in self.cons_rml:
        #         print(r.bdi)
        self.cons_cond_type = cons[3][1][0].value

    def modify_predicate_apply_cond_type(self, old_p, agent=None):
        all_preds = []
        for mod in self.cons_rml:
            next_preds = self.gather_preds(mod, old_p, agent)
            for p in next_preds:
                if self.cons_cond_type == 'del':
                    p.negated = not p.negated
            # p = self.modify_predicate(old_p, mod, agent)
            # if self.cons_cond_type == 'del':
            #     p.negated = not p.negated
            all_preds.extend(next_preds)
        return all_preds
    
    @staticmethod
    def nest_bdi(mod_p, new_pred, old_p, simplify=True):
        if simplify:
            # easiest case, they are equal
            if mod_p.bdi == new_pred.bdi:
                return old_p
        new_nested = [new_pred.bdi, *new_pred.bdi.nested]
        new_pred.bdi = mod_p.bdi
        new_pred.bdi.nested = new_nested
        # first, check if we have a new negation added
        if new_pred.bdi.negate_inner_rml:
            # WOOOOO time to negate by flipping everything
            new_pred.bdi.negate(True)
        if simplify:
            # check if they reference the same agents
            if new_pred.bdi.agent == new_pred.bdi.nested[0].agent:
                # if we have possible belief then belief, return just the belief
                if not new_pred.bdi.hard_bdi and new_pred.bdi.nested[0].hard_bdi:
                    new_bdi = new_pred.bdi.nested[0]
                    nested = new_pred.bdi.nested[1:]
                    new_pred.bdi = new_bdi
                    new_pred.bdi.nested = nested
                    return new_pred
                # if we have belief then possible belief, return just the possible belief
                elif new_pred.bdi.hard_bdi and not new_pred.bdi.nested[0].hard_bdi:
                    new_bdi = new_pred.bdi.nested[0]
                    nested = new_pred.bdi.nested[1:]
                    new_pred.bdi = new_bdi
                    new_pred.bdi.nested = nested
                    return new_pred
        return new_pred
    
    @staticmethod
    def merge_bdi(mod_p, new_pred, old_p):
        # we only want to nest by adding a NEGATIVE BDI term IF
        # the original BDI term is NOT a belief of the corresponding
        # agent (positive or negative)
        if mod_p.negate_whole_term and mod_p.bdi.agent == new_pred.bdi.agent:
            # need this for the original negation status.
            # in the case where we are modifying a raw RML (rml without the negation
            # status) because the antecedent cond type is "del" and we need to
            # return the original formula, we need to restore the negation status.
            return old_p
        else:
            return ApplyCondEff.nest_bdi(mod_p, new_pred, old_p)

    def modify_predicate(self, old_p, mod_p, agent=None):
        """ Assuming both predicates have the same "base,"
        modify the old predicate according to the attributes of the new predicate"""
        mod_p = deepcopy(mod_p)
        new_pred = deepcopy(old_p)
        
        if type(new_pred) is And:
            if len(new_pred._operands) == 1:
                new_pred = new_pred._operands[0]

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
                    if type(new_pred.bdi) is NegateOnly and new_pred.always_known:
                        if mod_p.bdi.negate_inner_rml:
                            new_pred.bdi.negate()
                            return new_pred
                        return old_p
                    if mod_p.nest:
                        mod_p.bdi.agent = Agent(agent, False)
                        new_pred = self.merge_bdi(mod_p, new_pred, old_p)
                    else:
                        new_pred.bdi = deepcopy(mod_p.bdi)
                        new_pred.bdi.agent = deepcopy(mod_p.bdi.agent)
                        new_pred.bdi.nested = deepcopy(mod_p.bdi.nested)
                else:
                    if new_pred.always_known:
                        # we don't give "always known" predicates BDI terms.
                        # however a negation can still happen!
                        if mod_p.bdi.negate_inner_rml:
                            new_pred.bdi = NegateOnly(True)
                        return new_pred
                    else:
                        mod_p.bdi.agent = Agent(agent, False)
                        new_pred.bdi = deepcopy(mod_p.bdi)
        # elif mod_p.negate_inner_rml:
        #     if new_pred.bdi:
        #         new_pred.bdi.negate()
        #         # ApplyCondEff.negate_nested(new_pred)
        #     else:
        #         new_pred.bdi = NegateOnly(True)
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
            new_preds = deepcopy(new_preds)
            # note that we want to ignore the negations here and just get the raw RMLs,
            # because they will be re-applied by the :negcond in the consequent if necessary later.
            for i in range (len(new_preds)):
                new_preds[i].negated = False
        return new_preds
    
    def handle_rml_list_comp(self, next_term):
        # recursively iterate through the condition structure
        if type(next_term) is Predicate:
            terms = list(next_term.terms)  
            for i in range(len(terms)):
                if type(terms[i]) is Variable: 
                    terms[i] = Constant(self.assignment[terms[i].name])
            return [Predicate(next_term.name, *terms)]
        elif type(next_term) is ModRML:
            if next_term.bdi:
                if next_term.bdi.agent.var:
                    next_term.bdi.agent = Agent(self.assignment[next_term.bdi.agent.name], False)
                if next_term.bdi.nested:
                    for i in range(len(next_term.bdi.nested)):
                        if next_term.bdi.nested[i].agent.var:
                            next_term.bdi.nested[i].agent = Agent(self.assignment[next_term.bdi.nested[i].agent.name], False)
            return [next_term]
        elif type(next_term) is Token:
            if next_term.type == 'PLUS':
                return []
        elif type(next_term) is list:
            if type(next_term) is list:
                if type(next_term[0]) is list:
                    if next_term[0][0] == "COMPOUND":
                        mod_rmls = []
                        for a in self.agents:
                            rml = deepcopy(next_term[0][2])
                            if rml.bdi.agent.var:
                                if rml.bdi.agent.name == "ag":
                                    rml.bdi.agent = Agent(a, False)
                                else:
                                    rml.bdi.agent = Agent(self.assignment[rml.bdi.agent.name], False)
                            for i in range(len(rml.bdi.nested)):
                                if rml.bdi.nested[i].agent.name == "ag":
                                    rml.bdi.nested[i].agent = Agent(a, False)
                                else:
                                    rml.bdi.nested[i].agent = Agent(self.assignment[rml.bdi.nested[i].agent.name], False)
                            mod_rmls.append(rml)
                        return mod_rmls     
            grounded_terms = []
            for term in next_term:
                grounded_terms.extend(self.handle_agent_list_comp(term))
            return grounded_terms

    def handle_cond_list_comp(self, list_comp_terms, next_cond_or_eff, agent=None):
        if not self.ant_pos_cond and not self.ant_neg_cond:
            return []
        matching_lc = None
        # find the var term by finding the index after "in"
        var_i = 0
        for i in range(len(list_comp_terms)):
            if list_comp_terms[i] == Token("IN", "in"):
                var_i = i + 1
                break
        # check if the positive condition has a matching list comprehension term
        if self.ant_pos_cond:
            if type(self.ant_pos_cond) is list:
                first_cond_term = self.ant_pos_cond[0]
                if type(first_cond_term) is list:
                    if list_comp_terms[var_i] == first_cond_term[0]:
                        matching_lc = 'pos'
        # if not, check the negative condition
        if not matching_lc and self.ant_neg_cond:
            if type(self.ant_neg_cond) is list:
                first_cond_term = self.ant_neg_cond[0]
                if type(first_cond_term) is list:
                    if list_comp_terms[var_i] == first_cond_term[0]:
                        matching_lc = 'neg'
        if matching_lc:
            new_preds =  []
            # if we do have a matching term, we need to construct the new list of predicates
            new_preds.extend(self.get_pos_or_neg_cond_term(next_cond_or_eff, matching_lc))
             # finally we need to see if any modifications were made to the predicates by looking
            # at the first term of the list comprehension
            for i in range(len(new_preds)):
                new_preds[i] = self.modify_predicate(deepcopy(new_preds[i]), list_comp_terms[0], agent)
            return new_preds
        else:
            if list_comp_terms[var_i].value == "agents":
                new_preds = []
                for a in self.agents:
                    rml = deepcopy(list_comp_terms[0])
                    if rml.bdi.agent.var:
                        if rml.bdi.agent.name == "ag":
                            rml.bdi.agent = Agent(a, False)
                        else:
                            rml.bdi.agent = Agent(self.assignment[rml.bdi.agent.name], False)
                    for i in range(len(rml.bdi.nested)):
                        if rml.bdi.nested[i].agent.name == "ag":
                            rml.bdi.nested[i].agent = Agent(a, False)
                        else:
                            rml.bdi.nested[i].agent = Agent(self.assignment[rml.bdi.nested[i].agent.name], False)
                    
                    new_preds.append(self.modify_predicate(deepcopy(next_cond_or_eff), rml, agent))
                return new_preds     
            else:
                # if no matches, then we don't know what the list comprehension is referring to
                raise ValueError("No matching list comprehension term found in antecedent conditions.")

       

    def gather_preds(self, cons_cond_or_rml, next_cond_or_eff, agent=None):
        # recursively iterate through the condition structure
        if type(cons_cond_or_rml) is Tree:
            return self.gather_preds(cons_cond_or_rml.children, next_cond_or_eff, agent)
        elif type(cons_cond_or_rml) is Predicate:
            terms = list(cons_cond_or_rml.terms)  
            for i in range(len(terms)):
                if type(terms[i]) is Variable: 
                    terms[i] = Constant(self.assignment[terms[i].name])
            return [Predicate(cons_cond_or_rml.name, *terms)]
        elif type(cons_cond_or_rml) is ModRML:
            rml = deepcopy(cons_cond_or_rml)
            if rml.bdi.agent:
                if rml.bdi.agent.var:
                    if rml.bdi.agent.name in self.assignment:
                        rml.bdi.agent = Agent(self.assignment[rml.bdi.agent.name], False)
            for i in range(len(rml.bdi.nested)):
                if rml.bdi.nested[i].agent:
                    if rml.bdi.nested[i].agent.var:
                        if rml.bdi.nested[i].agent.name in self.assignment:
                            rml.bdi.nested[i].agent = Agent(self.assignment[rml.bdi.nested[i].agent.name], False)
            return [self.modify_predicate(next_cond_or_eff, rml, agent)]
        elif type(cons_cond_or_rml) is Token:
            if cons_cond_or_rml.type == 'PLUS':
                return []
        elif type(cons_cond_or_rml) is list:
            cond_preds = []
            for term in cons_cond_or_rml:
                if type(term) is list:
                    if term[0] == "COMPOUND":
                        # we're dealing with a list comprehension
                        cond_preds.extend(self.handle_cond_list_comp(term[2:-1], next_cond_or_eff, agent))
                        continue
                    # we're referencing an antecedent condition
                    if term == self.ant_pos_cond[0]:
                        cond_preds.extend(self.get_pos_or_neg_cond_term(next_cond_or_eff, 'pos')) 
                        continue 
                    elif term == self.ant_neg_cond[0]:
                        cond_preds.extend(self.get_pos_or_neg_cond_term(next_cond_or_eff, 'neg')) 
                        continue   
                # regular recursion            
                cond_preds.extend(self.gather_preds(term, next_cond_or_eff, agent))
            return cond_preds

    def create_cond(self, cons_cond, next_cond, agent=None):
        if cons_cond:
            return self.gather_preds(cons_cond, next_cond, agent)
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
            if self.derived_cond[0] == Token("ALWAYS", "always"):
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
            return False 

    def create_consequent(self, next_cond):
        bdi_in_cons_pos = ApplyCondEff.bdi_in_cond(self.cons_pos_cond)
        bdi_in_cons_neg = ApplyCondEff.bdi_in_cond(self.cons_neg_cond)
        bdi_in_cons_rml = ApplyCondEff.bdi_in_cond(self.cons_rml)
        consequent_preds = []
        if type(next_cond) is When:
            if type(next_cond.effect) is And:
                if len(next_cond.effect._operands) == 1:
                    next_cond = When(next_cond.condition, next_cond.effect._operands[0])
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
                    if self.need_awareness:
                        if self.derived_cond[0] != Token("NEVER", "never"):
                            cond = set(cond + self.get_derived_cond_preds(a))
                        else:
                            return []
                    and_cond = And(*[])
                    and_cond._operands.extend(sorted(cond))
                    eff = self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect), a)
                    # and_eff = And(*[])
                    # and_eff._operands.extend(sorted(eff))
                    consequent_preds.append(When(and_cond, And(*eff)))
                return consequent_preds
            else:
                base_conds = self.create_conds(next_cond.condition)
                derived_cond_preds = None
                if self.need_awareness:
                    if self.derived_cond[0] != Token("NEVER", "never"):
                        derived_cond_preds = self.get_derived_cond_preds()
                    else:
                        return []
                if derived_cond_preds:
                    for (p, agent) in derived_cond_preds:
                        # for formatting reasons we want to force this into being an "And"
                        cond = set(base_conds + [p])
                        if len(cond) == 1:
                            continue
                        and_cond = And(*[])
                        and_cond._operands.extend(sorted(cond))
                        eff = self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect), agent)
                        # and_eff = And(*[])
                        # and_eff._operands.extend(sorted(eff))
                        consequent_preds.append(When(and_cond, And(*eff)))
                    return consequent_preds
                else:
                    and_cond = And(*[])
                    and_cond._operands.extend(sorted(base_conds))
                    eff = self.modify_predicate_apply_cond_type(deepcopy(next_cond.effect))
                    # and_eff = And(*[])
                    # and_eff._operands.extend(sorted(eff))
                    return [When(and_cond, And(*eff))]
        else:
            if not self.ant_rml.bdi and (bdi_in_cons_pos or bdi_in_cons_neg or bdi_in_cons_rml):
                for a in self.agents:
                    # we have an empty condition, so don't worry about that
                    # BUT we need to do derived conditions here since that might
                    # have a matching agent parameter.                
                    cond = None
                    if self.derived_cond:    
                        if self.need_awareness:
                            if self.derived_cond[0] != Token("NEVER", "never"):
                                cond = set(self.get_derived_cond_preds(a))
                            else:
                                return []
                    if cond:
                        if len(cond) == 1:
                            if list(cond)[0] == next_cond:
                                continue
                        and_cond = And(*[])
                        and_cond._operands.extend(sorted(cond))
                        eff = self.modify_predicate_apply_cond_type(deepcopy(next_cond), a)
                        # and_eff = And(*[])
                        # and_eff._operands.extend(sorted(eff))
                        consequent_preds.append(When(and_cond, And(*eff)))
                        raise NotImplementedError("Check if working correctly.")
                    else:
                        consequent_preds.extend(self.modify_predicate_apply_cond_type(deepcopy(next_cond), a))
                return consequent_preds
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
        if type(next_cond) is And:
                if len(next_cond._operands) == 1:
                    next_cond = next_cond._operands[0]
        elif type(next_cond) is When:
            # check the when effect against the rml 
            next_cond = next_cond.effect
            if type(next_cond) is And:
                if len(next_cond._operands) == 1:
                    next_cond = next_cond._operands[0]
            if type(next_cond) is not Predicate:
                # TODO: we now do have when formulas with effects with multiple predicates.
                # but let's handle that later
                return False
                # raise NotImplementedError("Handle complex when effects later?")

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
        
        # need to check the nested terms as well
        if len(self.ant_rml.bdi.nested) != len(next_cond.bdi.nested):
            return False
        
        # now we can check the full bdi terms, knowing they're the same type.
        # note: we don't care what the agent is, we're just checking for the overall structure
        if self.ant_rml.bdi.negate_inner_rml == next_cond.bdi.negate_inner_rml and \
            self.ant_rml.bdi.hard_bdi == next_cond.bdi.hard_bdi:
                for i in range(len(self.ant_rml.bdi.nested)):
                    if type(self.ant_rml.bdi.nested[i]) != type(next_cond.bdi.nested[i]) or \
                    self.ant_rml.bdi.nested[i].negate_inner_rml != next_cond.bdi.nested[i].negate_inner_rml or \
                    self.ant_rml.bdi.nested[i].hard_bdi != next_cond.bdi.nested[i].hard_bdi:
                        return False
        else:            
            return False
        # gather the assignments
        self.assignment[self.ant_rml.bdi.agent.name] = next_cond.bdi.agent.name
        for i in range(len(self.ant_rml.bdi.nested)):
            self.assignment[self.ant_rml.bdi.nested[i].agent.name] = next_cond.bdi.nested[i].agent.name
        return True

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

def apply_cond_eff(anc_effs, o, derive_condition, agents, depth, predicates, effs_to_apply=None):
    """Adapted from pdlb.actions.Action._expand."""
    condleft = [o]
    processed_conds = set()
    anc_effs_to_apply = [a for a in anc_effs if a[2].value in effs_to_apply] if effs_to_apply else anc_effs
    while condleft:
        next_cond = condleft.pop(0)
        # check the antecedent format
        if next_cond not in processed_conds:
            processed_conds.add(next_cond)
            for anc_eff in anc_effs_to_apply:
                anc_eff_data = ApplyCondEff(anc_eff, derive_condition, agents, depth, predicates)
                # if anc_eff_data.name not in ["negation-removal", "kd45closure__belief", "kd45-un-closure__belief", "uncertain-firing", "mutual-awareness-pos__belief", "mutual-awareness-neg__belief"]:#"negation-removal", "kd45-un-closure", "uncertain-firing", 
                #     continue
                if anc_eff_data.check_ant_format(next_cond):
                    print(anc_eff_data.name)
                    print(f"next cond: {next_cond}")
                    cons = anc_eff_data.create_consequent(deepcopy(next_cond))
                    # cons = list(set(cons))
                    # remove extraneous BDI terms) 
                    for i in range(len(cons)):
                        if type(cons[i]) is When:
                            cond = set([remove_extra_bdi(c) for c in cons[i].condition.operands])
                            and_cond = And(*[])
                            and_cond._operands.extend(sorted(cond))
                            eff = set([remove_extra_bdi(c) for c in cons[i].effect.operands]) if type(cons[i].effect) is And else remove_extra_bdi(cons[i].effect)
                            # and_eff = And(*[])
                            # and_eff._operands.extend(sorted(cond))
                            cons[i] = When(and_cond, And(*eff))
                        else:
                            cons[i] = remove_extra_bdi(cons[i])
                    for c in cons:
                        if check_nesting(c, depth):
                            if c not in processed_conds and c not in condleft:
                                print(c)
                            condleft.append(c)
                    print("----")
    return list(processed_conds - {o}) # already have o

def remove_extra_bdi(term):
    if term:
        if type(term.bdi) is NegateOnly:
            if not term.bdi.negate_inner_rml:
                if not term.bdi.nested:
                    term.bdi = None
                else:
                    new_nested = deepcopy(term.bdi.nested[1:])
                    term.bdi = deepcopy(term.bdi.nested[0])
                    term.bdi.nested = new_nested
    return term

def all_rmls(domain, depth):
    # we just said screw it here and compared the strings because of set hashing issues.
    all_rmls = set()
    curr = [deepcopy(p) for p in domain.predicates]

    for d in range(1, depth + 1):

        # Generate raw expansions
        raw = []
        for ag in domain._agents:
            agent = Agent(ag, False)
            for rml in curr:

                # ---- generate BDI variants ----
                variants = []

                if d == 1:
                    x = deepcopy(rml)
                    x.bdi = NegateOnly(True)
                    variants.append(x)

                if not rml.always_known:
                    for typ in (Belief, Desire):
                        for neg in (False, True):
                            for hard in (True, False):
                                x = deepcopy(rml)
                                x.bdi = typ(negate_inner_rml=neg, hard_bdi=hard, agent=agent)
                                variants.append(x)

                # ---- nesting rules ----
                if rml.bdi:
                    for v in variants:
                        base = deepcopy(rml)
                        if isinstance(base.bdi, NegateOnly):
                            if base.bdi.negate_inner_rml:
                                v.bdi.negate()
                            raw.append(v)
                        else:
                            raw.append(ApplyCondEff.nest_bdi(v, base, base, False))
                else:
                    raw.extend(variants)

        # ---- dedupe via signature BEFORE canonicalization ----
        seen = set()
        next_layer = []

        for item in raw:
            # canonicalize internal structure but do NOT mutate later
            cleaned = remove_extra_bdi(item)
            sig = str(cleaned)
            if sig not in seen:
                seen.add(sig)
                next_layer.append(cleaned)

        curr = next_layer
        for r in curr:
            all_rmls.add(r)
    all_rmls.update(domain.predicates)
    return all_rmls

def apply_cond_effs(anc_effs, domain, problem):
    if type(anc_effs) is list:
        new_anc_effs = []
        for e in anc_effs:
            new_anc_effs.extend(e._anceffs)
        anc_effs = new_anc_effs
    else:
        anc_effs = anc_effs._anceffs
    depth = int(problem.depth[2].value)
    for action in domain.actions:   
        # if action.name != "share_a_b_l1":
        #     continue
        for o in action.effect.operands:
            new_preds = apply_cond_eff(anc_effs, o, action.derive_condition, domain._agents, depth, domain.predicates)
            if new_preds:
                # apply the consequent
                action.effect._operands.extend(new_preds)
        # in case of duplicate effects, remove them
        action.effect._operands = set(action.effect._operands)

    # we also need to get all rmls for the predicates
    predicates = all_rmls(domain, depth)

    init = set(problem.init)

    for p in problem.init:
        new_preds = apply_cond_eff(anc_effs, p, None, domain._agents, depth, domain.predicates, ["kd45closure"])
        if new_preds:
            for n in new_preds:
                if not n.negated:
                    init.add(n)
    if problem.init_type[2].value == "complete":
        to_add = set()
        # also need to close omniscience of the root agent
        for rml in predicates:
            if rml.bdi:
                if rml.bdi.hard_bdi == False: # need to check False specifically, not None
                    rml_neg = deepcopy(rml)
                    rml_neg.bdi.negate()
                    # have to do this instead of using "rml_neg in init" because of a weird
                    # hash bug relating to mutability...
                    # TODO: fix this with a cleaner solution later?
                    if not any(rml_neg == p for p in init):
                        to_add.add(rml)
        init.update(to_add)
    goal = set(problem.goal._operands) if type(problem.goal) is And else set(problem.goal)
    for p in goal:
        goal.update(apply_cond_eff(anc_effs, p, None, domain._agents, depth, domain.predicates, ["kd45closure"]))

    and_goal = And(*[])
    and_goal._operands.extend(goal)

    domain = Domain(
        name=domain.name, 
        requirements=domain.requirements, 
        types=domain.types, 
        constants=domain.constants, 
        predicates=predicates,
        derived_predicates=domain.derived_predicates, 
        functions=domain.functions, 
        actions=domain.actions, 
        agents=domain._agents)

    problem = Problem(
        name=domain.name,
        domain_name=domain.name,
        requirements=problem.requirements,
        objects=problem.objects,
        init=init,
        goal=and_goal,
        depth=int(problem.depth[2].value),
        task=problem.task[2].value,
        init_type=problem.init_type[2].value,
        plan=problem.plan,
        projection=problem.projection
    )

    return domain, problem