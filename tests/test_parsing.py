from lark.exceptions import VisitError
from lark.exceptions import UnexpectedCharacters
from pddl.exceptions import PDDLValidationError
from pddl.logic.predicates import Predicate
from pddl.logic.base import And, Or, Not, Imply, ExistsCondition, ForallCondition, Formula
from pddl.logic.effects import When, Forall
from pddl.logic.terms import Variable, Constant
from pddl.action import Action
from pddl.parser.domain import Domain
from pddl.parser import GRAMMAR_FILE
from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.parser_setup import read_pdkbddl_file
from refactored_rpmap.parsing_and_grounding.apply_anc_effs import ApplyAncEffs
from run import parse, get_parsing_result
from copy import deepcopy
from enum import Enum
import pytest
import os


class PDDLSection(Enum):
    PREDICATE = 1
    ACTION = 2
    INIT = 3
    GOAL = 4
    ANC_EFF = 5

class TestParsing:
    # ----- SETUP FUNCTION -----
    @staticmethod
    def get_template_action():
        # create a generic Action object to test, based on the grapevine `share` action
        a_var = Variable("a", ["agent"])
        as_var = Variable("as", ["agent"])
        a2_var = Variable("a2", ["agent"])
        l_var = Variable("l", ["loc"])
        a_dlr_var = Variable("dlr_agent", ["agent"])
        secret = Predicate("secret", *[as_var])
        at_pred_1 = Predicate("at", *[a_dlr_var, l_var])
        at_pred_1.always_known = True
        at_pred_2 = Predicate("at", *[a_var, l_var])
        at_pred_2.always_known = True
        at_pred_3 = Predicate("at", *[a2_var, l_var])
        at_pred_3.always_known = True
        return Action(
            "share",
            derive_condition=SeparatedRMLTerm(list(), at_pred_1),
            parameters=[a_var, as_var, l_var],
            precondition=And(
                SeparatedRMLTerm(list(), at_pred_2), 
                SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(a_var))], secret)
            ),
            effect=And(
                Forall(
                    When(
                        And(SeparatedRMLTerm(list(), at_pred_3)),
                        And(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(a2_var))], secret))
                    ),
                    frozenset([a2_var])
                )
            )
        )

    @staticmethod
    def get_template_anceff():
        # create a generic AncEff object to test
        pos_var = Variable("pos")
        neg_var = Variable("neg")
        rml_term = RMLTerm()
        rml_term_negated = RMLTermNegated()
        return AncEff(
            name="some-anceff",
            parameters=None,
            antecedent=Antecedent(False, SeparatedRMLTerm(list(), rml_term), "add"),
            consequent=Consequent([Variable("pos")], [Variable("neg")], [SeparatedRMLTerm(list(), rml_term_negated)], "del")
        )

    @pytest.fixture(autouse=True)
    def reset_data(self):
        yield
        # upon test completion, reset the domain template file
        self.domain_data["predicate_insert"] = self.insert_str
        self.domain_data["action_insert"] = self.insert_str
        self.update_domain(self.domain_data)
        self.problem_data["import_insert"] = self.insert_str
        self.problem_data["init_insert"] = self.insert_str
        self.problem_data["goal_insert"] = self.insert_str
        self.update_problem(self.problem_data)
        self.anceff_data["anceff_insert"] = self.insert_str
        self.update_anceff(self.anceff_data)

    @pytest.fixture(scope="class", autouse=True)
    def setup(self, request):
        # retrieve the current grammar file
        with open(GRAMMAR_FILE, "r") as f:
            request.cls.grammar = f.read()
        # get the template files
        domain_path = os.path.join(*os.getcwd().split() + ["tests", "parsing_templates", "domain_template.pdkbddl"])
        with open(domain_path, "r") as f:
            domain = f.read()
        problem_path = os.path.join(*os.getcwd().split() + ["tests", "parsing_templates", "problem_template.pdkbddl"])
        with open(problem_path, "r") as f:
            problem = f.read()
        anceff_path = os.path.join(*os.getcwd().split() + ["tests", "parsing_templates", "anceff_template.pdkbddl"])
        with open(anceff_path, "r") as f:
            anceff = f.read()
        # create a dictionary that indicates the appropriate places to insert into the domain
        # note that two `{insert here}` comments are specified at the locations for predicate and action insertion in the `domain_template.pdkbddl` file
        request.cls.insert_str = ";; {insert here}"
        domain = domain.split(request.cls.insert_str)
        request.cls.domain_path = domain_path
        request.cls.domain_data = {
            "header": domain[0],
            "predicate_insert": "",
            "header_end": domain[1],
            "action_insert": "",
            "action_end": domain[2],
        }
        # do the same for the problem and ancillary effect templates
        problem = problem.split(request.cls.insert_str)
        request.cls.problem_path = problem_path
        request.cls.problem_data = {
            "include_domain": problem[0],
            "import_insert": "",
            "header": problem[1],
            "init_insert": "",
            "header_end": problem[2],
            "goal_insert": "",
            "goal_end": problem[3],
        }
        anceff = anceff.split(request.cls.insert_str)
        request.cls.anceff_path = anceff_path
        request.cls.anceff_data = {
            "header": anceff[0],
            "anceff_insert": "",
            "header_end": anceff[1],
        }
        # set template action and ancillary effect
        request.cls.action_template = TestParsing.get_template_action()
        request.cls.anceff_template = TestParsing.get_template_anceff()

    # ----- TEMPLATE FILE UPDATE FUNCTIONS -----

    def update_domain(self, new_domain_data: dict[str, str]):
        self.domain_str = "".join(new_domain_data.values())
        with open(self.domain_path, "w") as f:
            f.write(self.domain_str)

    def update_problem(self, new_problem_data: dict[str, str]):
        self.problem_str = "".join(new_problem_data.values())
        with open(self.problem_path, "w") as f:
            f.write(self.problem_str)

    def update_anceff(self, new_anceff_data: dict[str, str]):
        self.anceff_str = "".join(new_anceff_data.values())
        with open(self.anceff_path, "w") as f:
            f.write(self.anceff_str)

    def insert_domain_data(self, data_place: str, data: str):
        data_copy = deepcopy(self.domain_data)
        data_copy[data_place] = data
        self.update_domain(data_copy)

    def insert_problem_data(self, data_place: str, data: str):
        data_copy = deepcopy(self.problem_data)
        data_copy[data_place] = data
        self.update_problem(data_copy)

    def insert_anceff_data(self, data_place: str, data: str):
        data_copy = deepcopy(self.anceff_data)
        data_copy[data_place] = data
        self.update_anceff(data_copy)

    def insert_predicate(self, pred_str: str):
        self.insert_domain_data("predicate_insert", pred_str)

    def insert_action(self, action_str: str):
        self.insert_domain_data("action_insert", action_str)

    def insert_init(self, init_str: str):
        self.insert_problem_data("init_insert", init_str)

    def insert_goal(self, goal_str: str):
        self.insert_problem_data("goal_insert", goal_str)

    def insert_anceff(self, anceff_str: str):
        self.insert_anceff_data("anceff_insert", anceff_str)

    # ----- TESTING HELPER FUNCTIONS -----

    def get_parsed_domain(self):
        return parse(self.grammar, self.domain_str)[0]

    def get_parsed_problem(self):
        return parse(self.grammar, "\n".join(read_pdkbddl_file(self.problem_path)))[2]

    def get_parsed_anceff(self):
        self.insert_problem_data("import_insert", "{include:anceff_template.pdkbddl}")
        return parse(self.grammar, "\n".join(read_pdkbddl_file(self.problem_path)))[1]

    def valid_predicate_tester(self, pred_str: str, pred_obj: Predicate):
        self.insert_predicate(pred_str)
        domain = self.get_parsed_domain()
        assert pred_obj in domain.predicates

    def valid_action_tester(self, act_str: str, action_obj: Action):
        self.insert_action(act_str)
        domain = self.get_parsed_domain()
        assert action_obj in domain.actions

    def valid_init_tester(self, init_str: str, init_obj: Formula):
        self.insert_init(init_str)
        problem = self.get_parsed_problem()
        assert init_obj in problem.init

    def valid_goal_tester(self, goal_str: str, goal_obj: Formula):
        self.insert_goal(goal_str)
        problem = self.get_parsed_problem()
        assert goal_obj in problem.goal

    def valid_anceff_tester(self, anceff_str: str, anceff_obj: AncEff):
        self.insert_anceff(anceff_str)
        anc_effs = self.get_parsed_anceff()
        assert anceff_obj in anc_effs[0].anceffs

    def error_tester(self, insert_type: PDDLSection, new_data: str, errors: list[Exception]):
        with pytest.raises(errors[0]) as outer_e:
            if insert_type == PDDLSection.PREDICATE:
                self.insert_predicate(new_data)
                self.get_parsed_domain()
            elif insert_type == PDDLSection.ACTION:
                self.insert_action(new_data)
                self.get_parsed_domain()
            elif insert_type == PDDLSection.INIT:
                self.insert_init(new_data)
                self.get_parsed_problem()
            elif insert_type == PDDLSection.GOAL:
                self.insert_goal(new_data)
                self.get_parsed_problem()
            elif insert_type == PDDLSection.ANC_EFF:
                self.insert_anceff(new_data)
                self.get_parsed_anceff()
        for e in errors[1:]:
            assert isinstance(outer_e.value.orig_exc, e)

    def error_tester_predicates(self, pred_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.PREDICATE, pred_str, errors)

    def error_tester_actions(self, action_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.ACTION, action_str, errors)

    def error_tester_init(self, init_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.INIT, init_str, errors)

    def error_tester_goal(self, goal_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.GOAL, goal_str, errors)

    def error_tester_anceff(self, anceff_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.ANC_EFF, anceff_str, errors)

    # ----- TESTS -----

    # PREDICATE PARSING

    def test_predicate_not_always_known(self):
        self.valid_predicate_tester("(whisper ?a1 ?a2 - agent ?l - loc)", Predicate("whisper", *[Variable("a1", ["agent"]), Variable("a2", ["agent"]), Variable("l", ["loc"])]))
        self.valid_predicate_tester("(whisper2)", Predicate("whisper2"))

    def test_predicate_always_known(self):
        pred = Predicate("whisper", *[Variable("a1", ["agent"]), Variable("a2", ["agent"]), Variable("l", ["loc"])])
        pred.always_known = True
        self.valid_predicate_tester("{AK}(whisper ?a1 ?a2 - agent ?l - loc)", pred)

    def test_predicate_unknown_type(self):
        self.error_tester_predicates("{AK}(whisper ?a1 ?a2 - agent ?v - volume)", [VisitError, PDDLValidationError])

    def test_predicate_illegal_name(self):
        self.error_tester_predicates("{AK}(rml ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])
        self.error_tester_predicates("{AK}(r ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])
        self.error_tester_predicates("(rml ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])
        self.error_tester_predicates("(r ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])

    def test_predicate_illegal_syntax(self):
        self.error_tester_predicates("{AK}sjfdklwefk", [UnexpectedCharacters])
        self.error_tester_predicates("{AK}()", [UnexpectedCharacters])
        self.error_tester_predicates("sjfdklwefk", [UnexpectedCharacters])
        self.error_tester_predicates("()", [UnexpectedCharacters])

    #  ACTION PARSING

    def test_template_action(self):
        self.valid_action_tester("""
    (:action share
        :derive-condition   (at $agent$ ?l)
        :parameters         (?a ?as - agent ?l - loc)
        :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
        :effect             (and
                                (forall (?a2 - agent)
                                    (when (at ?a2 ?l)
                                        [bel, ?a2](secret ?as)))
                            )
    )""",
        self.action_template
    )

    def test_template_action(self):
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            self.action_template
        )

    def test_derive_condition_always(self):
        action = deepcopy(self.action_template)
        action.derive_condition = "always"
        self.valid_action_tester("""
        (:action share
            :derive-condition   always
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_derive_condition_never(self):
        action = deepcopy(self.action_template)
        action.derive_condition = "never"
        self.valid_action_tester("""
        (:action share
            :derive-condition   never
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_derive_condition_modality(self):
        action = deepcopy(self.action_template)
        dlr_agent = Variable("dlr_agent", ["agent"])
        action.derive_condition = RML(GenericMODLType.BEL, Agent(dlr_agent), Predicate("at", *[dlr_agent, Variable("l", *["loc"])]))

        self.valid_action_tester("""
        (:action share
            :derive-condition   [bel, $agent$](at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_empty_precondition(self):
        action = deepcopy(self.action_template)
        action._precondition = Or()
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       ()
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_or_precondition(self):
        action = deepcopy(self.action_template)
        or_ = Or()
        or_._operands = self.action_template.precondition.operands
        action._precondition = or_
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (or (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_negated_precondition(self):
        action = deepcopy(self.action_template)
        action._precondition = And(*[Not(p) for p in action._precondition._operands])
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (not (at ?a ?l)) (not [bel, ?a](secret ?as)))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_implied_precondition(self):
        action = deepcopy(self.action_template)
        action._precondition = And(Imply(*action._precondition._operands))
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (imply (at ?a ?l) [bel, ?a](secret ?as)))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_exists_precondition(self):
        action = deepcopy(self.action_template)
        action._precondition = And(*[ExistsCondition(action._precondition._operands[1], {Variable("a", ["agent"])})])
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (exists (?a - agent) [bel, ?a](secret ?as)))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_forall_precondition(self):
        action = deepcopy(self.action_template)
        action._precondition = And(*[ForallCondition(action._precondition._operands[1], {Variable("a", ["agent"])})])
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (forall (?a - agent) [bel, ?a](secret ?as)))
            :effect             (and
                                    (forall (?a2 - agent)
                                        (when (at ?a2 ?l)
                                            [bel, ?a2](secret ?as)))
                                )
        )""",
            action
        )

    def test_action_empty_effect(self):
        action = deepcopy(self.action_template)
        action._effect = Or()
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             ()
        )""",
            action
        )

    def test_action_negated_effect(self):
        action = deepcopy(self.action_template)
        action._effect = Not(action._effect.effect.effect)
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (not [bel, ?a2](secret ?as))
                                )
        )""",
            action
        )

    def test_action_negated_rml(self):
        action = deepcopy(self.action_template)
        action._effect = SeparatedRMLTerm([NOT_MODL()] + action._effect.effect.effect.nestings, action._effect.effect.effect.term)
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    ![bel, ?a2](secret ?as)
                                )
        )""",
            action
        )
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    <bel, ?a2>(!secret ?as)
                                )
        )""",
            action
        )

    def test_action_negated_pred(self):
        action = deepcopy(self.action_template)
        action._effect = SeparatedRMLTerm([NOT_MODL()], action._effect.effect.effect.term)
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (!secret ?as)
                                )
        )""",
            action
        )
        action._effect = SeparatedRMLTerm([NOT_MODL(), NOT_MODL()], action._effect.term)
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (secret ?as)
                                )
        )""",
            action
        )
        action._effect = Not(SeparatedRMLTerm([NOT_MODL()], action._effect.term))
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (not (!secret ?as))
                                )
        )""",
            action
        )

    def test_action_negate_always_known(self):
        action = deepcopy(self.action_template)
        at_p = Predicate("at", Variable("as", ["agent"]), Variable("l", ["loc"]))
        at_p.always_known = True
        action._effect = Not(SeparatedRMLTerm(list(), at_p))
        self.valid_action_tester("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (not (at ?as ?l))
                                )
        )""",
            action
        )
        self.error_tester_actions("""
        (:action share
            :derive-condition   (at $agent$ ?l)
            :parameters         (?a ?as - agent ?l - loc)
            :precondition       (and (at ?a ?l) [bel, ?a](secret ?as))
            :effect             (and
                                    (!at ?as ?l)
                                )
        )
        """,
        [VisitError, PDDLValidationError]
        )

    #  INITIAL STATE PARSING
    def test_problem_init_predicate(self):
        self.valid_init_tester("(secret alice)", SeparatedRMLTerm(list(), Predicate("secret", Constant("alice", "agent"))))

    def test_problem_init_rml(self):
        secret = Predicate("secret", Constant("alice", "agent"))
        self.valid_init_tester("[bel, bob](secret alice)", SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Constant("bob", "agent")))], secret))
        self.valid_init_tester("![bel, bob](!secret alice)", SeparatedRMLTerm([Nesting(PossibleGenericMODLType.PBEL, Agent(Constant("bob", "agent")))], secret))

    def test_problem_init_and_rml(self):
        self.valid_init_tester("(and [bel, bob](secret alice) (secret alice))", And(*[SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Constant("bob", "agent")))], Predicate("secret", Constant("alice", "agent"))), SeparatedRMLTerm(list(), Predicate("secret", Constant("alice", "agent")))]))

    def test_problem_init_forall(self):
        self.valid_init_tester("(forall (?a - agent) [bel, ?a](secret ?a))", Forall(And(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Variable("a", ["agent"])))], Predicate("secret", Variable("a", ["agent"])))), {Variable("a", ["agent"])}))

    def test_exc_negate(self):
        p = SeparatedRMLTerm([NOT_MODL()], Predicate("secret", Constant("alice", "agent")))
        self.valid_init_tester("(!secret alice)", p)

    def test_problem_init_no_not(self):
        self.error_tester_init("(not (secret alice))", [UnexpectedCharacters])

    def test_problem_init_negate_always_known(self):
        self.error_tester_init("(!at alice l1)", [VisitError, PDDLValidationError])

    # GOAL STATE PARSING

    def test_problem_goal_predicate(self):
        self.valid_goal_tester("(secret alice)", SeparatedRMLTerm(list(), Predicate("secret", Constant("alice", "agent"))))

    def test_problem_goal_rml(self):
        secret = Predicate("secret", Constant("alice", "agent"))
        self.valid_goal_tester("[bel, bob](secret alice)", SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Constant("bob", "agent")))], secret))
        self.valid_goal_tester("![bel, bob](secret alice)", SeparatedRMLTerm([NOT_MODL(), Nesting(GenericMODLType.BEL, Agent(Constant("bob", "agent")))], secret))

    def test_problem_goal_or_rml(self):
        secret = Predicate("secret", Constant("alice", "agent"))
        self.valid_goal_tester("(or (secret alice) [bel, bob](secret alice))", Or(SeparatedRMLTerm(list(), secret), SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Constant("bob", "agent")))], secret)))

    def test_problem_goal_not_rml(self):
        self.valid_goal_tester("(not (secret alice))", Not(SeparatedRMLTerm(list(), Predicate("secret", Constant("alice", "agent")))))

    def test_problem_goal_and_rml(self):
        self.valid_goal_tester("(and (secret alice))", And(SeparatedRMLTerm(list(), Predicate("secret", Constant("alice", "agent")))))

    def test_problem_goal_imply(self):
        secret_a = Predicate("secret", Constant("alice", "agent"))
        secret_b = Predicate("secret", Constant("bob", "agent"))
        self.valid_goal_tester("(imply (secret alice) (secret bob))", Imply(SeparatedRMLTerm(list(), secret_a), SeparatedRMLTerm(list(), secret_b)))

    def test_problem_goal_exists(self):
        var_a = Variable("a", ["agent"])
        self.valid_goal_tester("(exists (?a - agent) (secret ?a))", ExistsCondition(SeparatedRMLTerm(list(), Predicate("secret", var_a)), {var_a}))

    def test_problem_goal_forall(self):
        var_a = Variable("a", ["agent"])
        self.valid_goal_tester("(forall (?a - agent) (secret ?a))", ForallCondition(SeparatedRMLTerm(list(), Predicate("secret", var_a)), {var_a}))

    def test_problem_goal_negate_always_known(self):
        self.error_tester_goal("(!at alice l1)", [VisitError, PDDLValidationError])

    # ANCILLARY EFFECT PARSING
    def test_basic_anceff(self):
        self.valid_anceff_tester("""
    (:anceff some-anceff
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml !{rml}
            :type del
        )
    )""", self.anceff_template)

    def test_anceff_missing_param(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml !{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])
    
    def test_anceff_missing_param_2(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?c]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml !{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])
    

    def test_forall_var(self):
        anceff = deepcopy(self.anceff_template)
        anceff.consequent.poscond = None
        anceff.consequent.negcond = [ListCompVar(SeparatedRMLTerm(list(), RMLTermNegated()), Variable("pos")), Variable("neg")]
        self.valid_anceff_tester("""
    (:anceff some-anceff
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {rml}
            :type add
        )
        :consequent (
            :negcond {!{rml} for {rml} in ?pos} + ?neg
            :rml !{rml}
            :type del
        )
    )""", anceff)

    def test_forall_var_wrong_name(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {rml}
            :type add
        )
        :consequent (
            :negcond {!{rml} for {rml} in ?blah} + ?neg
            :rml !{rml}
            :type del
        )
    )""", [UnexpectedCharacters])

    def test_forall_agents(self):
        anceff = deepcopy(self.anceff_template)
        anceff.consequent.poscond = None
        anceff.consequent.negcond = [ListCompAgents(SeparatedRMLTerm([Nesting(GenericMODLType.BEL, Agent(Variable("ag", ["agent"])))], RMLTerm())), Variable("pos")]
        self.valid_anceff_tester("""
    (:anceff some-anceff
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {rml}
            :type add
        )
        :consequent (
            :negcond {[bel, ?ag]{rml} for ?ag in ?agents} + ?pos
            :rml !{rml}
            :type del
        )
    )""", anceff)

    def test_nesting_trailing(self):
        anceff = deepcopy(self.anceff_template)
        agent_var = Variable("a", ["agent"])
        agent = Agent(agent_var)
        rml = RMLTerm()
        anceff.parameters = [agent_var]
        anceff.antecedent.rml = SeparatedRMLTerm([TrailingNesting(Nesting(GenericMODLType.BEL, agent))], rml)
        anceff.consequent.rml = [SeparatedRMLTerm([TrailingNesting(Nesting(PossibleGenericMODLType.PBEL, agent))], rml)]
        self.valid_anceff_tester("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml <bel, ?a>{nesting}{rml}
            :type del
        )
    )""", anceff)

    def test_nesting_leading(self):
        anceff = deepcopy(self.anceff_template)
        agent_var = Variable("a", ["agent"])
        agent = Agent(agent_var)
        rml = RMLTerm()
        anceff.parameters = [agent_var]
        anceff.antecedent.rml = SeparatedRMLTerm([LeadingNesting(Nesting(GenericMODLType.BEL, agent))], rml)
        anceff.consequent.rml = [SeparatedRMLTerm([LeadingNesting(Nesting(PossibleGenericMODLType.PBEL, agent))], rml)]
        self.valid_anceff_tester("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{rml}
            :type del
        )
    )""", anceff)

    def test_nesting_leading_trailing(self):
        anceff = deepcopy(self.anceff_template)
        agent_var = Variable("a", ["agent"])
        agent = Agent(agent_var)
        rml = RMLTerm()
        anceff.parameters = [agent_var]
        anceff.antecedent.rml = SeparatedRMLTerm([LeadingTrailingNesting(Nesting(GenericMODLType.BEL, agent))], rml)
        anceff.consequent.rml = [SeparatedRMLTerm([LeadingTrailingNesting(Nesting(PossibleGenericMODLType.PBEL, agent))], rml)]
        self.valid_anceff_tester("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", anceff)

    def test_double_nesting_error(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{nesting}{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml <bel, ?a>{nesting}{nesting}{rml}
            :type del
        )
    )""", [UnexpectedCharacters])

    def test_double_nesting_error_2(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}{nesting}[bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}{nesting}<bel, ?a>{rml}
            :type del
        )
    )""", [UnexpectedCharacters])

    def test_double_nesting_error_3(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}{nesting}[bel, ?a]{nesting}{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}{nesting}<bel, ?a>{nesting}{nesting}{rml}
            :type del
        )
    )""", [UnexpectedCharacters])

    def test_nesting_negation_error(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml ![bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml !<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_nesting_negation_error_2(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}![bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}!<bel, ?a>{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_nesting_negation_error_3(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}![bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}!<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_nesting_negation_error_4(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{nesting}!{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{nesting}!{rml}
            :type del
        )
    )""", [UnexpectedCharacters])

    def test_mismatch_nesting_error(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml !<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_2(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_3(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_4(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml <bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_5(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}[bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_6(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{nesting}{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_7(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_8(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml <bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])

    def test_mismatch_nesting_error_9(self):
        self.error_tester_anceff("""
    (:anceff some-anceff
        :parameters (?a - agent)
        :antecedent (
            :poscond ?pos
            :negcond ?neg
            :rml [bel, ?a]{rml}
            :type add
        )
        :consequent (
            :poscond ?pos
            :negcond ?neg
            :rml {nesting}<bel, ?a>{nesting}{rml}
            :type del
        )
    )""", [VisitError, PDDLValidationError])