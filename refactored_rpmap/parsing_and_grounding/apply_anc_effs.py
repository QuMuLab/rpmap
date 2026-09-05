from .core.anc_eff import *
from pddl.core import Domain, Problem
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import Not, And
from pddl.logic.effects import When
from copy import deepcopy


class ApplyAncEffs:
    def __init__(self, anc_effs: AncEffs, domain: Domain, problem: Problem, effs_to_apply: list[str] = None):
        anc_effs = {a.name: a for a in anc_effs.anceffs}
        self.anc_effs = (
            [anc_effs[a] for a in anc_effs if a in effs_to_apply]
            if effs_to_apply
            else list(anc_effs.values())
        )
        self.domain = domain
        self.problem = problem
        self.rml: SeparatedRMLTerm = None
        self.pred: Predicate = None
        self.nestings: list[list[Nesting]] = None

    def reset(self):
        self.rml = None
        self.pred = None
        self.nestings = None

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
                    return True
                self.nestings = None
                return False
            elif isinstance(nesting_term, LeadingNesting):
                if cond.nestings[-1].mod_type == nesting_term.modl.mod_type:
                    nesting_terms = deepcopy(cond.nestings[:-1]) if len(cond.nestings) > 1 else list()
                    self.nestings.append(nesting_terms)
                    return True
                self.nestings = None
                return False
            elif isinstance(nesting_term, LeadingTrailingNesting):
                found = False
                nesting_terms = []
                for n in cond.nestings:
                    if n.mod_type == nesting_term.modl.mod_type and not found:
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
            return True

    def check_ant_match(self, ant_rml: SeparatedRMLTerm, ant_rml_type: str, next_cond: Not | When | SeparatedRMLTerm):
        cond = deepcopy(next_cond)
        # if dealing with a When statement, we need to compare against the When effect.
        if isinstance(cond, When):
            # note that When formulas already been grounded such that every When has only one effect
            # there is a possibility it is a Not instead though
            cond = cond.effect.operands[0] if isinstance(cond.effect, And) else cond.effect
        # compare Not status with the antecedent type status
        if (ant_rml_type == "del" and type(cond) is not Not) or (type(cond) is Not and ant_rml_type != "del"):
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

    def match_cond(self, cond_to_match, raw_conds):
        if cond_to_match == Variable("pos"):
            return self.get_positive_conds(raw_conds)
        elif cond_to_match == Variable("neg"):
            return self.get_negative_conds(raw_conds)
        elif isinstance(cond_to_match, ListCompAgents):
            print()
        elif isinstance(cond_to_match, ListCompVar):
            print()
        elif isinstance(cond_to_match, SeparatedRMLTerm):
            print()
        else:
            raise ValueError(f"Unknown condition type {type(cond_to_match)}")

    def get_raw_conds(self, next_cond):
        if isinstance(next_cond, Not) or isinstance(next_cond, SeparatedRMLTerm) or isinstance(next_cond, Predicate):
            return next_cond
        elif isinstance(next_cond, When):
            return [self.get_raw_conds(o) for o in next_cond.condition.operands]
        elif isinstance(next_cond, And):
            return [self.get_raw_conds(o) for o in next_cond.operands]
        else:
            raise ValueError(f"Unknown condition type {type(next_cond)}")

    def get_conds(self, poscond, negcond, next_cond):
        raw_conds = self.get_raw_conds(next_cond)
        conds = []
        if poscond:
            for c in poscond:
                conds.extend(self.match_cond(c, raw_conds))
        if negcond:
            for c in negcond:
                conds.extend(self.match_cond(c, raw_conds))

    def apply_anc_eff(self, anc_eff_cons: Consequent, next_cond):
        self.get_conds(anc_eff_cons.poscond, anc_eff_cons.negcond, next_cond)
        if self.pred:
            print()
        elif self.rml:
            print()
        else:
            raise ValueError(f"Neither {rml} nor {pred} were set.")

    def apply_anc_effs_to_action(self, o):
        o.id = ApplyAncEffs.gen_id(o)
        o.parent = None
        condleft = [o]
        processed_conds = set()
        
        while condleft:
            next_cond = condleft.pop(0)
            if next_cond not in processed_conds:
                processed_conds.add(next_cond)
                for anc_eff in self.anc_effs:
                    if self.check_ant_match(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_cond):
                        print(f"{next_cond} passed the ancillary effect {anc_eff.name} antecedent {anc_eff.antecedent.rml}")
                        self.apply_anc_eff(anc_eff.consequent, next_cond)
                    self.reset()

    def apply_anc_effs(self):
        for action in self.domain.actions:
            for o in action.effect.operands:
                new_rmls = self.apply_anc_effs_to_action(o)