# adapted from the PDDL library
from pathlib import Path
from lark import Lark
from pddl.helpers.base import call_parser
from pddl.parser.domain import DomainTransformer

def parse_domain(grammar, d_pddl):
    with open(d_pddl, "r") as f:
        d_pddl = f.read()
    grammar = Path(grammar).read_text()
    parser = Lark(grammar, parser='lalr')
    result = call_parser(d_pddl, parser, DomainTransformer())
    print(result)

if __name__ == "__main__":
    parse_domain('bdi_testing/domain.lark','bdi_testing/domain.pdkbddl')
    # prob