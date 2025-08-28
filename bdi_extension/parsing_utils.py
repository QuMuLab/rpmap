import re
from lark.lexer import Token
from pddl.custom_types import namelike, _check_not_a_keyword, name
from pddl.helpers.base import RegexConstrainedString
from pddl.logic.predicates import Predicate, _check_terms_consistency
from pddl.logic.terms import Term
from pddl.parser import GRAMMAR_FILE

NL = "\n"
NL_AND_TAB = "\n" + "\t"
NL_AND_TABS = "\n" + "\t" * 2
NL_AND_3_TABS = "\n" + "\t" * 3

# ----- PRINT AND FILE WRITE FUNCTIONS -----

def recursive_print(tree, outer_sep=""):
    """General function for the recursive printing of Tokens and lists of Tokens.
    outer_sep: determines how to separate what is being parsed. 
        It's an empty space by default, or a space for "compound" type objects."""
    new_str = []
    if type(tree) == list:
        for child in tree:
            if type(child) == list:
                # other printing type is defined
                if type(child[0]) == str:
                    if child[0] == "COMPOUND": # printing a list comp 
                        new_str.append(recursive_print(child[1:], " "))
                else:
                    new_str.append(recursive_print(child, ""))
            else:
                new_str.append(recursive_print(child, ""))
        return outer_sep.join(new_str)
    else:
        return str(tree) if tree else ""
    
def replace_in_grammar(old, new, grammar_file=GRAMMAR_FILE):
    """Replace old content in the .lark file with new content."""
    with open(grammar_file, "r") as f:
        grammar = f.read()
    if old in grammar:
        grammar = grammar.replace(old, new)
        with open(grammar_file, "w") as f:
            f.write(grammar)

def write_no_duplicate(content, filename):
    """Write content to a file while ensuring there are no duplicates of that content."""
    with open(filename, "r") as f:
        grammar = f.read()
    if content not in grammar:
        with open(filename, "a+") as f:
            f.write(content)

# ----- GENERAL TRANSFORMERS -----
    
def basic_token_transformer(self, args):
    """Basic token transformer in which the arguments are simply returned."""
    if type(args) is not Token:
        raise ValueError(f"Invalid token definition: {args}")
    return args

def basic_tokens_transformer(self, args):
    """Basic tokens transformer in which the arguments are simply returned."""
    if not args or args is None:
        raise ValueError(f"Invalid definition of tokens: {args}")
    return args

# ----- GENERAL CLASSES -----

@staticmethod
class name(RegexConstrainedString):
    """
    This type represents a 'variable name' in a PDDL file.

    It must match the following regex: "[?][A-Za-z][-_A-Za-z0-9]*".
    """

    REGEX = re.compile("[?][A-Za-z][-_A-Za-z0-9]*")

@staticmethod
def parse_name(s: str) -> name:
    """New parse_name function which calls the custom regex 'name' function above."""
    _check_not_a_keyword(s, "name", ignore=set())
    return name(s)

class VariablePredicate(Predicate):
    """Variable Predicate class, which allows for predicates with
    a question mark at the beginning of the name."""
    def __init__(self, predicate_name: namelike, *terms: Term):
        """Initialize the variable predicate."""
        self._name = parse_name(predicate_name)
        self._terms = tuple(terms)
        _check_terms_consistency(self._terms)
