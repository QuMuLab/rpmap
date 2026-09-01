from .core.anc_eff import *
from pddl.core import Domain, Problem
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import Not
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
        self.nestings: list[Nesting] = list()

    def reset(self):
        self.rml = None
        self.pred = None
        self.nestings = list()

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
            if not cond.nestings:
                return False
            nesting_term = ant_rml.nestings[0]
            if isinstance(nesting_term, TrailingNesting):
                return cond.nestings[0].mod_type == nesting_term.modl.mod_type
            elif isinstance(nesting_term, LeadingNesting):
                return cond.nestings[-1].mod_type == nesting_term.modl.mod_type
            elif isinstance(nesting_term, LeadingTrailingNesting):
                for n in cond.nestings:
                    if n.mod_type == nesting_term.modl.mod_type:
                        return True
                return False
            else:
                raise PDDLValidationError("Unknown {nesting} term type " + type(nesting_term))


        # if len(cond.nestings) >= 2:
        #     print()
        # if NestingWildcardTerm() in ant_rml.nestings:
        #     if not cond.nestings:
        #         return False
        #     # need to gather the antecedents without the nesting terms
        #     ant_nestings_no_w = [(ant_rml.nestings[i], i) for i in range(len(ant_rml.nestings)) if not isinstance(ant_rml.nestings[i], NestingWildcardTerm)]
        #     nestings_found_idxs = {}
        #     for (ant_nesting, ant_n_idx) in ant_nestings_no_w:
        #         nesting_found = False
        #         # find the non-nesting terms and store at what index they are found
        #         for i in range(len(cond.nestings)):
        #             if cond.nestings[i].mod_type == ant_nesting.mod_type:
        #                 nestings_found_idxs[ant_n_idx] = i
        #                 nesting_found = True
        #                 break
        #         # return no match if no match for any non-nesting term was found
        #         if not nesting_found:
        #             return False
        #     # now we need to set the nesting terms for later
        #     ant_rml_nestings_copy = deepcopy(ant_rml.nestings)
        #     found_cond_idxs = sorted(list(nestings_found_idxs.values()))
        #     next_cond_idx = found_cond_idxs.pop(0)
        #     # cond_idx = 1 if next_cond_idx == 0 else 0
        #     # if next_cond_idx == 0:
        #     #     # next_cond_idx = found_cond_idxs.pop(0) if found_cond_idxs else len(cond.nestings)
        #     #     cond_idx += 1
        #     cond_idx = 0
        #     for i in range(len(ant_rml_nestings_copy)):
        #         if i not in nestings_found_idxs:
        #             next_nesting_term = []
        #             while cond_idx < next_cond_idx:
        #                 next_nesting_term.append(cond.nestings[cond_idx])
        #                 cond_idx += 1
        #             # if we run out of found cond indices, reassign it to the length of the list + 1
        #             # so we just fill out the nestings until the end of the list
        #             next_cond_idx = found_cond_idxs.pop(0) if found_cond_idxs else len(cond.nestings) + 1
        #             cond_idx += 1
        #             self.nestings.append(next_nesting_term)
        #     print()
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
            if soft_check:
                remaining_cond_nestings = cond.nestings[len(ant_rml.nestings):] if len(cond.nestings) > len(ant_rml.nestings) else []
                self.rml = SeparatedRMLTerm(deepcopy(remaining_cond_nestings), deepcopy(cond.term))
            return True

    def check_ant_match(self, ant_rml: SeparatedRMLTerm, ant_rml_type: str, next_cond: Not | When | SeparatedRMLTerm):
        cond = deepcopy(next_cond)
        # compare Not status with the antecedent type status
        if (ant_rml_type == "del" and type(next_cond) is not Not) or (type(next_cond) is Not and ant_rml_type != "del"):
            return False
        # if dealing with a Not statement, we need to compare against the argument.
        if isinstance(next_cond, Not): 
            cond = next_cond.argument
        # if dealing with a When statement, we need to compare against the When effect.
        elif isinstance(next_cond, When):
            cond = next_cond.effect.operands
            if len(cond) > 1:
                # TODO: ground When operators by splitting them by effect?
                raise NotImplementedError("Handle When clauses with plural effects?")
            cond = cond[0]
        if isinstance(ant_rml.term, RMLTerm):
            if ant_rml.nestings:

                if self.check_ant_rml_nestings(ant_rml, cond, soft_check=True):
                    
                    return True
            # if there's no antecedent nestings, then anything can be matched.
            else:
                self.rml = deepcopy(cond)
                return True
        elif isinstance(ant_rml.term, PredTerm):
            if ant_rml.nestings:
                if self.check_ant_rml_nestings(ant_rml, cond, soft_check=False):
                    self.pred = deepcopy(cond)
                    return True
            else:
                return isinstance(cond.term, Predicate)
        elif isinstance(ant_rml.term, RMLTermNegated):
            # indicates that cond is a Predicate (no modalities) and also is not negated.
            if not cond.nestings: 
                return False
            elif ant_rml.nestings:
                if not self.check_ant_rml_nestings(ant_rml, cond, soft_check=True):
                    return False
            # create a copy of the cond's nestings after the RML point, and add a negation.
            # we basically want to isolate the {rml}.
            temp_nestings = [NOT_MODL()] + cond.nestings[len(ant_rml.nestings):] if len(cond.nestings) > len(ant_rml.nestings) else []
            # recreate the SeparatedRMLTerm with these new nestings, which will also put the nestings in normal form.
            self.rml = SeparatedRMLTerm(deepcopy(temp_nestings), deepcopy(cond.term))
            return True
        elif isinstance(ant_rml.term, PredTermNegated):
            # indicates that cond is a Predicate (no modalities) and also is not negated.
            if not cond.nestings: 
                return False
            elif ant_rml.nestings:
                if not self.check_ant_rml_nestings(ant_rml, cond, soft_check=False):
                    return False
            # the cond predicate has to be negated
            if cond.nestings[-1] != NOT_MODL():
                return False
            # we want to isolate the {pred}, so return the "pure" version without the negation.
            self.pred = SeparatedRMLTerm(list(), deepcopy(cond.term))
            return True
        else:
            raise PDDLValidationError(f"Unknown Antecedent RML type {type(ant_rml)}")

    def apply_cond_eff(self, o):
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
                    self.reset()

    def apply_cond_effs(self):
        for action in self.domain.actions:
            for o in action.effect.operands:
                new_rmls = self.apply_cond_eff(o)