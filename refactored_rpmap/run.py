from parsing_injection import AncEffDomProbParser, read_pdkbddl_file
from core.domain import construct_domain_grammar
from core.problem import construct_problem_grammar
from parsing_utils import write_no_duplicate
from pddl.parser import GRAMMAR_FILE
import os

def test_parse():
    # grab the PDDL
    pddl_str = "\n".join(read_pdkbddl_file("refactored_rpmap/test_files/problem_1.pdkbddl"))

    # read the original grammar file
    original_path = os.path.join("refactored_rpmap", "grammar.lark")
    with open(original_path, "r") as f:
        original_grammar = f.read()

    # read the ancillary effects grammar file and add to the main grammar file
    lark_path = os.path.join("refactored_rpmap", "ancillary_effects.lark")
    with open(lark_path, "r") as f:
        anceff_grammar = f.read()

    with open(GRAMMAR_FILE, "w") as f:
        f.write(original_grammar + "\n" + anceff_grammar)

    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_problem_grammar() 
    # read the lark file
    with open(GRAMMAR_FILE, "r") as f:
        grammar = f.read()
    # set up the parser with the lark and parse the PDDL
    parser = AncEffDomProbParser(grammar)
    result = parser(pddl_str)
    print()

if __name__ == "__main__":
    test_parse()