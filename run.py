from refactored_rpmap.parsing_and_grounding.parser_setup import AncEffDomProbParser, read_pdkbddl_file
from refactored_rpmap.parsing_and_grounding.ground import ground
from refactored_rpmap.parsing_and_grounding.core.domain import construct_domain_grammar
from refactored_rpmap.parsing_and_grounding.core.problem import construct_problem_grammar
from refactored_rpmap.parsing_and_grounding.utils import write
from pddl.parser import GRAMMAR_FILE
import os

def create_updated_grammar_file():
    # read the original grammar file
    original_path = os.path.join("refactored_rpmap", "parsing_and_grounding", "grammar.lark")
    with open(original_path, "r") as f:
        original_grammar = f.read()

    # read the ancillary effects grammar file and add to the main grammar file
    lark_path = os.path.join("refactored_rpmap", "parsing_and_grounding", "ancillary_effects.lark")
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
    return grammar

def parse(grammar, pdkbddl_str):
    parser = AncEffDomProbParser(grammar)
    return parser(pdkbddl_str)

def get_parsing_result(pdkbddl_str):
    grammar = create_updated_grammar_file()
    return parse(grammar, pdkbddl_str)

def test_parse(pdkbddl_str):
    result = get_parsing_result(pdkbddl_str)

    # breaking here, as we still have to fix grounding.
    anc_effs, grounded_domain, grounded_problem = (result[1][0], *ground(result[1][0], result[0], result[2]))
    base_path = os.path.join("refactored_rpmap", "test_files")
    grounded_dom_path = os.path.join(base_path, "pdkb-domain.pddl")
    grounded_prob_path = os.path.join(base_path, "pdkb-problem.pddl")
    write(grounded_dom_path, str(grounded_domain))
    write(grounded_prob_path, str(grounded_problem))

if __name__ == "__main__":
    test_parse("\n".join(read_pdkbddl_file(os.path.join("refactored_rpmap", "test_files", "problem_1.pdkbddl"))))