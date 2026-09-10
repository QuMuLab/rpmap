from .core.anc_eff import *
from .utils import cleaned_not
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
        self.agent_assignment: dict[Variable, str] = {}

    def reset(self):
        self.rml = None
        self.pred = None
        self.nestings = None
        self.agent_assignment = {}
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
                    self.agent_assignment[nesting_term.modl.agent.term] = cond.nestings[0].agent.term
                    return True
                self.nestings = None
                return False
            elif isinstance(nesting_term, LeadingNesting):
                if cond.nestings[-1].mod_type == nesting_term.modl.mod_type:
                    nesting_terms = deepcopy(cond.nestings[:-1]) if len(cond.nestings) > 1 else list()
                    self.nestings.append(nesting_terms)
                    self.agent_assignment[nesting_term.modl.agent.term] = cond.nestings[-1].agent.term
                    return True
                self.nestings = None
                return False
            elif isinstance(nesting_term, LeadingTrailingNesting):
                found = False
                nesting_terms = []
                for n in cond.nestings:
                    if n.mod_type == nesting_term.modl.mod_type and not found:
                        self.agent_assignment[nesting_term.modl.agent.term] = n.agent.term
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
                self.agent_assignment[ant_rml.nestings[i].modl.agent.term] = cond.nestings[i].agent.term
            return True

    def check_ant_match(self, ant_rml: SeparatedRMLTerm, ant_rml_type: str, next_term: Not | When | SeparatedRMLTerm):
        cond = deepcopy(next_term)
        # if dealing with a When statement, we need to compare against the When effect.
        if isinstance(cond, When):
            # note that When formulas already been grounded such that every When has only one effect
            # there is a possibility it is a Not instead though
            cond = cond.effect.operands[0] if isinstance(cond.effect, And) else cond.effect
        # compare Not status with the antecedent type status
        if (ant_rml_type == "del" and not isinstance(cond, Not)) or (isinstance(cond, Not) and ant_rml_type != "del"):
            return False
        # if dealing with a Not statement, we need to compare against the argument.
        if isinstance(cond, Not): 
            # Not has been checked in grounding such that it can take an RML, Predicate, or SeparatedRMLTerm
            cond = cond.argument
        if isinstance(cond, SeparatedRMLTerm):
            if isinstance(ant_rml.term, RMLTerm):
                if ant_rml.nestings:
                    if self.check_ant_rml_nestings(ant_rml, cond, soft_check=True):
                        remaining_cond_nestings = cond.nestings[len(ant_rml.nestings):] if len(cond.nestings) > len(ant_rml.nestings) else []
                        self.rml = SeparatedRMLTerm(deepcopy(remaining_cond_nestings), deepcopy(cond.term))
                        return True
                    return False
                # if there's no antecedent nestings, then anything can be matched.
                else:
                    self.rml = deepcopy(cond)
                    return True
            elif isinstance(ant_rml.term, RMLTermNegated):
                # indicates that cond is a Predicate (no modalities) and also is not negated.
                if not cond.nestings: 
                    return False
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, cond, soft_check=True):
                        return False
                # create a copy of the cond's nestings after the RML point, and add a negation.
                # we basically want to isolate the {rml}.
                temp_nestings = [NOT_MODL()] + cond.nestings[len(ant_rml.nestings):] if len(cond.nestings) > len(ant_rml.nestings) else []
                # recreate the SeparatedRMLTerm with these new nestings, which will also put the nestings in normal form.
                self.rml = SeparatedRMLTerm(deepcopy(temp_nestings), deepcopy(cond.term))
                return True
            elif isinstance(ant_rml.term, PredTerm) or isinstance(ant_rml.term, PredTermNegated):
                if isinstance(ant_rml.term, PredTermNegated):
                    # ensures that cond has a negation
                    if not cond.nestings or cond.nestings[-1] != NOT_MODL(): 
                        return False
                    # remove the last negation from the cond nestings, since that matches the '!' in '!{pred}'
                    cond.nestings = cond.nestings[:-1]
                if ant_rml.nestings:
                    if not self.check_ant_rml_nestings(ant_rml, cond, soft_check=False):
                        return False
                else:
                    if cond.nestings:
                        return False
                self.pred = deepcopy(cond.term)
                return True
            else:
                raise PDDLValidationError(f"Unknown Antecedent term type {type(ant_rml.term)}")
        else:
            raise PDDLValidationError(f"Unknown cond type {type(cond)}")

    def get_positive_conds(self, raw_conds):
        return [c for c in raw_conds if not isinstance(c, Not)]

    def get_negative_conds(self, raw_conds):
        return [c for c in raw_conds if isinstance(c, Not)]

    def get_pos_or_neg_conds(self, var: Variable, raw_conds):
        if var == Variable("pos"):
            return self.get_positive_conds(raw_conds)
        elif var == Variable("neg"):
            return self.get_negative_conds(raw_conds)
        else:
            raise ValueError(f"Unknown variable {var}.")

    def ground_nesting(self, new_rml: SeparatedRMLTerm):
        for n in new_rml.nestings:
            if isinstance(n, Nesting):
                if isinstance(n.agent.term, Variable):
                    n.agent.term = self.agent_assignment[n.agent.term]
            elif isinstance(n, MODLTermWNesting):
                if isinstance(n.modl.agent.term, Variable):
                    n.modl.agent.term = self.agent_assignment[n.modl.agent.term]

    def apply_rml(self, new_rml: SeparatedRMLTerm):
        self.ground_nesting(new_rml)
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
            rml_terms = new_rml.nestings
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
        if isinstance(srt, Not):
            srt = srt.argument
            rml_terms.append(NOT_MODL())
        rml_terms.extend(srt.nestings)
        rml_terms.append(srt.term)
        for i in range(len(rml_terms) - 2, - 1, - 1):
            rml_terms[i] = rml_terms[i](rml_terms[i + 1])
        return rml_terms[0]

    def ground_cond_or_rml(self, descriptor):
        if descriptor in [Variable("pos"), Variable("neg")]:
            return self.get_pos_or_neg_conds(descriptor, self.raw_conds)
        elif isinstance(descriptor, ListCompVar):
            pos_or_neg_conds = self.get_pos_or_neg_conds(descriptor.var, self.raw_conds)
            for i in range(len(pos_or_neg_conds)):
                self.r = pos_or_neg_conds[i]
                pos_or_neg_conds[i] = self.apply_rml(descriptor.term)
            return pos_or_neg_conds
        elif isinstance(descriptor, ListCompAgents):
            return [self.apply_rml(descriptor.term)]
        elif isinstance(descriptor, SeparatedRMLTerm):
            return [self.apply_rml(descriptor)]
        else:
            raise ValueError(f"Unknown condition type {type(descriptor)}")

    def get_raw_conds(self, next_term):
        return [self.get_raw_conds(o) for o in next_term.condition.operands] if isinstance(next_term, When) else []

    def get_conds(self, poscond, negcond, next_term):
        raw_conds = self.get_raw_conds(next_term)
        self.raw_conds = [raw_conds] if type(raw_conds) != list else raw_conds
        conds = []
        if poscond:
            for c in poscond:
                conds.extend(self.ground_cond_or_rml(c))
        if negcond:
            for c in negcond:
                conds.extend([cleaned_not(gc) for gc in self.ground_cond_or_rml(c)])
        return conds

    def apply_anc_eff(self, anc_eff_cons: Consequent, next_term):
        conds = self.get_conds(anc_eff_cons.poscond, anc_eff_cons.negcond, next_term)
        eff = []
        for term in anc_eff_cons.rml: 
            for g_term in self.ground_cond_or_rml(term):
                eff.append(g_term if anc_eff_cons.anceff_type == "add" else cleaned_not(g_term))
        conds_and_ = And(*[])
        conds_and_._operands = conds
        eff_and_ = And(*[])
        eff_and_._operands = eff
        return When(conds_and_, eff_and_) if conds else eff_and_
                
    def set_assignment_apply_anc_eff(self, parameters: list[Variable], anc_eff_cons: Consequent, next_term):
        anc_effs = []
        # list comprehension across agents
        if parameters and Variable("ag", ["agent"]) in parameters:
            for ag in self.domain._agents.values():
                self.agent_assignment["ag"] = ag
                anc_effs.append(self.apply_anc_eff(anc_eff_cons, next_term))
        else:
            anc_effs.append(self.apply_anc_eff(anc_eff_cons, next_term))
        return anc_effs
                
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
                    if self.check_ant_match(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_term):
                        self.set_assignment_apply_anc_eff(anc_eff.parameters, anc_eff.consequent, next_term)
                    self.reset()

    def apply_anc_effs(self):
        for action in self.domain.actions:
            for o in action.effect.operands:
                new_rmls = self.apply_anc_effs_to_action(o)