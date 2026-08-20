from lark.exceptions import VisitError
from lark.exceptions import UnexpectedCharacters
from pddl.exceptions import PDDLValidationError
from pddl.logic.predicates import Predicate
from pddl.logic.base import And, Or
from pddl.logic.effects import When, Forall
from pddl.logic.terms import Variable
from pddl.action import Action
from pddl.parser import GRAMMAR_FILE
from refactored_rpmap.parsing_and_grounding.core.anc_eff import RML, GenericMODLType, Agent
from run import parse
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
            derive_condition=at_pred_1,
            parameters=[a_var, as_var, l_var],
            precondition=And(
                at_pred_2, 
                RML(GenericMODLType.BEL, Agent(a_var), secret)
            ),
            effect=And(
                Forall(
                    When(
                        And(at_pred_3),
                        And(RML(GenericMODLType.BEL, Agent(a2_var), secret))
                    ),
                    frozenset([a2_var])
                )
            )
        )

    @pytest.fixture(scope="class", autouse=True)
    def setup(self, request):
        # retrieve the current grammar file
        with open(GRAMMAR_FILE, "r") as f:
            request.cls.grammar = f.read()
        # get the domain template file
        domain_path = os.path.join(*os.getcwd().split() + ["tests", "domain_template.pdkbddl"])
        with open(domain_path, "r") as f:
            domain = f.read()
        # create a dictionary that indicates the appropriate places to insert into the domain
        # note that two `{insert here}` are specified at the locations for predicate and action insertion in the `domain_template.pdkbddl` file
        insert_str = "{insert here}"
        domain = domain.split(insert_str)
        request.cls.domain_path = domain_path
        request.cls.domain_data = {
            "header": domain[0],
            "predicate_insert": "",
            "header_end": domain[1],
            "action_insert": "",
            "action_end": domain[2],
        }
        # set template action
        request.cls.action_template = TestParsing.get_template_action()

        yield
        # upon test completion, reset the domain template file
        request.cls.domain_data["predicate_insert"] = insert_str
        request.cls.domain_data["action_insert"] = insert_str
        self.update_domain(request.cls.domain_data)

    # ----- TEMPLATE FILE UPDATE FUNCTIONS -----

    def update_domain(self, new_domain_data):
        self.domain_str = "".join(new_domain_data.values())
        with open(self.domain_path, "w") as f:
            f.write(self.domain_str)

    def insert_data(self, data_place: str, data: str):
        data_copy = deepcopy(self.domain_data)
        data_copy[data_place] = data
        self.update_domain(data_copy)

    def insert_predicate(self, pred_str: str):
        self.insert_data("predicate_insert", pred_str)

    def insert_action(self, action_str: str):
        self.insert_data("action_insert", action_str)

    # ----- TESTING HELPER FUNCTIONS -----

    def get_parsed_domain(self):
        return parse(self.grammar, self.domain_str)[0]

    def valid_predicate_tester(self, pred_str: str, pred_obj: Predicate):
        self.insert_predicate(pred_str)
        domain = self.get_parsed_domain()
        assert pred_obj in domain.predicates

    def valid_action_tester(self, act_str: str, action_obj: Action):
        self.insert_action(act_str)
        domain = self.get_parsed_domain()
        assert action_obj in domain.actions

    def error_tester(self, insert_type: PDDLSection, new_data: str, errors: list[Exception]):
        with pytest.raises(errors[0]) as outer_e:
            if insert_type == PDDLSection.PREDICATE:
                self.insert_predicate(new_data)
            elif insert_type == PDDLSection.ACTION:
                self.insert_action(new_data)
            self.get_parsed_domain()
        for e in errors[1:]:
            assert isinstance(outer_e.value.orig_exc, e)

    def error_tester_predicates(self, pred_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.PREDICATE, pred_str, errors)

    def error_tester_actions(self, action_str: str, errors: list[Exception]):
        self.error_tester(PDDLSection.ACTION, action_str, errors)

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