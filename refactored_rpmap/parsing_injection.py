import sys
from lark import Lark
from lark.visitors import Transformer


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

class AncEffTransformer(Transformer):
    """A transformer for domain + problems
    Taken from the fond-utils library"""
    
    def anceff_start(self, children):
        return children[0]

class AncEffParser:
    """Domain and/or problem PDDL domain parser class.
    Taken from the fond-utils library"""

    def __init__(self, grammar, import_paths=GRAMMAR_FILE):
        """Initialize."""
        self._transformer = AncEffTransformer()
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