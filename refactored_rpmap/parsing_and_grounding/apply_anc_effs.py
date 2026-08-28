from .core.anc_eff import RMLTerm, PredTerm, RMLTermNegated, PredTermNegated, SeparatedRMLTerm, NOT_MODL, AncEffs
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

    @staticmethod
    def gen_id(cond):
        """Generate a unique ID for a condition based on its string representation."""
        # make it a unique 5-character hash
        import hashlib

        m = hashlib.md5()
        m.update(str(hash(cond)).encode("utf-8"))
        return m.hexdigest()[:8]

    @staticmethod
    def check_ant_rml_nestings(ant_rml: SeparatedRMLTerm, cond: SeparatedRMLTerm, soft_check: bool):
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
                if ApplyAncEffs.check_ant_rml_nestings(ant_rml, cond, soft_check=True):
                    remaining_cond_nestings = cond.nestings[len(ant_rml.nestings)] if len(cond.nestings) > len(ant_rml.nestings) else []
                    self.rml = SeparatedRMLTerm(deepcopy(remaining_cond_nestings), deepcopy(cond.term))
                    return True
            # if there's no antecedent nestings, then anything can be matched.
            else:
                self.rml = deepcopy(cond)
                return True
        elif isinstance(ant_rml.term, PredTerm):
            if ant_rml.nestings:
                if ApplyAncEffs.check_ant_rml_nestings(ant_rml, cond, soft_check=False):
                    self.pred = deepcopy(cond)
                    return True
            else:
                return isinstance(cond.term, Predicate)
        elif isinstance(ant_rml.term, RMLTermNegated):
            # indicates that cond is a Predicate (no modalities) and also is not negated.
            if not cond.nestings: 
                return False
            elif ant_rml.nestings:
                if not ApplyAncEffs.check_ant_rml_nestings(ant_rml, cond, soft_check=True):
                    return False
            # create a copy of the cond's nestings after the RML point, and add a negation.
            # we basically want to isolate the {rml}.
            temp_nestings = [NOT_MODL()] + cond.nestings[len(ant_rml.nestings)] if len(cond.nestings) > len(ant_rml.nestings) else []
            # recreate the SeparatedRMLTerm with these new nestings, which will also put the nestings in normal form.
            self.rml = SeparatedRMLTerm(deepcopy(temp_nestings), deepcopy(cond.term))
            return True
        elif isinstance(ant_rml.term, PredTermNegated):
            # indicates that cond is a Predicate (no modalities) and also is not negated.
            if not cond.nestings: 
                return False
            elif ant_rml.nestings:
                if not ApplyAncEffs.check_ant_rml_nestings(ant_rml, cond, soft_check=False):
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

    def apply_cond_effs(self):
        for action in self.domain.actions:
            for o in action.effect.operands:
                new_rmls = self.apply_cond_eff(o)