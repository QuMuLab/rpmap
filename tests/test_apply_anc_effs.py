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


class TestApplyAncEffsSingle:
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
        request.cls.bel_bob = Nesting(GenericMODLType.BEL, Agent(Constant("bob", "agent")))
        request.cls.pbel_bob = Nesting(PossibleGenericMODLType.PBEL, Agent(Constant("bob", "agent")))
        request.cls.des_bob = Nesting(GenericMODLType.DES, Agent(Constant("bob", "agent")))
        request.cls.pdes_bob = Nesting(PossibleGenericMODLType.PDES, Agent(Constant("bob", "agent")))
        request.cls.pred = Predicate("secret")
        request.cls.srt = SeparatedRMLTerm(list(), request.cls.pred)
        request.cls.pred2 = Predicate("secret2")
        request.cls.srt2 = SeparatedRMLTerm(list(), request.cls.pred2)
        request.cls.agents = grounded_domain._agents

    @pytest.fixture(autouse=True)
    def reset_data(self):
        yield
        self.apply_anc_effs.reset()

    def apply_anc_eff_helper(self, anc_eff, next_term, awareness = False, derive_condition = "never"):
        if self.apply_anc_effs.check_ant_match(anc_eff.antecedent.rml, anc_eff.antecedent.anceff_type, next_term, awareness, derive_condition):
            return [self.apply_anc_effs.sorted_str(self.apply_anc_effs.term_to_rml(term)) for term in self.apply_anc_effs.apply_anc_eff_all_nestings(anc_eff.consequent, next_term, awareness, derive_condition)]

    def apply_anc_effs_helper(self, next_term, derive_condition = "never", anc_effs = None):
        return [self.apply_anc_effs.sorted_str(self.apply_anc_effs.term_to_rml(term)) for term in self.apply_anc_effs.apply_anc_effs_to_action(next_term, derive_condition, anc_effs)]

    # ----- NEGATION REMOVAL -----
    def test_negation_removal(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, self.srt) == [self.apply_anc_effs.sorted_str(cleaned_not(p))]

    def test_negation_removal_always_known(self):
        p = deepcopy(self.pred)
        p.always_known = True
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm(list(), p)) == [self.apply_anc_effs.sorted_str(p)]

    def test_negation_removal_modalities(self):
        term = self.pbel_alice(self.pred)
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm([self.bel_alice], self.pred)) == [self.apply_anc_effs.sorted_str(cleaned_not(self.pbel_alice(p)))]

    def test_negation_removal_modalities_2(self):
        term = self.pbel_alice(self.pred)
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm([self.pbel_alice, self.des_bob], self.pred)) == [self.apply_anc_effs.sorted_str(cleaned_not(self.bel_alice(self.pdes_bob(p))))]

    def test_negation_removal_modalities_3(self):
        assert self.apply_anc_eff_helper(self.negation_removal, SeparatedRMLTerm([self.bel_alice, NOT_MODL(), self.des_bob], self.pred)) == [self.apply_anc_effs.sorted_str(cleaned_not(self.pbel_alice(self.des_bob(self.pred))))]

    def test_negation_removal_when(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.negation_removal, When(create_and([SeparatedRMLTerm([self.bel_alice], self.pred)]), create_and([SeparatedRMLTerm([self.des_bob], self.pred)]))) == [self.apply_anc_effs.sorted_str(When(create_and([self.bel_alice(self.pred)]), create_and([cleaned_not(self.pdes_bob(p))])))]

    # ----- UNCERTAIN FIRING -----

    def test_uncertain_firing(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.uncertain_firing, self.srt) == [self.apply_anc_effs.sorted_str(cleaned_not(p))]

    def test_uncertain_firing_pos_condition(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.uncertain_firing, When(create_and([self.srt]), create_and([self.srt]))) == [self.apply_anc_effs.sorted_str(When(create_and([cleaned_not(p)]), create_and([cleaned_not(p)])))]

    def test_uncertain_firing_neg_condition(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.uncertain_firing, When(create_and([cleaned_not(self.srt)]), create_and([self.srt]))) == [self.apply_anc_effs.sorted_str(When(create_and([cleaned_not(self.pred)]), create_and([cleaned_not(p)])))]

    def test_uncertain_firing_pos_neg_cond(self):
        p = deepcopy(self.pred)
        p.negated = True
        assert self.apply_anc_eff_helper(self.uncertain_firing, When(create_and([cleaned_not(self.srt), SeparatedRMLTerm([NOT_MODL()], self.pred2)]), create_and([self.srt]))) == [self.apply_anc_effs.sorted_str(When(create_and([cleaned_not(self.pred), cleaned_not(self.pred2)]), create_and([cleaned_not(p)])))]

    def test_uncertain_firing_pos_neg_cond_always_known(self):
        p = deepcopy(self.pred)
        p.negated = True
        p2 = deepcopy(self.pred2)
        p2.always_known = True
        assert self.apply_anc_eff_helper(self.uncertain_firing, When(create_and([cleaned_not(self.srt), SeparatedRMLTerm(list(), p2)]), create_and([self.srt]))) == [self.apply_anc_effs.sorted_str(When(create_and([cleaned_not(self.pred), p2]), create_and([cleaned_not(p)])))]

    # ----- CLOSURE -----
    def test_closure(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.bel_alice], self.pred)) == [self.apply_anc_effs.sorted_str(self.pbel_alice(self.pred))]

    def test_closure_leading(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.bel_alice, self.des_bob], self.pred)) == [self.apply_anc_effs.sorted_str(self.pbel_alice(self.des_bob(self.pred)))]

    def test_closure_trailing(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.des_bob, self.bel_alice], self.pred)) == [self.apply_anc_effs.sorted_str(self.des_bob(self.pbel_alice(self.pred)))]

    def test_closure_middle(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.des_bob, self.bel_alice, self.pdes_bob], self.pred)) == [self.apply_anc_effs.sorted_str(self.des_bob(self.pbel_alice(self.pdes_bob(self.pred))))]

    def test_closure_double(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, SeparatedRMLTerm([self.bel_alice, self.bel_bob], self.pred)) == [self.apply_anc_effs.sorted_str(self.pbel_alice(self.bel_bob(self.pred))), self.apply_anc_effs.sorted_str(self.bel_alice(self.pbel_bob(self.pred)))]

    def test_closure_when(self):
        assert self.apply_anc_eff_helper(self.kd45closure__belief, When(create_and([SeparatedRMLTerm([self.des_bob], self.pred)]), SeparatedRMLTerm([self.des_bob, self.bel_alice, self.pdes_bob], self.pred))) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred)]), create_and([self.des_bob(self.pbel_alice(self.pdes_bob(self.pred)))])))]

    # ----- UN-CLOSURE -----
    def test_un_closure(self):
        assert self.apply_anc_eff_helper(self.kd45_un_closure__belief, cleaned_not(SeparatedRMLTerm([self.pbel_alice], self.pred))) == [self.apply_anc_effs.sorted_str(cleaned_not(self.bel_alice(self.pred)))]

    def test_un_closure_leading(self):
        assert self.apply_anc_eff_helper(self.kd45_un_closure__belief, cleaned_not(SeparatedRMLTerm([self.pbel_alice, self.des_bob], self.pred))) == [self.apply_anc_effs.sorted_str(cleaned_not(self.bel_alice(self.des_bob(self.pred))))]

    def test_un_closure_trailing(self):
        assert self.apply_anc_eff_helper(self.kd45_un_closure__belief, cleaned_not(SeparatedRMLTerm([self.des_bob, self.pbel_alice], self.pred))) == [self.apply_anc_effs.sorted_str(cleaned_not(self.des_bob(self.bel_alice(self.pred))))]

    def test_un_closure_middle(self):
        assert self.apply_anc_eff_helper(self.kd45_un_closure__belief, cleaned_not(SeparatedRMLTerm([self.des_bob, self.pbel_alice, self.pdes_bob], self.pred))) == [self.apply_anc_effs.sorted_str(cleaned_not(self.des_bob(self.bel_alice(self.pdes_bob(self.pred)))))]
        
    def test_un_closure_double(self):
        assert self.apply_anc_eff_helper(self.kd45_un_closure__belief, cleaned_not(SeparatedRMLTerm([self.pbel_alice, self.pbel_bob], self.pred))) == [self.apply_anc_effs.sorted_str(cleaned_not(self.bel_alice(self.pbel_bob(self.pred)))), self.apply_anc_effs.sorted_str(cleaned_not(self.pbel_alice(self.bel_bob(self.pred))))]

    def test_closure_when(self):
        assert self.apply_anc_eff_helper(self.kd45_un_closure__belief, When(create_and([SeparatedRMLTerm([self.des_bob], self.pred)]), cleaned_not(SeparatedRMLTerm([self.des_bob, self.pbel_alice, self.pdes_bob], self.pred)))) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred)]), create_and([cleaned_not(self.des_bob(self.bel_alice(self.pdes_bob(self.pred))))])))]

    # ----- MUTUAL AWARENESS (POSITIVE) -----
    def test_mutual_awareness_pos_dc_srt(self):
        # NOTE: the derive condition gets grounded with the rest of the domain, and the assignment to the derive condition variable $agent$ is stored then
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_pos__belief, self.srt, awareness=self.mutual_awareness_pos__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred)]), create_and([self.bel_bob(self.pred)])))
]
    def test_mutual_awareness_pos_poscond_dc_srt(self):
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_pos__belief, When(create_and([self.srt2]), create_and([self.srt])), awareness=self.mutual_awareness_pos__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred), self.bel_bob(self.pred2)]), create_and([self.bel_bob(self.pred)])))]

    def test_mutual_awareness_pos_negcond_dc_srt(self):
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_pos__belief, When(create_and([cleaned_not(self.srt2)]), create_and([self.srt])), awareness=self.mutual_awareness_pos__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred), NOT_MODL()(self.bel_bob(self.pred2))]), create_and([self.bel_bob(self.pred)])))]

    def test_mutual_awareness_pos_poscond_negcond_dc_srt(self):
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_pos__belief, When(create_and([cleaned_not(self.srt2), self.srt]), create_and([self.srt])), awareness=self.mutual_awareness_pos__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred), NOT_MODL()(self.bel_bob(self.pred2)), self.bel_bob(self.pred)]), create_and([self.bel_bob(self.pred)])))]

    # ----- MUTUAL AWARENESS (NEGATIVE) -----
    def test_mutual_awareness_neg_dc_srt(self):
        # NOTE: the derive condition gets grounded with the rest of the domain, and the assignment to the derive condition variable $agent$ is stored then
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_neg__belief, cleaned_not(self.srt), awareness=self.mutual_awareness_neg__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred)]), create_and([NOT_MODL()(self.bel_bob(self.pred))])))]

    def test_mutual_awareness_neg_poscond_dc_srt(self):
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_neg__belief, When(create_and([self.srt2]), create_and([cleaned_not(self.srt)])), awareness=self.mutual_awareness_neg__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred), self.bel_bob(self.pred2)]), create_and([NOT_MODL()(self.bel_bob(self.pred))])))]

    def test_mutual_awareness_neg_negcond_dc_srt(self):
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_neg__belief, When(create_and([cleaned_not(self.srt2)]), create_and([cleaned_not(self.srt)])), awareness=self.mutual_awareness_neg__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred), NOT_MODL()(self.bel_bob(self.pred2))]), create_and([NOT_MODL()(self.bel_bob(self.pred))])))]

    def test_mutual_awareness_neg_poscond_negcond_dc_srt(self):
        derive_condition = SeparatedRMLTerm([self.des_bob], self.pred)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_eff_helper(self.mutual_awareness_neg__belief, When(create_and([cleaned_not(self.srt2), self.srt]), create_and([cleaned_not(self.srt)])), awareness=self.mutual_awareness_neg__belief.antecedent.awareness, derive_condition=derive_condition) == [self.apply_anc_effs.sorted_str(When(create_and([self.des_bob(self.pred), NOT_MODL()(self.bel_bob(self.pred2)), self.bel_bob(self.pred)]), create_and([NOT_MODL()(self.bel_bob(self.pred))])))
]
    # ----- FORALL AGENTS -----
    def test_forall_agents(self):
        test_anc_eff = AncEff(
            name="test",
            parameters=None,
            antecedent=Antecedent(False, SeparatedRMLTerm(list(), RMLTerm()), "add"),
            consequent=Consequent(
                [ListCompAgents(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Variable("ag", ["agent"])))], self.pred))],
                None,
                [SeparatedRMLTerm(list(), RMLTerm())],
                "add"
            )
        )
        assert self.apply_anc_eff_helper(test_anc_eff, self.srt) == [self.apply_anc_effs.sorted_str(When(create_and([Nesting(GenericMODLType.BEL, a)(self.pred) for a in self.agents]), create_and([self.pred])))]

    def test_forall_var_agents(self):
        test_anc_eff = AncEff(
            name="test",
            parameters=None,
            antecedent=Antecedent(False, SeparatedRMLTerm(list(), RMLTerm()), "add"),
            consequent=Consequent(
                [ListCompVarAgents(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Variable("ag", ["agent"])))], RTerm()), Variable("pos"))],
                None,
                [SeparatedRMLTerm(list(), RMLTerm())],
                "add"
            )
        )
        assert self.apply_anc_eff_helper(test_anc_eff, When(create_and([self.srt2]), create_and([self.srt]))) == [self.apply_anc_effs.sorted_str(When(create_and([Nesting(GenericMODLType.BEL, a)(self.pred2) for a in self.agents]), create_and([self.pred])))]

    def test_forall_var_agents_2(self):
        test_anc_eff = AncEff(
            name="test",
            parameters=None,
            antecedent=Antecedent(False, SeparatedRMLTerm(list(), RMLTerm()), "add"),
            consequent=Consequent(
                [ListCompVarAgents(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Variable("ag", ["agent"])))], RTerm()), Variable("pos"))],
                None,
                [SeparatedRMLTerm(list(), RMLTerm())],
                "add"
            )
        )
        res = self.apply_anc_eff_helper(test_anc_eff, When(create_and([SeparatedRMLTerm([self.bel_alice, self.des_bob], self.pred2)]), create_and([self.srt])))
        expected = self.apply_anc_effs.sorted_str(
            When(
                create_and([Nesting(GenericMODLType.BEL, a)(self.bel_alice(self.des_bob(self.pred2))) for a in self.agents]),
                create_and([self.pred])
            )
        )
        assert res == [expected]

    def test_forall_var_agents_2_derive_condition(self):
        pred3 = Predicate("secret3")
        derive_condition = SeparatedRMLTerm([self.des_bob], pred3)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        test_anc_eff = AncEff(
            name="test",
            parameters=None,
            antecedent=Antecedent(True, SeparatedRMLTerm(list(), RMLTerm()), "add"),
            consequent=Consequent(
                [ListCompVarAgents(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Variable("ag", ["agent"])))], RTerm()), Variable("pos"))],
                None,
                [SeparatedRMLTerm(list(), RMLTerm())],
                "add"
            )
        )
        res = self.apply_anc_eff_helper(test_anc_eff, When(create_and([SeparatedRMLTerm([self.bel_alice, self.des_bob], self.pred2)]), create_and([self.srt])), True, derive_condition)
        expected = self.apply_anc_effs.sorted_str(
            When(
                create_and([Nesting(GenericMODLType.BEL, a)(self.bel_alice(self.des_bob(self.pred2))) for a in self.agents] + [self.des_bob(pred3)]),
                create_and([self.pred])
            )
        )
        assert res == [expected]

    # ----- RECURSIVE TESTS -----
    def test_recursive_anc_effs_closure(self):
        self.apply_anc_effs_helper(SeparatedRMLTerm([self.bel_alice, self.bel_bob], self.pred), anc_effs=["kd45closure__belief"]) == \
            [self.apply_anc_effs.sorted_str(term) for term in [self.pbel_alice(self.bel_bob(self.pred)), self.bel_alice(self.pbel_bob(self.pred)), self.pbel_alice(self.pbel_bob(self.pred))]]

    def test_recursive_anc_effs_closure_belief_desire(self):
        self.apply_anc_effs_helper(SeparatedRMLTerm([self.bel_alice, self.des_bob], self.pred), anc_effs=["kd45closure__belief", "kd45closure__desire"]) == \
            [self.apply_anc_effs.sorted_str(term) for term in [self.pbel_bob(self.des_bob(self.pred)), self.bel_bob(self.pdes_bob(self.pred)), self.pbel_bob(self.pdes_bob(self.pred)), self.bel_bob(self.pdes_bob(self.pred))]]
    
    
    def test_recursive_anc_effs_mutual_awareness_closure(self):
        pred3 = Predicate("secret3")
        derive_condition = SeparatedRMLTerm([self.des_bob], pred3)
        derive_condition.assignment = {Variable("dlr_agent", ["agent"]): Constant("bob", "agent")}
        assert self.apply_anc_effs_helper(self.srt, derive_condition=derive_condition, anc_effs=["kd45closure__belief", "mutual-awareness-pos__belief"]) == \
        [self.apply_anc_effs.sorted_str(term) for term in [
            When(create_and([self.des_bob(pred3)]), create_and([(self.bel_bob(self.pred))])),
            When(create_and([self.des_bob(pred3)]), create_and([(self.pbel_bob(self.pred))])),
            When(create_and([self.bel_bob(self.des_bob(pred3)), self.des_bob(pred3)]), create_and([(self.bel_bob(self.pred))])),
            When(create_and([self.bel_bob(self.des_bob(pred3)), self.des_bob(pred3)]), create_and([(self.pbel_bob(self.pred))]))
        ]]
        assert self.apply_anc_effs_helper(self.srt, derive_condition=derive_condition, anc_effs=["mutual-awareness-pos__belief", "kd45closure__belief"]) == \
        [self.apply_anc_effs.sorted_str(term) for term in [
            When(create_and([self.des_bob(pred3)]), create_and([(self.bel_bob(self.pred))])),
            When(create_and([self.bel_bob(self.des_bob(pred3)), self.des_bob(pred3)]), create_and([(self.bel_bob(self.pred))])),
            When(create_and([self.des_bob(pred3)]), create_and([(self.pbel_bob(self.pred))])),
            When(create_and([self.bel_bob(self.des_bob(pred3)), self.des_bob(pred3)]), create_and([(self.pbel_bob(self.pred))]))
        ]]

    def test_recursive_anc_effs_negation_removal_un_closure(self):
        assert self.apply_anc_effs_helper(SeparatedRMLTerm([self.bel_alice], self.pred), anc_effs=["negation-removal", "kd45-un-closure__belief"]) == \
            [
                self.apply_anc_effs.sorted_str(term) for term in [
                    Not(NOT_MODL()(self.bel_alice(self.pred))),
                    Not((self.bel_alice(NOT_MODL()(self.pred)))),
                ]
            ]