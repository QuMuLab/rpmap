from pddl.logic.base import And
from pddl.logic.effects import When
from pddl.logic.terms import Variable
from pddl.parser import GRAMMAR_FILE
from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.apply_anc_effs import ApplyAncEffs
from refactored_rpmap.parsing_and_grounding.parser_setup import read_pdkbddl_file
from refactored_rpmap.parsing_and_grounding.utils import cleaned_not, create_and
from run import parse, ground
import pytest
import os


class TestApplyAncEffs:
    @pytest.fixture(scope="class", autouse=True)
    def setup(self, request):
        # retrieve the current grammar file
        with open(GRAMMAR_FILE, "r") as f:
            grammar = f.read()
        # we instantiate the ApplyAncEffs class with empty templates for the ancillary effects, domain, and problem
        result = parse(grammar, "\n".join(read_pdkbddl_file(os.path.join(*(os.getcwd().split() + ["tests", "parsing_templates", "problem_template_default_anc_effs.pdkbddl"])))))
        anc_effs, grounded_domain, grounded_problem = (result[1][0], *ground(result[1][0], result[0], result[2]))
        for anc_eff in anc_effs:
            setattr(request.cls, anc_eff.name.replace("-", "_"), anc_eff)
        request.cls.apply_anc_effs = ApplyAncEffs(anc_effs, grounded_domain, grounded_problem)
        # set up some template data
        request.cls.bel_a = Nesting(GenericMODLType.BEL, Agent(Variable("a", ["agent"])))
        request.cls.pbel_a = Nesting(PossibleGenericMODLType.PBEL, Agent(Variable("a", ["agent"])))
        request.cls.des_b = Nesting(GenericMODLType.DES, Agent(Variable("b", ["agent"])))
        request.cls.pdes_b = Nesting(PossibleGenericMODLType.PDES, Agent(Variable("b", ["agent"])))
        request.cls.bel_alice = Nesting(GenericMODLType.BEL, Agent(Constant("alice", "agent")))
        request.cls.pbel_alice = Nesting(PossibleGenericMODLType.PBEL, Agent(Constant("alice", "agent")))
        request.cls.des_bob = Nesting(GenericMODLType.DES, Agent(Constant("bob", "agent")))
        request.cls.pdes_bob = Nesting(PossibleGenericMODLType.PDES, Agent(Constant("bob", "agent")))
        request.cls.pred = Predicate("secret")
        request.cls.srt = SeparatedRMLTerm(list(), request.cls.pred)
        request.cls.pred_term = SeparatedRMLTerm(list(), PredTerm())
        request.cls.pred_term_modality = SeparatedRMLTerm([self.bel_a], PredTerm())
        request.cls.pred_term_negated = SeparatedRMLTerm(list(), PredTermNegated())
        request.cls.rml_term = SeparatedRMLTerm(list(), RMLTerm())
        request.cls.rml_term_modality = SeparatedRMLTerm([self.bel_a], RMLTerm())
        request.cls.rml_term_negated = SeparatedRMLTerm(list(), RMLTermNegated())
        request.cls.leading_nesting = SeparatedRMLTerm([LeadingNesting(self.bel_a)], RMLTerm())
        request.cls.trailing_nesting = SeparatedRMLTerm([TrailingNesting(self.bel_a)], RMLTerm())
        request.cls.leading_trailing_nesting = SeparatedRMLTerm([LeadingTrailingNesting(self.bel_a)], RMLTerm())
        

    @pytest.fixture(autouse=True)
    def reset_data(self):
        yield
        self.apply_anc_effs.reset()

    def apply_anc_eff_helper(self, anc_eff, next_term):
        if self.apply_anc_effs.check_ant_match(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_term):
            return self.apply_anc_effs.set_assignment_apply_anc_eff(anc_eff.parameters, anc_eff.consequent, next_term)

    # ----- NEGATION REMOVAL -----
    def test_negation_removal(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, self.srt) == [create_and([cleaned_not(p)])]

    def test_negation_removal_always_known(self):
        p = deepcopy(self.pred)
        p.always_known = True
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm(list(), p)) == [create_and([p])]

    def test_negation_removal_modalities(self):
        term = self.pbel_alice(self.pred)
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm([self.bel_alice], self.pred)) == [create_and([cleaned_not(self.pbel_alice(p))])]

    def test_negation_removal_modalities_2(self):
        term = self.pbel_alice(self.pred)
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm([self.pbel_alice, self.des_bob], self.pred)) == [create_and([cleaned_not(self.bel_alice(self.pdes_bob(p)))])]

    def test_negation_removal_modalities_3(self):
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm([self.bel_alice, NOT_MODL(), self.des_bob], self.pred)) == [create_and([cleaned_not(self.pbel_alice(self.des_bob(self.pred)))])]

    # ----- UNCERTAIN FIRING -----

    # ----- CLOSURE (BELIEF) -----
    def test_closure(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.bel_alice], self.pred)) == [create_and([self.pbel_alice(self.pred)])]

    def test_closure_leading(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.bel_alice, self.des_bob], self.pred)) == [create_and([self.pbel_alice(self.des_bob(self.pred))])]