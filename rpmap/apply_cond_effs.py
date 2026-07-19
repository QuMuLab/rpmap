from copy import deepcopy
from .core.anc_eff import MODL, NegateOnly, Agent, ModRML, GenericModality, GenericMODLType
from .parsing_utils import create_valuations
from itertools import product
from lark.lexer import Token
from lark.tree import Tree
from pddl.core import Domain, Problem
from pddl.logic.base import And
from pddl.logic.predicates import Predicate
from pddl.logic.effects import When
from pddl.logic.terms import Constant, Variable
import time

def bool_combinations(n):
    return list(product([0, 1], repeat=n))

class ApplyCondEff:
    def __init__(self, anc_eff, derive_condition, agents, depth, predicates, objects):
        """Parse ancillary effect structure into antecedent/consequent components."""
        self.derived_cond = derive_condition
        self.agents = agents
        self.depth = depth
        self.predicates = predicates
        self.objects = objects
        self.assignment = {}
        self.name = anc_eff[2].value
        anc_eff = anc_eff[3:-1]  # remove parentheses and anceff name
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
        self.cons_cond_type = cons[3][1][0].value

    def modify_predicate_apply_cond_type(self, old_rml, agent=None):
        """Apply the consequent's add/del semantics to an existing predicate."""
        all_preds = []
        for modf in self.cons_rml:
            next_preds = self.gather_preds(modf, old_rml, agent)
            if None in next_preds:
                return None
            for p in next_preds:
                if "del" in self.cons_cond_type:
                    p.negated = not p.negated
            all_preds.extend(next_preds)
        return all_preds

    @staticmethod
    def nest_modl(modf_rml, new_rml, simplify=True):
        """Nest modality annotations from ``modf_rml`` onto ``new_rml``, simplifying when possible."""
        if new_rml.modl.modl_type is NegateOnly:
            # we are nesting on top of a negate_only!
            # take the new modality term and set the negate_inner_rml.
            # NOTE: we don't negate the whole term because that would be a negation OUTER to the modality!
            # this negation was just already here.
            if new_rml.modl.negate_inner_rml:
                modf_mod = deepcopy(modf_rml.modl)
                if modf_mod.negate_inner_rml:
                    modf_mod.negate()
                else:
                    modf_mod.negate_inner_rml = True
                new_rml.modl = deepcopy(modf_mod)
                return new_rml
        outer_mod = deepcopy(new_rml.modl)
        outer_mod.nested = []
        new_nested = [outer_mod, *deepcopy(new_rml.modl.nested)]
        new_rml.modl = deepcopy(modf_rml.modl)
        new_rml.modl.nested = new_nested
        # first, check if we have a new negation added
        if new_rml.modl.negate_inner_rml:
            # WOOOOO time to negate by flipping everything
            new_rml.modl.negate(True)
        if simplify:
            # check if they reference the same agents
            if new_rml.modl.agent == new_rml.modl.nested[0].agent and new_rml.modl.modl_type == new_rml.modl.nested[0].modl_type:
                # if we have possible modality then modality, return just the modality
                if not new_rml.modl.hard_modl and new_rml.modl.nested[0].hard_modl:
                    new_modl = new_rml.modl.nested[0]
                    nested = new_rml.modl.nested[1:]
                    new_rml.modl = new_modl
                    new_rml.modl.nested = nested
                    return new_rml
                # if we have modality then possible modality, return just the possible modality
                elif new_rml.modl.hard_modl and not new_rml.modl.nested[0].hard_modl:
                    new_modl = new_rml.modl.nested[0]
                    nested = new_rml.modl.nested[1:]
                    new_rml.modl = new_modl
                    new_rml.modl.nested = nested
                    return new_rml
                # if after nesting we created a duplicate modality term, simplify by lobbing off the outer one.
                # note that if there is a negation of any kind, that would at this point already be moved all the way in.
                # so there's no danger in lobbing off the outer one as the negation will stay the same in any case.
                elif new_rml.modl.hard_modl == new_rml.modl.nested[0].hard_modl:
                    new_modl = new_rml.modl.nested[0]
                    nested = new_rml.modl.nested[1:]
                    new_rml.modl = new_modl
                    new_rml.modl.nested = nested
                    return new_rml
        return new_rml

    @staticmethod
    def merge_modl(modf_rml, new_rml, old_rml):
        """Nest or return the original predicate depending on modality compatibility."""
        # we only want to nest by adding a NEGATIVE modality term IF
        # the original modality term is NOT a belief of the corresponding
        # agent (positive or negative)
        if modf_rml.negate_whole_term and modf_rml.modl.agent == new_rml.modl.agent:
            # need this for the original negation status.
            # in the case where we are modifying a raw RML (rml without the negation
            # status) because the antecedent cond type is "del" and we need to
            # return the original formula, we need to restore the negation status.
            return old_rml
        else:
            return ApplyCondEff.nest_modl(modf_rml, new_rml)

    def modify_predicate(self, old_rml, modf_rml, agent=None):
        """Assuming both predicates have the same "base,"
        modify the old predicate according to the attributes of the new predicate"""

        # print(f"\nModifying predicate {old_rml} with {modf_rml.modl} ({modf_rml.modl.__class__.__name__}) for agent {agent}")

        modf_rml = deepcopy(modf_rml)
        new_rml = deepcopy(old_rml)

        # Special case for (and (...)) structure
        if type(new_rml) is And:
            if len(new_rml._operands) == 1:
                new_rml = new_rml._operands[0]

        # Special case if we're negating an AK predicate
        if new_rml.always_known and modf_rml.negate_whole_term:
            new_rml.negated = not new_rml.negated
            return new_rml

        # if the antecedent has a type "del," then we only want to
        # pass in the "raw" RML, a.k.a. leave the negation at the door.
        if "del" in self.ant_cond_type:
            new_rml.negated = False

        # broadest case: we are just negating the whole thing
        if modf_rml.negate_whole_term:
            if new_rml.modl:
                new_rml.modl.negate()
            else:
                # if no modality term, then still remember we are still negating the modality term,
                # just according to the root agent. so negate the predicate using the
                # "inner" negation.
                new_rml.modl = NegateOnly(True)
        elif modf_rml.modl:
            if new_rml.modl:
                if (
                    type(new_rml.modl) is NegateOnly or new_rml.modl.negate_inner_rml
                ) and new_rml.always_known:
                    if type(modf_rml.modl) is NegateOnly and modf_rml.modl.negate_inner_rml:
                        new_rml.modl.negate()
                        return new_rml
                    return old_rml
                if modf_rml.nest:
                    modf_rml.modl.agent = Agent(agent, False)
                    new_rml = self.merge_modl(modf_rml, new_rml, old_rml)
                else:
                    if agent is not None:
                        modf_rml.modl.agent = Agent(agent, False)
                    # if new_rml.modl.negate_inner_rml:
                    #     # we're adding a modality term into an "inner negated" term.
                    #     # we aren't nesting, but we still want to keep that negation.
                    #     if modf_rml.modl.nested:
                    #         modf_rml.modl.nested[-1].negate_inner_rml = new_rml.modl.negate_inner_rml
                    #     else:
                    #         modf_rml.modl.negate_inner_rml = new_rml.modl.negate_inner_rml
                    if type(new_rml.modl) is NegateOnly:
                        new_rml = self.merge_modl(modf_rml, new_rml, old_rml)
                    else:
                        new_rml.modl = deepcopy(modf_rml.modl)
                        new_rml.modl.nested = deepcopy(modf_rml.modl.nested)
            else:
                if new_rml.always_known:
                    # # Never have this predicate be NegateOnly, since AK's are either true or false.
                    # new_rml.modl = None

                    # if modf_rml.modl.negate_inner_rml:
                    #     new_rml.negated = not new_rml.negated

                    # return new_rml

                    #---
                    # we don't want to add a modality to an AK predicate. throw out this case.
                    return None
                else:
                    modf_rml.modl.agent = Agent(agent, False)
                    new_rml.modl = deepcopy(modf_rml.modl)
        # print(f"Modified predicate to {new_rml}")
        return new_rml

    def get_pos_or_neg_cond_term(self, cond, term_type, is_neg_cond):
        """Extract positive or negative predicates from a condition while normalizing negation."""
        if not cond:
            return []
        new_rmls = []
        if term_type == "pos":
            # note: since we have a condition, we assume we're working with a When
            # we need to grab all predicates that are not negated
            if type(cond) is And:
                new_rmls = [p for p in cond.operands if p.negated == False]
            else:
                if cond.negated == False:
                    new_rmls = [cond]
        else:
            if type(cond) is And:
                new_rmls = [p for p in cond.operands if p.negated == True]
            else:
                if cond.negated == True:
                    new_rmls = [cond]
            new_rmls = deepcopy(new_rmls)
            # note that we want to ignore the negations here and just get the raw RMLs,
            # because they will be re-applied by the :negcond in the consequent if necessary later.
            if is_neg_cond:
                for i in range(len(new_rmls)):
                    new_rmls[i].negated = False
        return new_rmls

    def handle_list_comp(self, list_comp_terms, next_cond_or_eff, agent=None, is_neg_cond=False):
        """Resolve list comprehensions."""
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
                        matching_lc = "pos"
        # if not, check the negative condition
        if not matching_lc and self.ant_neg_cond:
            if type(self.ant_neg_cond) is list:
                first_cond_term = self.ant_neg_cond[0]
                if type(first_cond_term) is list:
                    if list_comp_terms[var_i] == first_cond_term[0]:
                        matching_lc = "neg"
        if matching_lc:
            new_rmls = []
            # if we do have a matching term, we need to construct the new list of predicates
            new_rmls.extend(
                self.get_pos_or_neg_cond_term(next_cond_or_eff, matching_lc, is_neg_cond)
            )
            # finally we need to see if any modifications were made to the predicates by looking
            # at the first term of the list comprehension
            for i in range(len(new_rmls)):
                result = self.modify_predicate(
                    deepcopy(new_rmls[i]), list_comp_terms[0], agent
                )
                if result is None:
                    return None
            return new_rmls
        else:
            if list_comp_terms[var_i].value == "agents":
                new_rmls = []
                for a in self.agents:
                    rml = deepcopy(list_comp_terms[0])
                    if rml.modl.agent.var:
                        if rml.modl.agent.name == "ag":
                            rml.modl.agent = Agent(a, False)
                        else:
                            rml.modl.agent = Agent(
                                self.assignment[rml.modl.agent.name], False
                            )
                    for i in range(len(rml.modl.nested)):
                        if rml.modl.nested[i].agent.name == "ag":
                            rml.modl.nested[i].agent = Agent(a, False)
                        else:
                            rml.modl.nested[i].agent = Agent(
                                self.assignment[rml.modl.nested[i].agent.name], False
                            )
                    result = self.modify_predicate(deepcopy(next_cond_or_eff), rml, agent)
                    if result is None:
                        return None
                    new_rmls.append(
                        result
                    )
                return new_rmls
            else:
                # if no matches, then we don't know what the list comprehension is referring to
                raise ValueError(
                    "No matching list comprehension term found in antecedent conditions."
                )

    def gather_preds(self, cons_cond_or_rml, next_cond_or_eff, agent=None, is_neg_cond=False):
        """Recursively collect predicates from a consequent condition or RML based on the next condition/effect RML it receives."""
        # recursively iterate through the condition structure
        if type(cons_cond_or_rml) is Tree:
            return self.gather_preds(cons_cond_or_rml.children, next_cond_or_eff, agent, is_neg_cond)
        elif type(cons_cond_or_rml) is Predicate:
            terms = deepcopy(list(cons_cond_or_rml.terms))
            for i in range(len(terms)):
                if type(terms[i]) is Variable:
                    terms[i] = Constant(self.assignment[terms[i].name])
            p = Predicate(cons_cond_or_rml.name, *terms)
            for dp in self.predicates:
                if p.name == dp.name and len(p.terms) == len(dp.terms):
                    p.always_known = dp.always_known
                    break
            p.modl = deepcopy(cons_cond_or_rml.modl)
            if p.modl:
                if p.modl.agent:
                    if p.modl.agent.var:
                        if p.modl.agent.name in self.assignment:
                            p.modl.agent = Agent(
                                self.assignment[p.modl.agent.name], False
                            )
                for i in range(len(p.modl.nested)):
                    if p.modl.nested[i].agent:
                        if p.modl.nested[i].agent.var:
                            if p.modl.nested[i].agent.name in self.assignment:
                                p.modl.nested[i].agent = Agent(
                                    self.assignment[p.modl.nested[i].agent.name], False
                                )
            p.negated = cons_cond_or_rml.negated
            return [p]
        elif type(cons_cond_or_rml) is ModRML:
            rml = deepcopy(cons_cond_or_rml)
            if rml.modl:
                if rml.modl.agent:
                    if rml.modl.agent.var:
                        if rml.modl.agent.name in self.assignment:
                            rml.modl.agent = Agent(
                                self.assignment[rml.modl.agent.name], False
                            )
            for i in range(len(rml.modl.nested)):
                if rml.modl.nested[i].agent:
                    if rml.modl.nested[i].agent.var:
                        if rml.modl.nested[i].agent.name in self.assignment:
                            rml.modl.nested[i].agent = Agent(
                                self.assignment[rml.modl.nested[i].agent.name], False
                            )
            return [self.modify_predicate(self.grounded_rml, rml, agent)]
        elif type(cons_cond_or_rml) is Token:
            if cons_cond_or_rml.type == "PLUS":
                return []
        elif type(cons_cond_or_rml) is list:
            cond_preds = []
            for term in cons_cond_or_rml:
                if type(term) is list:
                    if term[0] == "COMPOUND":
                        # we're dealing with a list 
                        result = self.handle_list_comp(term[2:-1], next_cond_or_eff, agent, is_neg_cond)
                        if result is None:
                            return [None]
                        cond_preds.extend(
                            result
                        )
                        continue
                    # we're referencing an antecedent condition
                    if term == self.ant_pos_cond[0]:
                        cond_preds.extend(
                            self.get_pos_or_neg_cond_term(next_cond_or_eff, "pos", is_neg_cond)
                        )
                        continue
                    elif term == self.ant_neg_cond[0]:
                        cond_preds.extend(
                            self.get_pos_or_neg_cond_term(next_cond_or_eff, "neg", is_neg_cond)
                        )
                        continue
                # regular recursion
                result = self.gather_preds(term, next_cond_or_eff, agent, is_neg_cond)
                if None in result:
                    return [None]
                cond_preds.extend(result)
            return cond_preds

    def create_cond(self, cons_cond, next_cond, is_neg_cond, agent=None):
        """Build predicates for a single consequent condition section."""
        if cons_cond:
            return self.gather_preds(cons_cond, next_cond, agent, is_neg_cond)
        return None

    def create_conds(self, next_cond, agent=None):
        """Create combined positive/negative consequent conditions with proper negation."""
        new_pos_cond = self.create_cond(self.cons_pos_cond, next_cond, is_neg_cond=False, agent=agent)
        new_neg_cond = self.create_cond(self.cons_neg_cond, next_cond, is_neg_cond=True, agent=agent)

        if None in [new_pos_cond, new_neg_cond]:
            return None

        new_cond = []
        if new_pos_cond:
            new_cond.extend(new_pos_cond)
        if new_neg_cond:
            for c in new_neg_cond:
                c.negated = not c.negated
            new_cond.extend(new_neg_cond)
        return new_cond

    def create_dcond_pred(self, index, agent):
        """Ground a derived condition template at ``index`` for ``agent``."""
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
        """Return grounded derived-condition predicates, optionally for a specific agent."""
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
                        # TODO: assuming no modality terms for now
                        # replace the ith term with the grounded variable
                        for a in self.agents:
                            p = self.create_dcond_pred(i, a)
                            grounded_dconds.append((p, a))
                        return grounded_dconds

    def vars_to_iterate(self, formula):
        """Collect non-agent variables that should be grounded during expansion."""
        vars = set()
        if type(formula) is Predicate:
            for t in formula.terms:
                if "agent" not in t.type_tags:
                    vars.add(t)
        elif type(formula) is list:
            for f in formula:
                vars = vars.union(self.vars_to_iterate(f))
        elif type(formula) is When:
            return self.vars_to_iterate(formula.condition) + self.vars_to_iterate(
                formula.effect
            )
        return vars

    def agents_to_iterate(self, formula):
        """Collect agent variables (including nested modality agents) that require grounding."""
        vars = set()
        if type(formula) is Predicate:
            if formula.modl:
                if formula.modl.agent:
                    vars.add(formula.modl.agent)
                    for b in formula.modl.nested:
                        if b.agent:
                            vars.add(b.agent)
            for t in formula.terms:
                if "agent" in t.type_tags:
                    vars.add(t)
        if type(formula) is ModRML:
            if formula.modl:
                if formula.modl.agent:
                    vars.add(formula.modl.agent)
                    for b in formula.modl.nested:
                        if b.agent:
                            vars.add(b.agent)
        elif type(formula) is list:
            if formula[0] == "COMPOUND":
                # skip this because we deal with list comp later.
                return set()
            for f in formula:
                vars = vars.union(self.agents_to_iterate(f))
        elif type(formula) is When:
            return self.vars_to_iterate(formula.condition) + self.vars_to_iterate(
                formula.effect
            )
        return vars

    def handle_wildcard_case(self, next_f, consequent_preds, cond=None):
        cons_rml = self.cons_rml[0][0]
        num_modl = 1
        if next_f.modl:
            num_modl += len(next_f.modl.nested)
        for combo in bool_combinations(num_modl):
            eff = deepcopy(next_f)
            if combo == (0,) * num_modl:
                continue
            for idx in range(num_modl):
                if idx in next_f.match_idx:
                    if idx == 0:
                        if combo[idx] == 1:
                            eff.modl = type(cons_rml.modl)(cons_rml.modl.modl_type, next_f.modl.negate_inner_rml, cons_rml.modl.hard_modl, next_f.modl.agent)
                            eff.modl.nested = deepcopy(next_f.modl.nested)
                    else:
                        if combo[idx] == 1:
                            idx -= 1
                            eff.modl.nested[idx] = type(cons_rml.modl)(cons_rml.modl.modl_type, next_f.modl.nested[idx].negate_inner_rml, cons_rml.modl.hard_modl, next_f.modl.nested[idx].agent)
            if cond:
                consequent_preds.append(When(cond, And(eff)))
            else:
                consequent_preds.append(eff)
        delattr(next_f, "match_idx")
        return eff

    def create_consequent_core(self, next_f):
        """Generate consequents for a single valuation (optionally within a When)."""
        consequent_preds = []
        # WHEN CONDITION CASE
        if type(next_f) is When:
            if type(next_f.effect) is not Predicate:
                raise NotImplementedError("Handle complex when effects later?")
            cond = self.create_conds(next_f.condition, self.current_agent)
            if cond is None:
                return None
            # also need to do derived conditions here since that might
            # have a matching agent parameter.
            if self.need_awareness:
                if self.derived_cond[0] != Token("NEVER", "never"):
                    cond = set(cond + self.get_derived_cond_preds(self.current_agent))
                else:
                    return []
            and_cond = And(*[])
            and_cond._operands.extend(sorted(cond))
            # special way of creating effects
            if "wildcard" in self.ant_cond_type:
                self.handle_wildcard_case(next_f.effect, consequent_preds, and_cond)
            else:
                eff = self.modify_predicate_apply_cond_type(
                    deepcopy(next_f.effect), self.current_agent
                )
                if eff is None:
                    return None
                consequent_preds.append(When(and_cond, And(*eff)))
        # PREDICATE CASE
        else:
            # we need to do derived conditions here since that might
            # have a matching agent parameter.
            cond = self.create_conds(None)
            if cond is None:
                return None  
            if self.derived_cond:
                if self.need_awareness:
                    if self.derived_cond[0] != Token("NEVER", "never"):
                        cond = set(self.get_derived_cond_preds(self.current_agent))
                    else:
                        return []
            if cond:
                and_cond = And(*[])
                and_cond._operands.extend(sorted(cond))
                if "wildcard" in self.ant_cond_type:
                    self.handle_wildcard_case(next_f, consequent_preds, and_cond)
                else:
                    eff = self.modify_predicate_apply_cond_type(
                        deepcopy(next_f), self.current_agent
                    )
                    if eff is None:
                        return None
                    consequent_preds.append(When(and_cond, And(*eff)))
            else:
                if "wildcard" in self.ant_cond_type:
                    self.handle_wildcard_case(next_f, consequent_preds)
                else:
                    next = self.modify_predicate_apply_cond_type(
                            deepcopy(next_f), self.current_agent
                        )
                    if next is None:
                        return None
                    consequent_preds.extend(
                        next
                    )
        # if "wildcard" in self.ant_cond_type:
        #     for c in consequent_preds:
        #         print(c)
        #     print()
        return consequent_preds

    def create_consequent(self, next_f):
        """Ground any new variables/agents and build consequents for ``next_f``."""
        ant_agents = self.agents_to_iterate(self.ant_rml)
        cons_agents = self.agents_to_iterate(self.cons_pos_cond).union(
            self.agents_to_iterate(self.cons_neg_cond),
            self.agents_to_iterate(self.cons_rml),
        )
        ant_vars = self.vars_to_iterate(self.ant_rml)
        cons_vars = self.vars_to_iterate(self.cons_pos_cond).union(
            self.vars_to_iterate(self.cons_neg_cond),
            self.vars_to_iterate(self.cons_rml),
        )

        ant_agents_d = {a.name: a for a in ant_agents}
        cons_agents_d = {a.name: a for a in cons_agents}
        if len(cons_agents_d.keys() - ant_agents_d.keys()) > 1:
            raise NotImplementedError(
                "Decide how to handle multiple newly introduced agents in a consequent, "
                "particularly in mapping to derived conditions (where we are also currently "
                "only assuming one agent parameter)."
            )
        ant_vars_d = deepcopy(ant_agents_d)
        cons_vars_d = deepcopy(cons_agents_d)
        ant_vars_d.update({v.name: v for v in ant_vars})
        cons_vars_d.update({a.name: a for a in cons_vars})
        all_vars_to_iter = cons_vars_d.keys() - ant_vars_d.keys()
        all_vars_to_iter = {cons_vars_d[v] for v in all_vars_to_iter}

        consequent_preds = []
        if all_vars_to_iter:
            val_generator = create_valuations(
                self.agents, self.objects, all_vars_to_iter
            )
            for valuation in val_generator:
                self.current_agent = None
                for var, val in zip(all_vars_to_iter, valuation):
                    if type(var) is Agent or var.name in cons_agents_d:
                        self.current_agent = val
                    self.assignment[var.name] = val
                result = self.create_consequent_core(next_f)
                if result is None:
                    return None
                consequent_preds.extend(result)
        else:
            self.current_agent = None
            result = self.create_consequent_core(next_f)
            if result is None:
                return None
            consequent_preds.extend(result)
        return consequent_preds
    
    def check_modl_wildcard_match(self, next_modl, wildcard: MODL):
        return next_modl.modl_type == wildcard.modl_type and next_modl.hard_modl == wildcard.hard_modl

    def wildcard_match(self, next_f, wildcard: MODL, deleting=False):
        if deleting != next_f.negated:
            return False
        idx = []
        if self.check_modl_wildcard_match(next_f.modl, wildcard):
            idx.append(0)
        if next_f.modl.nested:
            for i in range(len(next_f.modl.nested)):
                if self.check_modl_wildcard_match(next_f.modl.nested[i], wildcard):
                    idx.append(i + 1)
        next_f.match_idx = idx
        return len(idx) > 0
    
    def save_rml(self, next_f):
        self.grounded_rml = deepcopy(next_f)

    def check_ant_format(self, next_f) -> bool:
        """
        When we just have a predicate, we assume the antecedent conditions are empty. however,
        the RML can still be applied, but we have to check the predicate against the RML format.

        When we have a "When," we have to check the when effect against the RML format.

        Another note: it's OK if the RML has no modality term and the predicate does.
        In that case, the RML functions as a general "catch-all."
        However, if the RML has a modality term, then the modality term is of some relevance,
        and the predicate is expected to match it.
        """
        if type(next_f) is And:
            if len(next_f._operands) == 1:
                next_f = next_f._operands[0]
        elif type(next_f) is When:
            # check the when effect against the rml
            next_f = next_f.effect
            if type(next_f) is And:
                if len(next_f._operands) == 1:
                    next_f = next_f._operands[0]
            if type(next_f) is not Predicate:
                # TODO: we now do have when formulas with effects with multiple predicates.
                # but let's handle that later
                return False
                # raise NotImplementedError("Handle complex when effects later?")

        # easiest thing to check first is the cond_type.
        # if the cond_type is 'add', but the predicate is negated,
        # or vice versa, we know it doesn't match.
        if (
            "add" in self.ant_cond_type
            and next_f.negated
            or "del" in self.ant_cond_type
            and not next_f.negated
        ):
            return False

        # explained in the docstring
        if self.ant_rml.modl and not next_f.modl:
            return False
        
        # "wildcard" case means that we need at least one match of the wildcard in the antecedent
        if self.ant_rml.modl and self.ant_cond_type == "wildcard":
            if type(self.ant_rml.modl) is NegateOnly or type(self.cons_rml[0][0].modl) is NegateOnly:
                return ValueError("Not a valid wildcard setting.")
            return self.wildcard_match(next_f, self.ant_rml.modl)
        elif self.ant_rml.modl and self.ant_cond_type == "del-wildcard":
            if type(self.ant_rml.modl) is NegateOnly or type(self.cons_rml[0][0].modl) is NegateOnly:
                return ValueError("Not a valid wildcard setting.")
            return self.wildcard_match(next_f, self.ant_rml.modl, deleting=True)

        # "soft" adds/deletes allow for cases where the antecedent term has no modality term and the next
        # formula term does, and we allow for that term to "pass through." however, hard add/deletes
        # only return True on a STRICT match.
        if not self.ant_rml.modl and next_f.modl and "soft" not in self.ant_cond_type:
            return False

        if (not self.ant_rml.modl and next_f.modl) or (
            not self.ant_rml.modl and not next_f.modl
        ):
            # get the variable assignments
            if type(self.ant_rml) is Predicate:
                # need to check the predicate itself
                if self.ant_rml.name != next_f.name or len(self.ant_rml.terms) != len(
                    next_f.terms
                ):
                    return False
                for i in range(len(self.ant_rml.terms)):
                    if i < len(next_f.terms):
                        self.assignment[self.ant_rml.terms[i].name] = next_f.terms[
                            i
                        ].name
            self.save_rml(next_f)
            return True

        # if we've gotten to this point, both have modalities.
        # however these could still be different kinds.
        if self.ant_rml.modl.modl_type != next_f.modl.modl_type:
            return False

        # need to check the nested terms as well
        if len(self.ant_rml.modl.nested) != len(next_f.modl.nested):
            return False

        # now we can check the full modality terms, knowing they're the same type.
        # note: we don't care what the agent is, we're just checking for the overall structure
        if (
            self.ant_rml.modl.negate_inner_rml == next_f.modl.negate_inner_rml
            and self.ant_rml.modl.hard_modl == next_f.modl.hard_modl
        ):
            for i in range(len(self.ant_rml.modl.nested)):
                if (
                    self.ant_rml.modl.nested[i].modl_type != next_f.modl.nested[i].modl_type
                    or self.ant_rml.modl.nested[i].negate_inner_rml
                    != next_f.modl.nested[i].negate_inner_rml
                    or self.ant_rml.modl.nested[i].hard_modl
                    != next_f.modl.nested[i].hard_modl
                ):
                    return False
        else:
            return False
        # gather the assignments
        self.assignment[self.ant_rml.modl.agent.name] = next_f.modl.agent.name
        for i in range(len(self.ant_rml.modl.nested)):
            self.assignment[self.ant_rml.modl.nested[i].agent.name] = next_f.modl.nested[
                i
            ].agent.name
        # also get the variable assignments
        if type(self.ant_rml) is Predicate:
            # need to check the predicate itself
            if self.ant_rml.name != next_f.name or len(self.ant_rml.terms) != len(
                next_f.terms
            ):
                return False
            for i in range(len(self.ant_rml.terms)):
                if i < len(next_f.terms):
                    self.assignment[self.ant_rml.terms[i].name] = next_f.terms[i].name
        self.save_rml(next_f)
        return True


