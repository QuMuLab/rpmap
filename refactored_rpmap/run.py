from parsing_injection import AncEffDomProbParser, read_pdkbddl_file
from core.domain import construct_domain_grammar
from core.problem import construct_problem_grammar

def test_parse():
    # grab the PDDL
    pddl_str = "\n".join(read_pdkbddl_file("refactored_rpmap/test_files/problem_1.pdkbddl"))
    # read the lark file
    with open("refactored_rpmap/ancillary_effects.lark", "r") as f:
        grammar = f.read()
    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_domain_grammar() 
    # set up the parser with the lark and parse the PDDL
    parser = AncEffDomProbParser(grammar)
    result = parser(pddl_str)
    print()

if __name__ == "__main__":
    test_parse()