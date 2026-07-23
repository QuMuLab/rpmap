from parsing_injection import *

def test_parse():
    # grab the PDDL
    pddl_str = "\n".join(read_pdkbddl_file("refactored_rpmap/scrap.pdkbddl"))
    # read the lark file
    with open("refactored_rpmap/ancillary_effects.lark", "r") as f:
        grammar = f.read()
    # set up the parser with the lark and parse the PDDL
    parser = AncEffParser(grammar)
    result = parser(pddl_str)

    print(result)

if __name__ == "__main__":
    test_parse()