def check_nesting(cons, depth):
    """Ensure nested modality depth in a consequent does not exceed ``depth``."""
    if type(cons) is When:
        return check_nesting(cons.condition, depth) and check_nesting(
            cons.effect, depth
        )
    elif type(cons) is And:
        for o in cons.operands:
            if not check_nesting(o, depth):
                return False
        return True
    elif type(cons) is Predicate:
        if not cons.modl or type(cons.modl) is NegateOnly:
            return True
        else:
            return len(cons.modl.nested) + 1 <= depth


def gen_id(cond):
    """Generate a unique ID for a condition based on its string representation."""
    # make it a unique 5-character hash
    import hashlib

    m = hashlib.md5()
    m.update(str(hash(cond)).encode("utf-8"))
    return m.hexdigest()[:8]


def apply_cond_eff(
    anc_effs,
    o,
    derive_condition,
    agents,
    depth,
    predicates,
    objects,
    effs_to_apply=None,
):
    """Adapted from pdlb.actions.Action._expand."""

    mapping = {}
    debug_condeffs = [
        "(when (and (not_at_alice_l1) (at_alice_l1) (not_at_bob_l1) (at_bob_l1)) (Bbob_Balice_secret_alice))",
        "(when (and (not_at_alice_l1) (not_at_bob_l1) (at_bob_l1)) (not (PBbob_Balice_not_secret_alice)))",
        "(when (and (at_bob_l1) (not_at_bob_l1)) (PBbob_secret_alice))",
        "(when (and (at_alice_l2) (not (not_loves_alice_bob)) (not (together_alice_bob)) (not (together_cindy_bob))) (rivals_alice_cindy))"
    ]

    o.id = gen_id(o)
    o.parent = None
    o.comment = f" id({o.id})"
    condleft = [o]
    processed_conds = set()
    anc_effs_to_apply = (
        [a for a in anc_effs if a[2].value in effs_to_apply]
        if effs_to_apply
        else anc_effs
    )
    while condleft:
        next_f = condleft.pop(0)
        # check the antecedent format
        if next_f not in processed_conds:
            mapping[str(next_f).strip()] = next_f
            processed_conds.add(next_f)
            for anc_eff in anc_effs_to_apply:
                anc_eff_data = ApplyCondEff(
                    anc_eff, derive_condition, agents, depth, predicates, objects
                )
                # if anc_eff_data.name == "believe-disdain-not-love":
                #     print()
                # if anc_eff_data.name not in ["kd45closure__belief", "mutual-awareness-pos__belief", "mutual-awareness-neg__belief"]:#["negation-removal", "kd45closure__belief", "kd45-un-closure__belief", "uncertain-firing", "mutual-awareness-pos__belief", "mutual-awareness-neg__belief"]:#"negation-removal", "kd45-un-closure", "uncertain-firing",
                #     continue

                # if anc_eff_data.name == "kd45-un-closure__belief" and str(next_f) == "(when (and (at_bob_l1)) (not (PBbob_PBalice_not_book-teachings)))":
                #     print()
                if anc_eff_data.check_ant_format(next_f):
                    if anc_eff_data.name == "mutual-awareness-pos__belief" and str(next_f) == "(when (and (not (chemistry_bob_alice))) (DISalice_date_alice_bob))":
                        print()
                    # print(anc_eff_data.name)
                    # print(f"next cond: {next_f}")

                    cons = anc_eff_data.create_consequent(deepcopy(next_f))
                    if cons:
                        cons = list(set(cons))
                        # remove extraneous modality terms)
                        for i in range(len(cons)):
                            if type(cons[i]) is When:
                                cond = set(
                                    [
                                        remove_extra_modl(c)
                                        for c in cons[i].condition.operands
                                    ]
                                )
                                and_cond = And(*[])
                                and_cond._operands.extend(sorted(cond))
                                eff = (
                                    set(
                                        [
                                            remove_extra_modl(c)
                                            for c in cons[i].effect.operands
                                        ]
                                    )
                                    if type(cons[i].effect) is And
                                    else [remove_extra_modl(cons[i].effect)]
                                )
                                # and_eff = And(*[])
                                # and_eff._operands.extend(sorted(cond))
                                cons[i] = When(and_cond, And(*eff))
                            else:
                                cons[i] = remove_extra_modl(cons[i])
                            cons[i].id = gen_id(cons[i])
                            cons[i].comment = (
                                anc_eff_data.name
                                + f" id({cons[i].id}) / parent({next_f.id})"
                            )
                        # printed = False
                        for c in cons:
                            if check_nesting(c, depth):
                                if c not in processed_conds and c not in condleft:
                                    # if not printed:
                                    #     print(anc_eff_data.name)
                                    #     print(f"next cond: {next_f}")
                                    #     printed = True
                                    # print(c)
                                    c.parent = next_f
                                    condleft.append(c)
                        # if anc_eff_data.name == "mutual-awareness-neg__belief":
                        #     print()
                        
                        # print("----")

    for debug_condeff in debug_condeffs:
        if debug_condeff and debug_condeff.strip() in mapping:
            debug_condeff = mapping[debug_condeff]
            print("=====\n")
            print(f"Original: {debug_condeff}")
            while debug_condeff.parent:
                print(f"\nDerived via {debug_condeff.comment.split(' ')[0]} from...\n")
                debug_condeff = debug_condeff.parent
                print(debug_condeff)
            print("\n=====")

    return list(processed_conds - {o})  # already have o


