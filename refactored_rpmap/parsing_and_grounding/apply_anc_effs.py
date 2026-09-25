from .core.anc_eff import *
from .utils import cleaned_not, create_and
from pddl.core import Domain, Problem
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import Not, And
from pddl.logic.effects import When
import itertools
import time


class ApplyAncEffs:
    def __init__(self, anc_effs: list[AncEff], domain: Domain, problem: Problem, effs_to_apply: list[str] = None):
        anc_effs = {a.name: a for a in anc_effs}
        self.anc_effs = (
            {a: anc_effs[a] for a in anc_effs if a in effs_to_apply}
            if effs_to_apply
            else anc_effs
        )
        self.domain = domain
        self.problem = problem
        self.agents = domain.agents
        self.rml: SeparatedRMLTerm = None
        self.pred: Predicate = None
        self.nesting_terms: list[list[list[Nesting]]] = None
        self.raw_conds: list[Not | SeparatedRMLTerm | Predicate] = None
        self.assignment: dict[Variable, str] = {}
        self.max_depth_detected = 0

    def reset(self):
        self.rml = None
        self.pred = None
        self.nesting_terms = None
        self.assignment = {}
        self.raw_conds = None
        self.max_depth_detected = 0

    @staticmethod
    def gen_id(cond):
        """Generate a unique ID for a condition based on its string representation."""
        # make it a unique 5-character hash
        import hashlib

        m = hashlib.md5()
        m.update(str(hash(cond)).encode("utf-8"))
        return m.hexdigest()[:8]

    def check_ant_rml_nestings(self, ant_rml: SeparatedRMLTerm, cond: SeparatedRMLTerm, soft_check: bool):
        if isinstance(ant_rml.nestings[0], MODLTermWNesting):
            self.nesting_terms = []
            if not cond.nestings:
                self.nesting_terms = None
                return False
            nesting_term = ant_rml.nestings[0]
            if isinstance(nesting_term, TrailingNesting):
                if cond.nestings[0].mod_type == nesting_term.modl.mod_type:
                    nesting_terms = cond.nestings[1:] if len(cond.nestings) > 1 else list()
                    self.nesting_terms.append([])
                    self.nesting_terms.append(nesting_terms)
                    self.nesting_terms = [self.nesting_terms]
                    self.assignment[nesting_term.modl.agent.term] = cond.nestings[0].agent.term
                    return True
                self.nesting_terms = None
                return False
            elif isinstance(nesting_term, LeadingNesting):
                if cond.nestings[-1].mod_type == nesting_term.modl.mod_type:
                    nesting_terms = cond.nestings[:-1] if len(cond.nestings) > 1 else list()
                    self.nesting_terms.append(nesting_terms)
                    self.nesting_terms.append([])
                    self.nesting_terms = [self.nesting_terms]
                    self.assignment[nesting_term.modl.agent.term] = cond.nestings[-1].agent.term
                    return True
                self.nesting_terms = None
                return False
            elif isinstance(nesting_term, LeadingTrailingNesting):
                found_idxs = [i for i in range(len(cond.nestings)) if cond.nestings[i].mod_type == nesting_term.modl.mod_type]
                if not found_idxs:
                    self.nesting_terms = None
                    return False
                self.assignment[nesting_term.modl.agent.term] = list()
                for i in found_idxs:
                    nesting_terms = [cond.nestings[:i]]
                    nesting_terms.append(cond.nestings[i + 1:]  if i < len(cond.nestings) - 1 else [])
                    self.nesting_terms.append(nesting_terms)
                    self.assignment[nesting_term.modl.agent.term].append(cond.nestings[i].agent.term)
                return True
            else:
                raise PDDLValidationError("Unknown {nesting} term type " + str(type(nesting_term)))
        else:
            # need to check if the antecedent nesting "begins" the cond nesting (for {rml})
            if soft_check:
                if len(ant_rml.nestings) > len(cond.nestings):
                    return False
            # need to check if the antecedent nesting matches the cond nesting exactly (for {pred})
            else:
                if len(ant_rml.nestings) != len(cond.nestings):
                    return False
            for i in range(len(ant_rml.nestings)):
                if ant_rml.nestings[i].mod_type != cond.nestings[i].mod_type:
                    return False
                if isinstance(ant_rml.nestings[i], Nesting):
                    self.assignment[ant_rml.nestings[i].agent.term] = cond.nestings[i].agent.term
            return True

    def check_ant_match(self, ant_rml: SeparatedRMLTerm, ant_rml_type: str, next_term: Not | When | SeparatedRMLTerm, awareness: bool = False, derive_condition: str | SeparatedRMLTerm = "never"):
        # if dealing with a When statement, we need to compare against the When effect.
        if isinstance(next_term, When):
            # note that When formulas already been grounded such that every When has only one effect
            # there is a possibility it is a Not instead though
            next_term = next_term.effect.operands[0] if isinstance(next_term.effect, And) else next_term.effect
        # compare Not status with the antecedent type status
        if (ant_rml_type == "del" and not isinstance(next_term, Not)) or (isinstance(next_term, Not) and ant_rml_type != "del"):
            return False
        # if dealing with a Not statement, we need to compare against the argument.
        if isinstance(next_term, Not): 
            # Not has been checked in grounding such that it can take an RML, Predicate, or SeparatedRMLTerm
            next_term = next_term.argument
        if awareness:
            if derive_condition == "never":
                return False
        if isinstance(next_term, SeparatedRMLTerm):
            if isinstance(ant_rml.term, RMLTerm):
                if ant_rml.nestings:
                    if self.check_ant_rml_nestings(ant_rml, next_term, soft_check=True):
                        # if dealing with a {nesting} term type, then anything remaining will have already been stored in self.nesting_terms
                        # also note that the MODLTermWNesting case currently is only allowed to match with RMLTerms (at the parsing level)
                        if isinstance(ant_rml.nestings[0], MODLTermWNesting):
                            self.rml = SeparatedRMLTerm(list(), next_term.term)
                        else:
                            remaining_cond_nestings = next_term.nestings[len(ant_rml.nestings):] if len(next_term.nestings) > len(ant_rml.nestings) else []
                            self.rml = SeparatedRMLTerm(remaining_cond_nestings, next_term.term)
                        return True
                    return False
                # if there's no antecedent nestings, then anything can be matched.
                else:
                    self.rml = next_term
                    return True
            elif isinstance(ant_rml.term, RMLTermNegated):
                # indicates that the next term is a Predicate (no modalities) and also is not negated.
                if not next_term.nestings: 
                    return False
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, next_term, soft_check=True):
                        return False
                # create a copy of the next_term's nestings after the RML point, and add a negation.
                # we basically want to isolate the {rml}.
                temp_nestings = [NOT_MODL()] + next_term.nestings[len(ant_rml.nestings):] if len(next_term.nestings) > len(ant_rml.nestings) else []
                # recreate the SeparatedRMLTerm with these new nestings, which will also put the nestings in normal form.
                self.rml = SeparatedRMLTerm(temp_nestings, next_term.term)
                return True
            elif isinstance(ant_rml.term, PredTerm) or isinstance(ant_rml.term, PredTermNegated):
                if isinstance(ant_rml.term, PredTermNegated):
                    # ensures that next_term has a negation
                    if not next_term.nestings or next_term.nestings[-1] != NOT_MODL(): 
                        return False
                    # remove the last negation from the next_term nestings, since that matches the '!' in '!{pred}'
                    next_term = SeparatedRMLTerm(next_term.nestings[:-1], next_term.term)
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, next_term, soft_check=False):
                        return False
                else:
                    if next_term.nestings:
                        return False
                self.pred = next_term.term
                return True
            elif isinstance(ant_rml.term, Predicate):
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, next_term, soft_check=False):
                        return False
                else:
                    if next_term.nestings:
                        return False
                if ant_rml.term.name == next_term.term.name and ant_rml.term.arity == next_term.term.arity:
                    for i in range(len(ant_rml.term.terms)):
                        self.assignment[ant_rml.term.terms[i]] = next_term.term.terms[i]
                    return True
                return False
            else:
                raise PDDLValidationError(f"Unknown Antecedent term type {type(ant_rml.term)}")
        else:
            raise PDDLValidationError(f"Unknown next_term type {type(next_term)}")

    def get_positive_conds(self):
        return [c for c in self.raw_conds if not isinstance(c, Not)]

    def get_negative_conds(self):
        return [cleaned_not(c) for c in self.raw_conds if isinstance(c, Not)]

    def get_pos_or_neg_conds(self, var: Variable):
        if var == Variable("pos"):
            return self.get_positive_conds()
        elif var == Variable("neg"):
            return self.get_negative_conds()
        else:
            raise ValueError(f"Unknown variable {var}.")

    def ground_srt(self, new_rml: SeparatedRMLTerm):
        nestings = []
        for n in new_rml.nestings:
            if isinstance(n, Nesting):
                nestings.append(Nesting(n.mod_type, Agent(self.assignment[n.agent.term])) if isinstance(n.agent.term, Variable) else n)
            elif isinstance(n, MODLTermWNesting):
                nestings.append(n.__class__(Nesting(n.modl.mod_type, Agent(self.assignment[n.modl.agent.term]))) if isinstance(n.modl.agent.term, Variable) else n)
            elif isinstance(n, NOT_MODL):
                nestings.append(n)
            else:
                raise ValueError(f"Unknown nesting type {type(n)}.")
        if isinstance(new_rml.term, Predicate):
            terms = list(new_rml.term.terms)
            ak = new_rml.term.always_known
            negated = new_rml.term.negated
            for i in range(len(terms)):
                if isinstance(terms[i], Variable):
                    terms[i] = self.assignment[terms[i]]
            term = Predicate(new_rml.term.name, *tuple(terms), always_known=new_rml.term.always_known, negated=new_rml.term.negated)
        else:
            term = new_rml.term
        return SeparatedRMLTerm(nestings, term)

    @staticmethod
    def terms_to_rml(terms: list[Nesting | NOT_MODL | Predicate]):
        for i in range(len(terms) - 2, - 1, - 1):
            terms[i] = cleaned_not(terms[i + 1]) if terms[i] == Not else terms[i](terms[i + 1])
        return terms[0]

    @staticmethod
    def extend_srt_terms(srt: SeparatedRMLTerm | Not, existing_nestings: list[Nesting | NOT_MODL] = None):
        rml_terms = list() if not existing_nestings else existing_nestings
        if isinstance(srt, Not):
            srt = srt.argument
            rml_terms.append(Not)
        rml_terms.extend(srt.nestings)
        return (rml_terms, srt.term)

    @staticmethod
    def srt_to_rml(srt: SeparatedRMLTerm | Not, existing_nestings: list[Nesting | NOT_MODL] = None):
        rml_terms, term = ApplyAncEffs.extend_srt_terms(srt, existing_nestings)
        rml_terms.append(term)
        return ApplyAncEffs.terms_to_rml(rml_terms)

    @staticmethod
    def term_to_rml(term: And | When | SeparatedRMLTerm | Not | Predicate, existing_nestings: list[Nesting | NOT_MODL] = None):
        if isinstance(term, Predicate):
            return term
        elif isinstance(term, SeparatedRMLTerm) or isinstance(term, Not):
            return ApplyAncEffs.srt_to_rml(term, existing_nestings)
        elif isinstance(term, And):
            return create_and([ApplyAncEffs.term_to_rml(o, existing_nestings) for o in term.operands])
        elif isinstance(term, When):
            return When(ApplyAncEffs.term_to_rml(term.condition, existing_nestings), ApplyAncEffs.term_to_rml(term.effect, existing_nestings))
        else:
            raise ValueError(f"Invalid term type: {type(term)}")

    def apply_rml(self, new_rml: SeparatedRMLTerm):
        new_rml = self.ground_srt(new_rml)
        if self.nesting_terms:
            rml_terms = []
            if isinstance(new_rml.nestings[0], LeadingNesting):
                rml_terms.extend(self.nesting_terms[0])
                rml_terms.append(new_rml.nestings[0].modl)
            elif isinstance(new_rml.nestings[0], TrailingNesting):
                rml_terms.append(new_rml.nestings[0].modl)
                rml_terms.extend(self.nesting_terms[0])
            elif isinstance(new_rml.nestings[0], LeadingTrailingNesting):
                rml_terms.extend(self.nesting_terms[0])
                rml_terms.append(new_rml.nestings[0].modl)
                rml_terms.extend(self.nesting_terms[1])
            else:
                raise ValueError(f"Unknown nesting type {type(new_rml.nestings[0])}.")
        else:
            rml_terms = new_rml.nestings
        if isinstance(new_rml.term, PredTermNegated) or isinstance(new_rml.term, RMLTermNegated) or isinstance(new_rml.term, RTermNegated):
            rml_terms.append(NOT_MODL())
        if isinstance(new_rml.term, RMLTerm) or isinstance(new_rml.term, RMLTermNegated):
            srt = self.rml
        elif isinstance(new_rml.term, PredTerm) or isinstance(new_rml.term, PredTermNegated):
            srt = self.pred
        elif isinstance(new_rml.term, RTerm) or isinstance(new_rml.term, RTermNegated):
            srt = self.r
        elif isinstance(new_rml.term, Predicate):
            srt = SeparatedRMLTerm(list(), new_rml.term)
        else:
            raise ValueError(f"Unknown term type {type(new_rml.term)}.")
        rml_terms, term = ApplyAncEffs.extend_srt_terms(srt, rml_terms)
        return SeparatedRMLTerm(rml_terms, term)

    def ground_cond_or_rml(self, cond_or_rml):
        if cond_or_rml in [Variable("pos"), Variable("neg")]:
            return self.get_pos_or_neg_conds(cond_or_rml)
        elif isinstance(cond_or_rml, ListCompVar):
            pos_or_neg_conds = self.get_pos_or_neg_conds(cond_or_rml.var)
            for i in range(len(pos_or_neg_conds)):
                self.r = pos_or_neg_conds[i]
                pos_or_neg_conds[i] = self.apply_rml(cond_or_rml.term)
            return pos_or_neg_conds
        elif isinstance(cond_or_rml, ListCompAgents):
            rmls = []
            for ag in self.agents.values():
                self.assignment[Variable("ag", ["agent"])] = ag
                rmls.append(self.apply_rml(cond_or_rml.term))
            return rmls
        elif isinstance(cond_or_rml, ListCompVarAgents):
            rmls = []
            pos_or_neg_conds = self.get_pos_or_neg_conds(cond_or_rml.var)
            for ag in self.agents.values():
                self.assignment[Variable("ag", ["agent"])] = ag
                for c in pos_or_neg_conds:
                    self.r = c
                    rmls.append(self.apply_rml(cond_or_rml.term))
            return rmls
        elif isinstance(cond_or_rml, SeparatedRMLTerm):
            return [self.apply_rml(cond_or_rml)]
        elif isinstance(cond_or_rml, Not):
            return [cleaned_not(self.ground_cond_or_rml(cond_or_rml.argument)[0])]
        else:
            raise ValueError(f"Unknown condition type {type(cond_or_rml)}")

    def get_raw_conds(self, next_term):
        return list(next_term.condition.operands) if isinstance(next_term, When) else []

    def get_conds(self, poscond, negcond, next_term):
        self.raw_conds = self.get_raw_conds(next_term)
        conds = []
        if poscond:
            for c in poscond:
                conds.extend(self.ground_cond_or_rml(c))
        if negcond:
            for c in negcond:
                conds.extend([cleaned_not(gc) for gc in self.ground_cond_or_rml(c)])
        return conds

    @staticmethod
    def simplify_always_known(operand_term: SeparatedRMLTerm | Not):
        operand_term = operand_term
        if isinstance(operand_term, SeparatedRMLTerm):
            return SeparatedRMLTerm([n for n in operand_term.nestings if isinstance(n, NOT_MODL)], operand_term.term) if operand_term.term.always_known and operand_term.nestings else operand_term
        elif isinstance(operand_term, Not):
            return Not(ApplyAncEffs.simplify_always_known(operand_term.argument))
        else:
            raise ValueError(f"Unknown term type type(term)")

    def simplify_and_check_depth(self, term: When | And | Not | SeparatedRMLTerm):
        if isinstance(term, Predicate) or isinstance(term, Not):
            return term
        elif isinstance(term, SeparatedRMLTerm):
            self.max_depth_detected = max(self.max_depth_detected, len([t for t in term.nestings if not isinstance(t, NOT_MODL)]))
            return term
        elif isinstance(term, And):
            for i in range(len(term.operands)):
                term._operands[i] = ApplyAncEffs.simplify_always_known(term.operands[i])
            return list({ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(t)): self.simplify_and_check_depth(t) for t in term.operands}.values())
        elif isinstance(term, When):
            cond = self.simplify_and_check_depth(term.condition)
            eff = self.simplify_and_check_depth(term.effect)
            when = When(create_and(self.simplify_and_check_depth(term.condition)), create_and(self.simplify_and_check_depth(term.effect)))
            if len(when.effect.operands) > 1:
                return [When(when.condition, create_and([e])) for e in when.effect.operands]
            return [when]
        else:
            raise ValueError(f"Unknown type {type(term)}.")

    def apply_anc_eff(self, anc_eff_cons: Consequent, next_term, awareness: bool, derive_condition: str | SeparatedRMLTerm):
        conds = self.get_conds(anc_eff_cons.poscond, anc_eff_cons.negcond, next_term)
        # the derive condition is specified in the domain as part of the action and is already grounded
        if awareness and isinstance(derive_condition, SeparatedRMLTerm):
            conds.extend(self.ground_cond_or_rml(derive_condition))
        eff = []
        for term in anc_eff_cons.rml: 
            for g_term in self.ground_cond_or_rml(term):
                eff.append(g_term if anc_eff_cons.anceff_type == "add" else cleaned_not(g_term))
        return self.simplify_and_check_depth(When(create_and(conds), create_and(eff))) if conds else self.simplify_and_check_depth(create_and(eff))
                
    def apply_anc_eff_all_nestings(self, anc_eff_cons: Consequent, next_term, awareness: bool, derive_condition: str | SeparatedRMLTerm):
        if self.nesting_terms:
            all_nesting_terms = [n for n in self.nesting_terms]
            all_nesting_assignments = {var: cond for var, cond in self.assignment.items()}
            results = []
            for n in self.nesting_terms:
                self.nesting_terms = all_nesting_terms.pop(0)
                for var in all_nesting_assignments:
                    if type(all_nesting_assignments[var]) == list:
                        self.assignment[var] = all_nesting_assignments[var].pop(0)
                results.extend(self.apply_anc_eff(anc_eff_cons, next_term, awareness, derive_condition))
            return results
        else:
            return self.apply_anc_eff(anc_eff_cons, next_term, awareness, derive_condition)

    def apply_anc_eff_all_dlr_agent(self, anc_eff: AncEff, next_term, awareness: bool, derive_condition: str | SeparatedRMLTerm):
        dlr_agent = Variable("dlr_agent", ["agent"])
        if (dlr_agent in anc_eff.agents) or (dlr_agent in [n.agent.term for n in derive_condition.nestings if isinstance(n, Nesting)] if isinstance(derive_condition, SeparatedRMLTerm) else False):
            results = []
            for agent in self.agents.values():
                self.assignment[dlr_agent] = agent
                results.extend(self.apply_anc_eff_all_nestings(anc_eff.consequent, next_term, awareness, derive_condition))
            return results
        else:
            return self.apply_anc_eff_all_nestings(anc_eff.consequent, next_term, awareness, derive_condition)


    @staticmethod
    def sort_operands(term: And):
        return create_and(sorted(term.operands, key=lambda x: repr(x)))

    @staticmethod
    def sorted_str(term: Predicate | RML | SeparatedRMLTerm | Not | And | When):
        """Return the operands sorted by their string representation."""
        # note that Not can only be applied to an RML/Predicate/SeparatedRMLTerm
        if isinstance(term, Predicate) or isinstance(term, RML) or isinstance(term, SeparatedRMLTerm) or isinstance(term, Not):
            return repr(term)
        elif isinstance(term, And):
            return repr(ApplyAncEffs.sort_operands(term))
        elif isinstance(term, When):
            return repr(When(ApplyAncEffs.sort_operands(term.condition), ApplyAncEffs.sort_operands(term.effect)))
        else:
            raise ValueError(f"Invalid term type: {type(term)}")

    def apply_anc_effs_to_action(self, next_term, derive_condition, anc_effs = None):
        anc_effs = {a: self.anc_effs[a] for a in anc_effs} if anc_effs else self.anc_effs 
        next_term.id = ApplyAncEffs.gen_id(next_term)
        next_term.parent = None
        next_term.comment = "BASE" + f" id({next_term.id})"
        condleft = [next_term]
        processed_conds = dict()
        
        while condleft:
            next_term = condleft.pop(0)
            next_term_rep = ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(next_term))
            if next_term_rep not in processed_conds:
                # if next_term_rep == "(when (and (at_bob_l1)) (and [BEL, bob](secret_alice)))":
                #     print()
                processed_conds[next_term_rep] = next_term
                if len(processed_conds) > 5000:
                    exit()
                print("anceffs for action: ", len(processed_conds))
                for anc_eff in anc_effs.values():
                    if self.check_ant_match(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_term, anc_eff.antecedent.awareness, derive_condition):
                        new_terms = self.apply_anc_eff_all_dlr_agent(anc_eff, next_term, anc_eff.antecedent.awareness, derive_condition)
                        # if anc_eff.name == "mutual-awareness-pos__belief":
                        #     print()
                        if self.max_depth_detected > self.problem.depth:
                            # print("DEPTH TOO HIGH")
                            self.reset()
                            continue
                        for new_term in new_terms:
                            if ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(new_term)) not in processed_conds:
                                new_term.id = ApplyAncEffs.gen_id(new_term)
                                new_term.comment = anc_eff.name + f" id({new_term.id}) / parent({next_term.id})"
                                condleft.append(new_term)
                    self.reset()
        return list(processed_conds.values())[1:]

    def generate_all_rmls(self):
        curr = self.domain.predicates
        pos_predicates = {ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(p)): SeparatedRMLTerm(list(), p) for p in curr}
        variants_pos_only = {}
        variants_pos_only.update(pos_predicates)
        variants = {}
        variants.update(pos_predicates)
        variants.update({ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(NOT_MODL()(p))): SeparatedRMLTerm([NOT_MODL()], p) for p in curr if not p.always_known})
        for depth in range(1, self.problem.depth + 1):
            for p in curr:
                if not p.always_known:
                    for negation_status in (list(), [NOT_MODL()]):
                        for generic_modl_permutation in list(itertools.product({*GenericMODLType, *PossibleGenericMODLType}, repeat=depth)):
                            for agent_permutation in list(itertools.product(self.agents.values(), repeat=depth)):
                                variant_nestings = negation_status
                                variant_nestings.extend([Nesting(generic_modl_permutation[i], Agent(Constant(agent_permutation[i], "agent"))) for i in range(depth)])
                                srt_variant = SeparatedRMLTerm(variant_nestings, p)
                                variants[ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(srt_variant))] = srt_variant
                                if not negation_status:
                                    variants_pos_only[ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(srt_variant))] = srt_variant
                                if depth + 1 < self.problem.depth:
                                    for action_modl in {*ActionMODLType, *PossibleActionMODLType}:
                                        for agent in self.agents.values():
                                            am_variant_nestings = variant_nestings
                                            am_variant_nestings.append(Nesting(action_modl, Agent(agent)))
                                            srt_variant = SeparatedRMLTerm(am_variant_nestings, p)
                                            variants[ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(srt_variant))] = srt_variant
                                            if not negation_status:
                                                variants_pos_only[ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(srt_variant))] = srt_variant
        return variants, variants_pos_only

    def apply_anc_effs(self):
        start = time.time()
        timeout = 30 * 60
        all_rmls, all_rmls_pos_only = self.generate_all_rmls()
        self.domain._predicates = [ApplyAncEffs.term_to_rml(p) for p in all_rmls.values()]
        anc_effs_count = 0
        for action in self.domain.actions:
            print(action.name)
            if action.name == "adopt-belief_cindy_l1":
                for o in action.effect.operands:
                    new_terms = self.apply_anc_effs_to_action(o, action.derive_condition)
                    if new_terms:
                        action.effect._operands.extend(new_terms)
                        anc_effs_count += len(new_terms)
                        print("total anc effs: ", anc_effs_count)
                    if time.time() - start > timeout:
                        raise TimeoutError("Preprocessing exceeded 30-minute time limit.")
        if self.problem.init_type == "complete":
            self.problem._init = list(self.problem.init)
            init_strs = [ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(init_rml)) for init_rml in self.problem.init]
            # create the negated (planning agent belief) version of everything NOT in the initial state
            # add that to the initial state  
            for rml_str, rml in all_rmls_pos_only.items():
                neg_rml = SeparatedRMLTerm([NOT_MODL()] + rml.nestings, rml.term)
                if not rml.term.always_known and rml_str not in init_strs and ApplyAncEffs.sorted_str(ApplyAncEffs.term_to_rml(neg_rml)) not in init_strs:
                    self.problem._init.append(neg_rml)

        # apply closure to everything in the initial state and goal
        closure_anc_effs = ["kd45closure__belief", "kd45closure__desire", "kd45closure__intention"]
        init_closure = []
        for init_rml in self.problem.init:
            init_closure.extend(self.apply_anc_effs_to_action(init_rml, "never", closure_anc_effs))
        self.problem._init.extend(init_closure)

        # now we need to convert everything to RMLs

        for action in self.domain.actions:
            action.derive_condition = ApplyAncEffs.term_to_rml(action.derive_condition) if isinstance(action.derive_condition, SeparatedRMLTerm) else action.derive_condition
            for i in range(len(action.precondition._operands)):
                action.precondition._operands[i] = ApplyAncEffs.term_to_rml(action.precondition._operands[i])
            for i in range(len(action.effect._operands)):
                comment = action.effect._operands[i].comment if hasattr(action.effect._operands[i], "comment") else None
                action.effect._operands[i] = ApplyAncEffs.term_to_rml(action.effect._operands[i])
                action.effect._operands[i].comment = comment
        self.problem._init = list(self.problem.init)
        self.problem._goal = list(self.problem.goal)
        for i in range(len(self.problem.init)):
            self.problem._init[i] = ApplyAncEffs.term_to_rml(self.problem.init[i])
        for i in range(len(self.problem.goal)):
            self.problem._goal[i] = ApplyAncEffs.term_to_rml(self.problem.goal[i])
        self.problem._init = frozenset(self.problem.init)
        self.problem._goal = [create_and(self.problem.goal)]
        return self.domain, self.problem