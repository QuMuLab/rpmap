import sys
import os
from lark import Lark
from lark.visitors import Transformer
from .core.anc_eff import AncEffTransformer
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
from pddl.parser import GRAMMAR_FILE
import pddl
import warnings


def read_pdkbddl_file(fname):
    """Adapted from the pdkb.problems.read_pdkbddl_file function
    and the pdkb.test.utils.read_file function.
    
    Reads a pdkbddl file to a list of lines."""

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
            import_name = lines[index].split(':')[1][:-1]
            file_path = os.path.join(os.path.split(fname)[0], import_name) if "domain" in import_name else os.path.join("ancillary_effect_imports", import_name)
            lines = lines[:index] + read_pdkbddl_file(file_path) + lines[index+1:]

    # Strip out the comments and empty lines
    lines = [x for x in lines if x != '']
    lines = [x for x in lines if x[0] != ';']
    lines = [x.split(';')[0] for x in lines]
    return lines

class AncEffDomainProblemTransformer(Transformer):
    """A transformer for domain + problems
    Taken from the fond-utils library"""
    
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
            if method_name == "types_hierarchy":
                try:
                    method = getattr(transformer, method_name)
                except RuntimeError as e:
                    warnings.warn("The pddl library has not yet made types hierarchy available for use.")
                    continue
            method = getattr(transformer, method_name)
            if not callable(method):
                continue
            if method_name.startswith("_") or method_name == "transform":
                continue
            if hasattr(base_transformer, method_name):
                raise AttributeError("Cannot merge: method '%s' appears more than once" % method_name)

            setattr(base_transformer, method_name, method)

    return base_transformer

def new_problem_transformer_init(self, domain_transformer):
    super(ProblemTransformer, self).__init__()

    self._domain_transformer = domain_transformer
    self._objects_by_name = {} # dict of strings to constants

class AncEffDomProbParser:
    """Domain and/or problem PDDL domain parser class.
    Taken from the fond-utils library"""

    def __init__(self, grammar):
        """Initialize."""
        # monkey patch the ProblemTransformer to include a direct reference to the DomainTransformer used
        pddl.parser.problem.ProblemTransformer.__init__ = new_problem_transformer_init
        domain=DomainTransformer()
        self._transformer = merge_transformers_modified(
            AncEffDomainProblemTransformer(),
            domain=domain,
            anceff=AncEffTransformer(domain),
            problem=ProblemTransformer(domain),
        )
        # need to use earley; lalr will not be able to recognise files with just problems (no left)
        self._parser = Lark(grammar, parser="earley")

    def __call__(self, text):
        """Call the object as a function
        Will return the object representing the parsed text/file which is an object
        of class pddl_parser.app_problem.APPProblem

        The call_parser() function is part of pddl package: will build a Tree from text and then an object pddl_parser.app_problem.APPProblem from the Tree
        """
        return call_parser(text, self._parser, self._transformer)