# TODO: clean this up
def remove_extra_modl(term):
    """Strip redundant NegateOnly nesting introduced during expansion."""
    if term.modl:
        if type(term.modl) is NegateOnly:
            if not term.modl.negate_inner_rml:
                if not term.modl.nested:
                    term.modl = None
                else:
                    new_nested = []
                    for n in term.modl.nested:
                        if type(n) is NegateOnly:
                            if not n.negate_inner_rml:
                                continue
                        new_nested.append(deepcopy(n))
                    term.modl.nested = new_nested[1:]
                    term.modl = deepcopy(new_nested[0])
        else:
            if term.modl.nested:
                new_nested = []
                for n in term.modl.nested:
                    if type(n) is NegateOnly:
                        if not n.negate_inner_rml:
                            continue
                    new_nested.append(deepcopy(n))
                term.modl.nested = new_nested
    return term


def all_rmls(domain, depth):
    """Generate all reachable RMLs up to ``depth`` levels of nesting for a domain."""
    # we just said screw it here and compared the strings because of set hashing issues.
    all_rmls = set()
    curr = [deepcopy(p) for p in domain.predicates]

    for d in range(1, depth + 1):
        # Generate raw expansions
        raw = []
        for ag in domain._agents:
            agent = Agent(ag, False)
            for rml in curr:
                rml_d = 0
                if rml.modl:
                    rml_d += 1
                    if rml.modl.nested:
                        rml_d += len(rml.modl.nested)
                if rml_d >= depth:
                    continue
                # ---- generate modality variants ----
                variants = []

                # Only add the negation variation at depth 1 for the non-AK fluents
                if d == 1 and not rml.always_known:
                    x = deepcopy(rml)
                    x.modl = NegateOnly(True)
                    variants.append(x)

                if not rml.always_known:
                    for typ in GenericMODLType:
                        for neg in (False, True):
                            for hard in (True, False):
                                x = deepcopy(rml)
                                x.modl = GenericModality(
                                    modl_type=typ, negate_inner_rml=neg, hard_modl=hard, agent=agent
                                )
                                variants.append(x)

                # ---- nesting rules ----
                if rml.modl:
                    for v in variants:
                        base = deepcopy(rml)
                        if isinstance(base.modl, NegateOnly):
                            if base.modl.negate_inner_rml:
                                v.modl.negate()
                            raw.append(v)
                        else:
                            raw.append(ApplyCondEff.nest_modl(v, base, False))
                else:
                    raw.extend(variants)

        # ---- dedupe via signature BEFORE canonicalization ----
        seen = set()
        next_layer = []

        for item in raw:
            # canonicalize internal structure but do NOT mutate later
            cleaned = remove_extra_modl(item)
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
    """Apply ancillary effects to every action/init/goal and return updated domain/problem."""
    start = time.time()
    timeout = 30 * 60
    if type(anc_effs) is list:
        new_anc_effs = []
        for e in anc_effs:
            new_anc_effs.extend(e._anceffs)
        anc_effs = new_anc_effs
    else:
        anc_effs = anc_effs._anceffs
    depth = int(problem.depth[2].value)
    for action in domain.actions:
        # if action.name != "share_alice_bob_l1":
        #     continue
        for o in action.effect.operands:
            new_rmls = apply_cond_eff(
                anc_effs,
                o,
                action.derive_condition,
                domain._agents,
                depth,
                domain.predicates,
                problem.objects,
            )
            if time.time() - start > timeout:
                raise TimeoutError("Preprocessing exceeded 30-minute time limit.")
            if new_rmls:
                # apply the consequent
                action.effect._operands.extend(new_rmls)
        # in case of duplicate effects, remove them
        action.effect._operands = set(action.effect._operands)

    # we also need to get all rmls for the predicates
    predicates = all_rmls(domain, depth)

    init = set(problem.init)

    for p in problem.init:
        new_rmls = apply_cond_eff(
            anc_effs,
            p,
            None,
            domain._agents,
            depth,
            domain.predicates,
            problem.objects,
            ["kd45closure"],
        )
        if new_rmls:
            for n in new_rmls:
                if not n.negated:
                    init.add(n)
    if problem.init_type[2].value == "complete":
        to_add = set()
        # also need to close omniscience of the root agent
        for rml in predicates:
            if rml.modl:
                if (
                    rml.modl.hard_modl == False
                ):  # need to check False specifically, not None
                    rml_neg = deepcopy(rml)
                    rml_neg.modl.negate()
                    # have to do this instead of using "rml_neg in init" because of a weird
                    # hash bug relating to mutability...
                    # TODO: fix this with a cleaner solution later?
                    if not any(rml_neg == p for p in init):
                        to_add.add(rml)
        init.update(to_add)
    goal = (
        set(problem.goal._operands) if type(problem.goal) is And else set(problem.goal)
    )
    for p in goal:
        goal.update(
            apply_cond_eff(
                anc_effs,
                p,
                None,
                domain._agents,
                depth,
                domain.predicates,
                problem.objects,
                ["kd45closure"],
            )
        )

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
        agents=domain._agents,
    )

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
        projection=problem.projection,
    )

    return domain, problem
