from pddl.parser import GRAMMAR_FILE
from refactored_rpmap.parsing_and_grounding.utils import replace_in_grammar
from refactored_rpmap.parsing_and_grounding.parser_setup import AncEffDomProbParser
from run import create_updated_grammar_file, parse
from enum import Enum
import os
import unittest


class PDDLSection(Enum):
    PREDICATES = 1
    ACTION = 2
    INIT = 3
    GOAL = 4
    ANC_EFF = 5

class ParsingTesting(unittest.TestCase):
    def setup(self):
        grammar = create_updated_grammar_file()
        self.testing_grammar_file_path = os.path.join(*os.getcwd().split() + ["tests", "temp_testing_grammar.lark"]) 
        # create a copy of the current grammar file
        with open(self.testing_grammar_file_path, "w") as f:
            f.write(grammar)
        
    def change_grammar_starting_place(self, section: PDDLSection):
        # start line
        start_line = "start: [domain] [all_anceffs] [problem]"
        if section == PDDLSection.PREDICATES:
            replace_in_grammar(start_line, "start: constant", self.testing_grammar_file_path)
        with open(self.testing_grammar_file_path, "r") as f:
            self.grammar = f.read()

    def test_predicate(self):
        self.setup()
        self.change_grammar_starting_place(PDDLSection.PREDICATES)
        result = parse(self.grammar, "hello")
        print()

        