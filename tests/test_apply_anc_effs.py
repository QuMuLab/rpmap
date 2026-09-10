from pddl.logic.base import And
from pddl.logic.effects import When
from pddl.logic.terms import Variable
from pddl.parser import GRAMMAR_FILE
from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.apply_anc_effs import ApplyAncEffs
from refactored_rpmap.parsing_and_grounding.parser_setup import read_pdkbddl_file
from refactored_rpmap.parsing_and_grounding.utils import cleaned_not
from run import parse, ground
import pytest
import os
from .utils import get_template_anceff


class TestApplyAncEffs:
    @pytest.fixture(scope="class", autouse=True)
    def setup(self, request):
        # retrieve the current grammar file
        with open(GRAMMAR_FILE, "r") as f:
            grammar = f.read()
        # we instantiate the ApplyAncEffs class with empty templates for the ancillary effects, domain, and problem
        result = parse(grammar, "\n".join(read_pdkbddl_file(os.path.join(*(os.getcwd().split() + ["tests", "parsing_templates", "problem_template.pdkbddl"])))))
        anc_effs, grounded_domain, grounded_problem = (result[1][0], *ground(result[1][0], result[0], result[2]))
        request.cls.apply_anc_effs = ApplyAncEffs(anc_effs, grounded_domain, grounded_problem)
        # set up some template data
        request.cls.bel = Nesting(GenericMODLType.BEL, Agent(Variable("a", ["agent"])))
        request.cls.pbel = Nesting(PossibleGenericMODLType.PBEL, Agent(Variable("a", ["agent"])))
        request.cls.des = Nesting(GenericMODLType.DES, Agent(Variable("b", ["agent"])))
        request.cls.pdes = Nesting(PossibleGenericMODLType.PDES, Agent(Variable("b", ["agent"])))
        request.cls.pred = Predicate("secret")
        request.cls.srt = SeparatedRMLTerm(list(), request.cls.pred)
        request.cls.pred_term = SeparatedRMLTerm(list(), PredTerm())
        request.cls.pred_term_modality = SeparatedRMLTerm([self.bel], PredTerm())
        request.cls.pred_term_negated = SeparatedRMLTerm(list(), PredTermNegated())
        request.cls.rml_term = SeparatedRMLTerm(list(), RMLTerm())
        request.cls.rml_term_modality = SeparatedRMLTerm([self.bel], RMLTerm())
        request.cls.rml_term_negated = SeparatedRMLTerm(list(), RMLTermNegated())
        request.cls.leading_nesting = SeparatedRMLTerm([LeadingNesting(self.bel)], RMLTerm())
        request.cls.trailing_nesting = SeparatedRMLTerm([TrailingNesting(self.bel)], RMLTerm())
        request.cls.leading_trailing_nesting = SeparatedRMLTerm([LeadingTrailingNesting(self.bel)], RMLTerm())
        request.cls.anceff_template = get_template_anceff()

    @pytest.fixture(autouse=True)
    def reset_data(self):
        yield
        self.apply_anc_effs.reset()

    def apply_anc_eff_helper(self, anc_eff, next_term):
        if self.apply_anc_effs.check_ant_match(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_term):
            return self.apply_anc_effs.set_assignment_apply_anc_eff(anc_eff.parameters, anc_eff.consequent, next_term)

    def test_negation_removal(self):
        p = deepcopy(self.pred)
        p.negated = True
        and_ = And(*[])
        and_._operands = [cleaned_not(p)]
        assert self.apply_anc_eff_helper(self.anceff_template, self.srt) == [and_]

    def test_negation_removal_always_known(self):
        p = deepcopy(self.pred)
        p.always_known = True
        and_ = And(*[])
        and_._operands = [p]
        assert self.apply_anc_eff_helper(self.anceff_template, SeparatedRMLTerm(list(), p)) == [and_]