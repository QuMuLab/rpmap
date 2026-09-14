from .core.anc_eff import *
from .utils import cleaned_not, create_and
from pddl.core import Domain, Problem
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import Not, And
from pddl.logic.effects import When
from copy import deepcopy
import itertools


class ApplyAncEffs:
    def __init__(self, anc_effs: list[AncEff], domain: Domain, problem: Problem, effs_to_apply: list[str] = None):
        anc_effs = {a.name: a for a in anc_effs}
        self.anc_effs = (
            [anc_effs[a] for a in anc_effs if a in effs_to_apply]
            if effs_to_apply
            else list(anc_effs.values())
        )
        self.domain = domain
        self.problem = problem
        self.agents = set(domain._agents.keys())
        self.rml: SeparatedRMLTerm = None
        self.pred: Predicate = None
        self.nestings: list[list[Nesting]] = None
        self.raw_conds: list[Not | SeparatedRMLTerm | Predicate] = None
        self.assignment: dict[Variable, str] = {}

    def reset(self):
        self.rml = None
        self.pred = None
        self.nestings = None
        self.assignment = {}
        self.raw_conds = None

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
            self.nestings = []
            if not cond.nestings:
                self.nestings = None
                return False
            nesting_term = ant_rml.nestings[0]
            if isinstance(nesting_term, TrailingNesting):
                if cond.nestings[0].mod_type == nesting_term.modl.mod_type:
                    nesting_terms = deepcopy(cond.nestings[1:]) if len(cond.nestings) > 1 else list()
                    self.nestings.append(nesting_terms)
                    self.assignment[nesting_term.modl.agent.term] = cond.nestings[0].agent.term
                    return True
                self.nestings = None
                return False
            elif isinstance(nesting_term, LeadingNesting):
                if cond.nestings[-1].mod_type == nesting_term.modl.mod_type:
                    nesting_terms = deepcopy(cond.nestings[:-1]) if len(cond.nestings) > 1 else list()
                    self.nestings.append(nesting_terms)
                    self.assignment[nesting_term.modl.agent.term] = cond.nestings[-1].agent.term
                    return True
                self.nestings = None
                return False
            elif isinstance(nesting_term, LeadingTrailingNesting):
                found = False
                nesting_terms = []
                for n in cond.nestings:
                    if n.mod_type == nesting_term.modl.mod_type and not found:
                        self.assignment[nesting_term.modl.agent.term] = n.agent.term
                        found = True
                        self.nestings.append(nesting_terms)
                        nesting_terms = []
                    else:
                        nesting_terms.append(deepcopy(n))
                if not found:
                    self.nestings = None
                else:
                    self.nestings.append(nesting_terms)
                return found
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
        nt = deepcopy(next_term)
        # if dealing with a When statement, we need to compare against the When effect.
        if isinstance(nt, When):
            # note that When formulas already been grounded such that every When has only one effect
            # there is a possibility it is a Not instead though
            nt = nt.effect.operands[0] if isinstance(nt.effect, And) else nt.effect
        # compare Not status with the antecedent type status
        if (ant_rml_type == "del" and not isinstance(nt, Not)) or (isinstance(nt, Not) and ant_rml_type != "del"):
            return False
        # if dealing with a Not statement, we need to compare against the argument.
        if isinstance(nt, Not): 
            # Not has been checked in grounding such that it can take an RML, Predicate, or SeparatedRMLTerm
            nt = nt.argument
        if awareness:
            if derive_condition == "never":
                return False
            elif isinstance(derive_condition, SeparatedRMLTerm):
                if hasattr(derive_condition, "assignment"): 
                    self.assignment.update(derive_condition.assignment)
        if isinstance(nt, SeparatedRMLTerm):
            if isinstance(ant_rml.term, RMLTerm):
                if ant_rml.nestings:
                    if self.check_ant_rml_nestings(ant_rml, nt, soft_check=True):
                        # if dealing with a {nesting} term type, then anything remaining will have already been stored in self.nestings
                        # also note that the MODLTermWNesting case currently is only allowed to match with RMLTerms (at the parsing level)
                        if isinstance(ant_rml.nestings[0], MODLTermWNesting):
                            self.rml = SeparatedRMLTerm(list(), nt.term)
                        else:
                            remaining_cond_nestings = nt.nestings[len(ant_rml.nestings):] if len(nt.nestings) > len(ant_rml.nestings) else []
                            self.rml = SeparatedRMLTerm(deepcopy(remaining_cond_nestings), deepcopy(nt.term))
                        return True
                    return False
                # if there's no antecedent nestings, then anything can be matched.
                else:
                    self.rml = deepcopy(nt)
                    return True
            elif isinstance(ant_rml.term, RMLTermNegated):
                # indicates that the next term is a Predicate (no modalities) and also is not negated.
                if not nt.nestings: 
                    return False
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, nt, soft_check=True):
                        return False
                # create a copy of the nt's nestings after the RML point, and add a negation.
                # we basically want to isolate the {rml}.
                temp_nestings = [NOT_MODL()] + nt.nestings[len(ant_rml.nestings):] if len(nt.nestings) > len(ant_rml.nestings) else []
                # recreate the SeparatedRMLTerm with these new nestings, which will also put the nestings in normal form.
                self.rml = SeparatedRMLTerm(deepcopy(temp_nestings), deepcopy(nt.term))
                return True
            elif isinstance(ant_rml.term, PredTerm) or isinstance(ant_rml.term, PredTermNegated):
                if isinstance(ant_rml.term, PredTermNegated):
                    # ensures that nt has a negation
                    if not nt.nestings or nt.nestings[-1] != NOT_MODL(): 
                        return False
                    # remove the last negation from the nt nestings, since that matches the '!' in '!{pred}'
                    nt.nestings = nt.nestings[:-1]
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, nt, soft_check=False):
                        return False
                else:
                    if nt.nestings:
                        return False
                self.pred = deepcopy(nt.term)
                return True
            else:
                raise PDDLValidationError(f"Unknown Antecedent term type {type(ant_rml.term)}")
        else:
            raise PDDLValidationError(f"Unknown nt type {type(nt)}")

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

    def ground_nesting_helper(self, term: Variable):
        if term == Variable("ag", ["agent"]):
            return list(self.domain._agents.values())
        else:
            return [self.assignment[term]]

    def ground_nesting(self, new_rml: SeparatedRMLTerm):
        grounded_assignment = {}
        new_rmls = set()
        for n in new_rml.nestings:
            if isinstance(n, Nesting):
                if isinstance(n.agent.term, Variable):
                    grounded_assignment[n.agent.term] = self.ground_nesting_helper(n.agent.term)
            elif isinstance(n, MODLTermWNesting):
                if isinstance(n.modl.agent.term, Variable):
                    grounded_assignment[n.modl.agent.term] = self.ground_nesting_helper(n.modl.agent.term)
        # return new rmls with all combinations of grounded assignments
        for assignment in itertools.product(*grounded_assignment.values()):
            new_rml_copy = deepcopy(new_rml)
            for i, var in enumerate(grounded_assignment.keys()):
                for n in new_rml_copy.nestings:
                    if isinstance(n, Nesting):
                        if n.agent.term == var:
                            n.agent.term = assignment[i]
                    elif isinstance(n, MODLTermWNesting):
                        if n.modl.agent.term == var:
                            n.modl.agent.term = assignment[i]
            new_rmls.add(new_rml_copy)
        return new_rmls

    @staticmethod
    def terms_to_rml(terms: list[Nesting | NOT_MODL | Predicate]):
        for i in range(len(terms) - 2, - 1, - 1):
            terms[i] = terms[i](terms[i + 1])
        return terms[0]

    @staticmethod
    def srt_to_rml(srt: SeparatedRMLTerm, existing_nestings: list[Nesting | NOT_MODL] = None):
        rml_terms = [] if not existing_nestings else existing_nestings
        if isinstance(srt, Not):
            srt = srt.argument
            rml_terms.append(Not)
        rml_terms.extend(srt.nestings)
        rml_terms.append(srt.term)
        return ApplyAncEffs.terms_to_rml(rml_terms)

    def apply_rml(self, new_rml: SeparatedRMLTerm):
        # TODO: UPDATE THIS TO BE ABLE TO HANDLE SETS OF RMLS AS A RESULT OF LIST COMPREHENSION ACROSS AGENTS
        new_rml = list(self.ground_nesting(new_rml))[0]
        if self.nestings:
            rml_terms = []
            if isinstance(new_rml.nestings[0], LeadingNesting):
                rml_terms.extend(self.nestings[0])
                rml_terms.append(new_rml.nestings[0].modl)
            elif isinstance(new_rml.nestings[0], TrailingNesting):
                rml_terms.append(new_rml.nestings[0].modl)
                rml_terms.extend(self.nestings[0])
            elif isinstance(new_rml.nestings[0], LeadingTrailingNesting):
                rml_terms.extend(self.nestings[0])
                rml_terms.append(new_rml.nestings[0].modl)
                rml_terms.extend(self.nestings[1])
            else:
                raise ValueError(f"Unknown nesting type {type(new_rml.nestings[0])}.")
        else:
            rml_terms = deepcopy(new_rml.nestings)
        if isinstance(new_rml.term, PredTermNegated) or isinstance(new_rml.term, RMLTermNegated) or isinstance(new_rml.term, RTermNegated):
            rml_terms.append(NOT_MODL())
        if isinstance(new_rml.term, RMLTerm) or isinstance(new_rml.term, RMLTermNegated):
            srt = self.rml
        elif isinstance(new_rml.term, PredTerm) or isinstance(new_rml.term, PredTermNegated):
            srt = self.pred
        elif isinstance(new_rml.term, RTerm) or isinstance(new_rml.term, RTermNegated):
            srt = self.r
        else:
            raise ValueError("No term set before attempting to apply an rml.")
        return ApplyAncEffs.srt_to_rml(srt, rml_terms)

    def ground_cond_or_rml(self, cond_or_rml):
        if cond_or_rml in [Variable("pos"), Variable("neg")]:
            return [ApplyAncEffs.srt_to_rml(c) for c in self.get_pos_or_neg_conds(cond_or_rml)]
        elif isinstance(cond_or_rml, ListCompVar) or isinstance(cond_or_rml, ListCompVarAgents):
            pos_or_neg_conds = self.get_pos_or_neg_conds(cond_or_rml.var)
            for i in range(len(pos_or_neg_conds)):
                self.r = pos_or_neg_conds[i]
                pos_or_neg_conds[i] = self.apply_rml(cond_or_rml.term)
            return pos_or_neg_conds
        elif isinstance(cond_or_rml, ListCompAgents):
            return [self.apply_rml(cond_or_rml.term)]
        elif isinstance(cond_or_rml, SeparatedRMLTerm):
            return [self.apply_rml(cond_or_rml)]
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

    def apply_anc_eff(self, anc_eff_cons: Consequent, next_term, awareness: bool, derive_condition: str | SeparatedRMLTerm):
        conds = self.get_conds(anc_eff_cons.poscond, anc_eff_cons.negcond, next_term)
        # the derive condition is specified in the domain as part of the action and is already grounded
        if awareness and isinstance(derive_condition, SeparatedRMLTerm):
            conds.append(ApplyAncEffs.srt_to_rml(derive_condition))
        eff = []
        for term in anc_eff_cons.rml: 
            for g_term in self.ground_cond_or_rml(term):
                eff.append(g_term if anc_eff_cons.anceff_type == "add" else cleaned_not(g_term))
        return When(create_and(conds), create_and(eff)) if conds else create_and(eff)
                
    def set_assignment_apply_anc_eff(self, parameters: list[Variable], anc_eff_cons: Consequent, next_term, awareness: bool = False, derive_condition: str | SeparatedRMLTerm = "never"):
        return self.apply_anc_eff(anc_eff_cons, next_term, awareness, derive_condition)
                
    def apply_anc_effs_to_action(self, o):
        o.id = ApplyAncEffs.gen_id(o)
        o.parent = None
        condleft = [o]
        processed_conds = set()
        
        while condleft:
            next_term = condleft.pop(0)
            if next_term not in processed_conds:
                processed_conds.add(next_term)
                for anc_eff in self.anc_effs:
                    if self.check_ant_match(anc_eff.antecedent, anc_eff.type, next_term, anc_eff.antecedent.awareness, o.derive_condition):
                        self.set_assignment_apply_anc_eff(anc_eff.parameters, anc_eff.consequent, next_term, anc_eff.antecedent.awareness, o.derive_condition)
                    self.reset()

    def apply_anc_effs(self):
        for action in self.domain.actions:
            for o in action.effect.operands:
                new_rmls = self.apply_anc_effs_to_action(o)