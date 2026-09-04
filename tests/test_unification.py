from pddl.logic.base import Not
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
        request.cls.des = Nesting(GenericMODLType.DES, Agent(Variable("b", ["agent"])))

    @pytest.fixture(autouse=True)
    def reset_data(self):
        yield
        self.apply_anc_effs.rml = None
        self.apply_anc_effs.pred = None
        self.apply_anc_effs.nestings = list()

    def test_add_rml(self):
        srt = SeparatedRMLTerm(list(), Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_modality(self):
        srt = SeparatedRMLTerm([self.bel], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_nested_modality(self):
        srt = SeparatedRMLTerm([self.bel, self.des], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_modality_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "add", srt)
        assert self.apply_anc_effs.rml == srt

    def test_add_rml_not_added(self):
        srt = SeparatedRMLTerm(list(), Predicate("secret"))
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "add", Not(srt))
        assert self.apply_anc_effs.rml is None

    def test_del_rml(self):
        srt = SeparatedRMLTerm(list(), Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_modality(self):
        srt = SeparatedRMLTerm([self.bel], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_nested_modality(self):
        srt = SeparatedRMLTerm([self.bel, self.des], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_modality_negated(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "del", Not(srt))
        assert self.apply_anc_effs.rml == srt

    def test_del_rml_not_deleted(self):
        srt = SeparatedRMLTerm(list(), Predicate("secret"))
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "del", srt)
        assert self.apply_anc_effs.rml is None

    def test_del_rml_not_deleted_nested_w_notmodl(self):
        srt = SeparatedRMLTerm([NOT_MODL(), self.bel], Predicate("secret"))
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm(list(), RMLTerm()), "del", srt)
        assert self.apply_anc_effs.rml is None

    def test_add_leading_nesting(self):
        srt = SeparatedRMLTerm([self.bel], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([LeadingNesting(self.bel)], RMLTerm()), "add", srt)
        assert len(self.apply_anc_effs.nestings) == 0

    def test_add_leading_nesting_extra_nesting(self):
        srt = SeparatedRMLTerm([self.des, self.bel], Predicate("secret"))
        assert self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([LeadingNesting(self.bel)], RMLTerm()), "add", srt)
        assert self.apply_anc_effs.nestings == [self.des]

    def test_add_leading_nesting_wrong_pos(self):
        srt = SeparatedRMLTerm([self.bel, self.des], Predicate("secret"))
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([LeadingNesting(self.bel)], RMLTerm()), "add", srt)
        assert len(self.apply_anc_effs.nestings) == 0

    def test_add_leading_nesting_no_match(self):
        srt = SeparatedRMLTerm([self.des], Predicate("secret"))
        assert not self.apply_anc_effs.check_ant_match(SeparatedRMLTerm([LeadingNesting(self.bel)], RMLTerm()), "add", srt)
        assert len(self.apply_anc_effs.nestings) == 0