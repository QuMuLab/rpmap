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

    def test_predicate(self):
        self.insert_predicate("(whisper ?a1 ?a2 - agent)")
        domain = self.get_parsed_domain()
        assert Predicate("whisper", *[Variable("a1", ["agent"]), Variable("a2", ["agent"])]) in domain.predicates
        