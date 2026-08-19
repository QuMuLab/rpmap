from lark.exceptions import VisitError
from lark.exceptions import UnexpectedCharacters
from pddl.exceptions import PDDLValidationError
from pddl.logic.predicates import Predicate
from pddl.logic.terms import Variable
from pddl.parser import GRAMMAR_FILE
from run import parse
from copy import deepcopy
from enum import Enum
import pytest
import os


class PDDLSection(Enum):
    PREDICATES = 1
    ACTION = 2
    INIT = 3
    GOAL = 4
    ANC_EFF = 5

class TestParsing:
    @pytest.fixture(scope="class", autouse=True)
    def setup(self, request):
        with open(GRAMMAR_FILE, "r") as f:
            grammar = f.read()
        testing_grammar_file_path = os.path.join(
            *os.getcwd().split() + ["tests", "temp_testing_grammar.lark"]
        )
        with open(testing_grammar_file_path, "w") as f:
            f.write(grammar)
        request.cls.grammar = grammar
        domain_path = os.path.join(*os.getcwd().split() + ["tests", "domain_template.pdkbddl"])
        with open(domain_path, "r") as f:
            domain = f.read()
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
        yield
        request.cls.domain_data["predicate_insert"] = insert_str
        request.cls.domain_data["action_insert"] = insert_str
        self.update_domain(request.cls.domain_data)

    def update_domain(self, new_domain_data):
        self.domain_str = "".join(new_domain_data.values())
        with open(self.domain_path, "w") as f:
            f.write(self.domain_str)

    def insert_predicate(self, pred_str: str):
        data_copy = deepcopy(self.domain_data)
        data_copy["predicate_insert"] = pred_str
        self.update_domain(data_copy)

    def get_parsed_domain(self):
        return parse(self.grammar, self.domain_str)[0]

    def predicate_test_helper(self, pred_str: str, pred_obj: Predicate):
        self.insert_predicate(pred_str)
        domain = self.get_parsed_domain()
        assert pred_obj in domain.predicates

    def predicate_test_helper_error(self, pred_str: str, errors: list[Exception]):
        with pytest.raises(errors[0]) as outer_e:
            self.insert_predicate(pred_str)
            self.get_parsed_domain()
        for e in errors[1:]:
            assert isinstance(outer_e.value.orig_exc, e)

    def test_predicate_not_always_known(self):
        self.predicate_test_helper("(whisper ?a1 ?a2 - agent ?l - loc)", Predicate("whisper", *[Variable("a1", ["agent"]), Variable("a2", ["agent"]), Variable("l", ["loc"])]))
        self.predicate_test_helper("(whisper2)", Predicate("whisper2"))

    def test_predicate_always_known(self):
        pred = Predicate("whisper", *[Variable("a1", ["agent"]), Variable("a2", ["agent"]), Variable("l", ["loc"])])
        pred.always_known = True
        self.predicate_test_helper("{AK}(whisper ?a1 ?a2 - agent ?l - loc)", pred)

    def test_predicate_unknown_type(self):
        self.predicate_test_helper_error("{AK}(whisper ?a1 ?a2 - agent ?v - volume)", [VisitError, PDDLValidationError])

    def test_predicate_illegal_name(self):
        self.predicate_test_helper_error("{AK}(rml ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])
        self.predicate_test_helper_error("{AK}(r ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])
        self.predicate_test_helper_error("(rml ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])
        self.predicate_test_helper_error("(r ?a1 ?a2 - agent ?l - loc)", [VisitError, PDDLValidationError])

    def test_predicate_illegal_syntax(self):
        self.predicate_test_helper_error("{AK}sjfdklwefk", [UnexpectedCharacters])
        self.predicate_test_helper_error("{AK}()", [UnexpectedCharacters])
        self.predicate_test_helper_error("sjfdklwefk", [UnexpectedCharacters])
        self.predicate_test_helper_error("()", [UnexpectedCharacters])

    def test_predicate_types_missing(self):
        domain = self.get_parsed_domain()
        self.predicate_test_helper_error("(whisper ?a1 ?a2)", [UnexpectedCharacters])