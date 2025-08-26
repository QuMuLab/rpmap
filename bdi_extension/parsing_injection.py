import anc_eff as anc_eff
import os
import pddl
import sys
from domain import construct_domain_grammar
from lark import Lark
from lark.visitors import Transformer
from parsing_utils import *
from pddl.parser import GRAMMAR_FILE
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
from problem import construct_problem_grammar


def write(file_path, content):
    with open(file_path, "w") as file:
        file.write(content)

def read_pdkbddl_file(fname):
    """Adapted from the pdkb.problems.read_pdkbddl_file function
    and the pdkb.test.utils.read_file function."""

    lines = []
    with open(fname, 'r') as f:
        lines = [line.strip() for line in f.readlines()]

    found = True
    count = 0
    while found:
        count += 1
        if count > 100:
            assert False, "Error: Already attempted at least 100 imports. Did you recursively import something?"

        found = False
        include_indices = []

        for i in range(len(lines)):
            if lines[i].find('{include') == 0:
                include_indices.append(i)
                found = True

        for index in reversed(include_indices):
            new_file = os.path.join(os.path.split(fname)[0], lines[index].split(':')[1][:-1])
            lines = lines[:index] + read_pdkbddl_file(new_file) + lines[index+1:]

    # Strip out the comments and empty lines
    lines = [x for x in lines if x != '']
    lines = [x for x in lines if x[0] != ';']
    lines = [x.split(';')[0] for x in lines]
    return lines

class AncEffDomainProblemTransformer(Transformer):
    """A transformer for domain + problems
    Taken from the fond-utils library"""

    # def start(self, children):
    #     return children
    
    def anceff_start(self, children):
        return children[0]

    def domain_start(self, children):
        return children[0]

    def problem_start(self, children):
        return children[0]

def call_parser(text: str, parser: Lark, transformer: Transformer):
    """
    Parse a text with a Lark parser and transformer.

    To produce a better traceback in case of an error, the function will temporarily overwrite the sys.tracebacklimit
    value of the current interpreter.

    :param text: the text to parse
    :param parser: the Lark parser object
    :param transformer: the Lark transformer object
    :return: the object returned by the parser
    """
    old_tracebacklimit = getattr(sys, "tracebacklimit", None)
    try:
        sys.tracebacklimit = 0  # noqa
        tree = parser.parse(text)
        sys.tracebacklimit = None  # type: ignore
        result = transformer.transform(tree)
    finally:
        if old_tracebacklimit is not None:
            sys.tracebacklimit = old_tracebacklimit
    return result

def merge_transformers_modified(base_transformer=None, **transformers_to_merge):
    """Adapted from the LARK merge_transformers function.
    We don't want to change the function names in this merging as they
    all use the same LARK file."""
    if base_transformer is None:
        base_transformer = Transformer()
    for _, transformer in transformers_to_merge.items():
        for method_name in dir(transformer):
            method = getattr(transformer, method_name)
            if not callable(method):
                continue
            if method_name.startswith("_") or method_name == "transform":
                continue
            if hasattr(base_transformer, method_name):
                raise AttributeError("Cannot merge: method '%s' appears more than once" % method_name)

            setattr(base_transformer, method_name, method)

    return base_transformer

class AncEffDomProbParser:
    """Domain and/or problem PDDL domain parser class.
    Taken from the fond-utils library"""

    def __init__(self, grammar, import_paths=GRAMMAR_FILE):
        """Initialize."""
        self._transformer = merge_transformers_modified(
            AncEffDomainProblemTransformer(),
            anceff=anc_eff.AncEffTransformer(),
            domain=DomainTransformer(),
            problem=ProblemTransformer(),
        )
        # need to use earley; lalr will not be able to recognise files with just problems (no left)
        self._parser = Lark(
            grammar, parser="earley", import_paths=[import_paths]
        )

    def __call__(self, text):
        """Call the object as a function
        Will return the object representing the parsed text/file which is an object
        of class pddl_parser.app_problem.APPProblem

        The call_parser() function is part of pddl package: will build a Tree from text and then an object pddl_parser.app_problem.APPProblem from the Tree
        """
        return call_parser(text, self._parser, self._transformer)

if __name__ == "__main__":
    # read the ancillary effects grammar file and add to the main grammar file
    with open("bdi_extension/ancillary_effects.lark", "r") as f:
        anceff_grammar = f.read()
    write_no_duplicate("\n" + anceff_grammar, GRAMMAR_FILE)
    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_problem_grammar()

    pddl = "\n".join(read_pdkbddl_file("bdi_extension/bdi_pdkbddl_files/bdi_mvex_problem.pdkbddl"))
    with open(GRAMMAR_FILE, "r") as f:
        grammar = f.read()

    parser = AncEffDomProbParser(grammar)
    result = parser(pddl)
    with open("bdi_extension/bdi_pdkbddl_files/parsed.pdkbddl", "w") as f:
        for r in result:
            f.write(f"{r}\n")