# adapted from the PDDL library
from pathlib import Path
from lark import Lark, logger
from pddl.helpers.base import call_parser
from pddl.parser.domain import DomainTransformer
import sys
import logging

# logger.setLevel(logging.DEBUG)

def error_handling(e):
    # interactive = parser.parse_interactive(d_pddl)

    # for token in interactive.iter_parse():
    #     # input("Press Enter to continue...")
    #     print(token)
    #     print(interactive.accepts())
    try:
        print(e.token)
        print(e.interactive.accepts())
    except Exception as e:
        print(e)

def parse_domain(grammar, d_pddl):
    with open(d_pddl, "r") as f:
        d_pddl = f.read()
    grammar = Path(grammar).read_text()
    parser = Lark(grammar, parser='lalr')# debug=True)#, strict=True)

    # adapted from the PDDL library for debugging purposes
    result = parser.parse(d_pddl, on_error=error_handling)
    print(result)

    # this is the part that doesn't quite work yet
    # dt = DomainTransformer()
    # result = dt.transform(result)
    # print(result)



if __name__ == "__main__":
    parse_domain('bdi_testing/domain.lark','bdi_testing/grapevine.pdkbddl')
    # prob