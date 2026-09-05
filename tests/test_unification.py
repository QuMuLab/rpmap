from pddl.logic.base import Not, And
from pddl.logic.effects import When
from pddl.logic.terms import Variable
from pddl.parser import GRAMMAR_FILE
from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.apply_anc_effs import ApplyAncEffs
from refactored_rpmap.parsing_and_grounding.parser_setup import read_pdkbddl_file
from run import parse, ground
import pytest
import os


class TestUnification:
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

    @pytest.fixture(autouse=True)
    def reset_data(self):
        yield
        self.apply_anc_effs.reset()

    # ----- antecedent: {pred} -----
    def test_add_pred(self):
        assert self.apply_anc_effs.check_ant_match(self.pred_term, "add", self.srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_extra_modality(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term, "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_del_pred(self):
        assert self.apply_anc_effs.check_ant_match(self.pred_term, "del", Not(self.srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_extra_modality(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term, "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    # ----- antecedent: [modality]{pred} -----

    def test_add_pred_w_modalities(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.pred_term_modality, "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_w_modalities_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([NOT_MODL(), self.bel, self.des], PredTerm()), "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_mismatched_modality(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_modality, "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_add_pred_missing_modality(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], PredTerm()), "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_add_pred_missing_modality_2(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_modality, "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_del_pred_w_modalities(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], PredTerm()), "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_w_modalities_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([NOT_MODL(), self.bel, self.des], PredTerm()), "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_mismatched_modality(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_modality, "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    def test_del_pred_missing_modality(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], PredTerm()), "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    def test_del_pred_missing_modality_2(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_modality, "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    # ----- antecedent: !{pred} -----
    def test_add_pred_term_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.pred_term_negated, "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_term_negated_not_negated(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_negated, "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_add_pred_term_negated_extra_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_negated, "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_add_pred_term_negated_extra_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_negated, "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_add_pred_term_negated_triple_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL(), NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.pred_term_negated, "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_term_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.pred_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_term_negated_extra_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    def test_del_pred_term_negated_extra_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.pred_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    def test_del_pred_term_negated_triple_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL(), NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.pred_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term

    # ----- antecedent: [modality]!{pred} -----

    def test_add_pred_term_negated_w_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], PredTermNegated()), "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_term_negated_w_modality_2(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.pbel], PredTermNegated()), "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_term_negated_w_modality_3(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.des, self.pbel], PredTermNegated()), "add", srt)
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_term_negated_mismatched_modality(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], PredTermNegated()), "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_add_pred_term_negated_missing_modality(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], PredTermNegated()), "add", srt)
        assert self.apply_anc_effs.pred is None

    def test_del_pred_term_negated_w_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], PredTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_term_negated_w_modality_2(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.pbel], PredTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_term_negated_w_modality_3(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.des, self.pbel], PredTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.pred == self.srt.term    

    def test_del_pred_term_negated_mismatched_modality(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], PredTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    def test_del_pred_term_negated_missing_modality(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], PredTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.pred is None

    # ----- antecedent: {rml} ----- 

    def test_add_rml(self):
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", self.srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_modality(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_nested_modality(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_modality_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_not_added(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term, "add", Not(self.srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml(self):
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "del", Not(self.srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_modality(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_nested_modality(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_modality_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_not_deleted(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term, "del", self.srt)
        assert self.apply_anc_effs.rml is None

    def test_del_rml_not_deleted_nested_w_notmodl(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term, "del", srt)
        assert self.apply_anc_effs.rml is None

    # ----- antecedent: [modality]{rml} -----

    def test_add_modality_rml(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_modality, "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_modality_rml_no_modality(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_modality, "add", srt)
        assert self.apply_anc_effs.rml is None

    def test_add_modality_rml_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_modality, "add", srt)
        assert self.apply_anc_effs.rml is None

    def test_add_modality_rml_nested_modality(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], RMLTerm()), "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_modality_rml_not_added(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_modality, "add", Not(self.srt))
        assert self.apply_anc_effs.rml is None

    def test_add_modality_rml_nested_modality_soft(self):
        srt = SeparatedRMLTerm([self.bel, self.des, self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], RMLTerm()), "add", srt)
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.bel], self.pred)

    def test_del_modality_rml(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_modality, "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_modality_rml_no_modality(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_modality, "del", Not(srt))
        assert self.apply_anc_effs.rml is None

    def test_del_modality_rml_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_modality, "del", Not(srt))
        assert self.apply_anc_effs.rml is None

    def test_del_modality_rml_nested_modality(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], RMLTerm()), "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_modality_rml_not_deleted(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_modality, "del", self.srt)
        assert self.apply_anc_effs.rml is None

    def test_del_modality_rml_nested_modality_soft(self):
        srt = SeparatedRMLTerm([self.bel, self.des, self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel, self.des], RMLTerm()), "del", Not(srt))
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.bel], self.pred)

    # ----- antecedent: !{rml} -----
    
    def test_add_rml_term_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_term_negated_not_negated(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml is None

    def test_add_rml_term_negated_extra_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml is None

    def test_add_rml_term_negated_predicate(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", self.srt)
        assert self.apply_anc_effs.rml is None

    def test_add_rml_term_negated_triple_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL(), NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_term_negated_w_cond_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.pbel], self.pred)

    def test_add_rml_term_negated_w_cond_modality_2(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([NOT_MODL(), self.pbel], self.pred)

    def test_add_rml_term_negated_w_cond_modality_3(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL(), self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "add", srt)
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.pbel, self.des], self.pred)

    def test_del_rml_term_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_term_negated_not_negated(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml_term_negated_extra_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml_term_negated_predicate(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(self.srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml_term_negated_triple_negation(self):
        srt = SeparatedRMLTerm([NOT_MODL(), NOT_MODL(), NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_term_negated_w_cond_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.pbel], self.pred)

    def test_del_rml_term_negated_w_cond_modality_2(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([NOT_MODL(), self.pbel], self.pred)

    def test_del_rml_term_negated_w_cond_modality_3(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL(), self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.rml_term_negated, "del", Not(srt))
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.pbel, self.des], self.pred)

    # ----- antecedent: [modality]!{rml} -----

    def test_add_rml_term_negated_w_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_term_negated_w_modality_2(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.pbel], RMLTermNegated()), "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_term_negated_w_modality_3(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.pbel], RMLTermNegated()), "add", srt)
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.des], self.srt.term)

    def test_add_rml_term_negated_w_modality_4(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.des, self.pbel], RMLTermNegated()), "add", srt)
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_term_negated_mismatched_modality(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "add", srt)
        assert self.apply_anc_effs.rml is None

    def test_add_rml_term_negated_missing_modality(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "add", srt)
        assert self.apply_anc_effs.rml is None

    def test_del_rml_term_negated_w_modality(self):
        srt = SeparatedRMLTerm([self.bel, NOT_MODL()], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_term_negated_w_modality_2(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.pbel], RMLTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_term_negated_w_modality_3(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.pbel], RMLTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.rml == SeparatedRMLTerm([self.des], self.srt.term)

    def test_del_rml_term_negated_w_modality_4(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL(), self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.des, self.pbel], RMLTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_term_negated_mismatched_modality(self):
        srt = SeparatedRMLTerm([self.des, NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml_term_negated_missing_modality(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "del", Not(srt))
        assert self.apply_anc_effs.rml is None


    # ----- antecedent: {nesting}[bel, ?a]]{rml} ----- 

    def test_add_leading_nesting(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[]]

    def test_add_leading_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.des, self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des]]

    def test_add_leading_nesting_no_cond_nesting(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_add_leading_nesting_wrong_pos(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_add_leading_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_del_leading_nesting(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[]]

    def test_del_leading_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.des, self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des]]

    def test_del_leading_nesting_wrong_pos(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings is None

    def test_del_leading_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_nesting, "add", Not(srt))
        assert self.apply_anc_effs.nestings is None

    # ----- antecedent: [bel, ?a]{nesting}{rml} ----- 

    def test_add_trailing_nesting(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[]]

    def test_add_trailing_nesting_no_cond_nesting(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_add_trailing_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des]]

    def test_add_trailing_nesting_wrong_pos(self):
        srt = SeparatedRMLTerm([self.des, self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_add_trailing_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_del_trailing_nesting(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[]]

    def test_del_trailing_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des]]

    def test_del_trailing_nesting_wrong_pos(self):
        srt = SeparatedRMLTerm([self.des, self.bel], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings is None

    def test_del_trailing_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.trailing_nesting, "add", Not(srt))
        assert self.apply_anc_effs.nestings is None

    # ----- antecedent: {nesting}[bel, ?a]{nesting} ----- 

    def test_add_leading_trailing_nesting(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[], []]

    def test_add_leading_trailing_nesting_no_cond_nesting(self):
        srt = SeparatedRMLTerm(list(), self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_add_leading_trailing_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[], [self.des]]

    def test_add_leading_trailing_nesting_extra_nesting_before(self):
        srt = SeparatedRMLTerm([self.des, self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des], []]

    def test_add_leading_trailing_nesting_extra_nesting_before_and_after(self):
        srt = SeparatedRMLTerm([self.des, self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des], [self.des]]

    def test_add_leading_trailing_nesting_extra_nesting_after_multiple(self):
        srt = SeparatedRMLTerm([self.des, self.bel, self.des, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des], [self.des, self.des]]

    def test_add_leading_trailing_nesting_extra_nesting_before_multiple(self):
        srt = SeparatedRMLTerm([self.des, self.des, self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des, self.des], [self.des]]

    def test_add_leading_trailing_nesting_extra_nesting_before_after_multiple(self):
        srt = SeparatedRMLTerm([self.des, self.des, self.bel, self.des, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings == [[self.des, self.des], [self.des, self.des]]

    def test_add_leading_trailing_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", srt)
        assert self.apply_anc_effs.nestings is None

    def test_del_leading_trailing_nesting(self):
        srt = SeparatedRMLTerm([self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[], []]

    def test_del_leading_trailing_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[], [self.des]]

    def test_del_leading_trailing_nesting_extra_nesting_before(self):
        srt = SeparatedRMLTerm([self.des, self.bel], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des], []]

    def test_del_leading_trailing_nesting_extra_nesting_before_and_after(self):
        srt = SeparatedRMLTerm([self.des, self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des], [self.des]]

    def test_del_leading_trailing_nesting_extra_nesting_after_multiple(self):
        srt = SeparatedRMLTerm([self.des, self.bel, self.des, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des], [self.des, self.des]]

    def test_del_leading_trailing_nesting_extra_nesting_before_multiple(self):
        srt = SeparatedRMLTerm([self.des, self.des, self.bel, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des, self.des], [self.des]]

    def test_del_leading_trailing_nesting_extra_nesting_before_after_multiple(self):
        srt = SeparatedRMLTerm([self.des, self.des, self.bel, self.des, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings == [[self.des, self.des], [self.des, self.des]]

    def test_del_leading_trailing_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], self.pred)
        assert not self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "del", Not(srt))
        assert self.apply_anc_effs.nestings is None

    # ----- When formula testing -----

    def test_add_pred_when(self):
        eff = And(*[])
        eff._operands.append(self.srt)
        assert self.apply_anc_effs.check_ant_match(self.pred_term, "add", When(And(), self.srt))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_pred_when_w_and(self):
        eff = And(*[])
        eff._operands.append(self.srt)
        assert self.apply_anc_effs.check_ant_match(self.pred_term, "add", When(And(), eff))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_when(self):
        assert self.apply_anc_effs.check_ant_match(self.pred_term, "del", When(And(), Not(self.srt)))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_del_pred_when_not_negated(self):
        assert not self.apply_anc_effs.check_ant_match(self.pred_term, "del", When(And(), self.srt))
        assert self.apply_anc_effs.pred is None

    def test_del_pred_when_w_and(self):
        eff = And(*[])
        eff._operands.append(Not(self.srt))
        assert self.apply_anc_effs.check_ant_match(self.pred_term, "del", When(And(), eff))
        assert self.apply_anc_effs.pred == self.srt.term

    def test_add_rml_when(self):
        eff = And(*[])
        eff._operands.append(self.srt)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", When(And(), self.srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_when_multiple_cond(self):
        eff = And(*[])
        eff._operands.append(self.srt)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", When(And(self.pred, Predicate("test")), self.srt))
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_when_w_and(self):
        eff = And(*[])
        eff._operands.append(self.srt)
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "add", When(And(), eff))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_when(self):
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "del", When(And(), Not(self.srt)))
        assert self.apply_anc_effs.rml == self.srt

    def test_del_rml_when_not_negated(self):
        assert not self.apply_anc_effs.check_ant_match(self.rml_term, "del", When(And(), self.srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml_when_w_and(self):
        eff = And(*[])
        eff._operands.append(Not(self.srt))
        assert self.apply_anc_effs.check_ant_match(self.rml_term, "del", When(And(), eff))
        assert self.apply_anc_effs.rml == self.srt

    def test_add_rml_when_complex(self):
        srt = SeparatedRMLTerm([self.des, self.des, self.bel, self.des, self.des], self.pred)
        assert self.apply_anc_effs.check_ant_match(self.leading_trailing_nesting, "add", When(And(), srt))
        assert self.apply_anc_effs.nestings == [[self.des, self.des], [self.des, self.des]]

    def test_del_rml_when_complex(self):
        srt = SeparatedRMLTerm([NOT_MODL()], self.pred)
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([self.bel], RMLTermNegated()), "del", When(And(), Not(srt)))
        assert self.apply_anc_effs.rml is None

    # ----- type error testing ----- 
    def test_unknown_antecedent_rml_term_type(self):
        with pytest.raises(PDDLValidationError):
            self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), Variable("v")), "add", self.srt)
    
    def test_unknown_antecedent_rml_type_2(self):
        with pytest.raises(PDDLValidationError):
            self.apply_anc_effs.check_ant_match(self.srt, "del", Not(Not(self.srt)))
        
    def test_unknown_antecedent_rml_type_3(self):        
        with pytest.raises(PDDLValidationError):
            self.apply_anc_effs.check_ant_match(self.srt, "del", When(And(), Not(Not(self.srt))))
        
    def test_unknown_antecedent_rml_type_4(self):
        with pytest.raises(PDDLValidationError):
            self.apply_anc_effs.check_ant_match(self.srt, "del", Not(When(And(), self.srt)))

    def test_unknown_nesting_term_type(self):
        with pytest.raises(PDDLValidationError):
            self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([MODLTermWNesting(self.bel)], RMLTerm()), "add", SeparatedRMLTerm([self.bel], self.pred))
