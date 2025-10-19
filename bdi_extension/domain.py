import pddl.core
import pddl.logic
from lark.lexer import Token
from .parsing_utils import *
from pddl.action import Action
from pddl.formatter import (
    print_constants,
    print_function_skeleton,
    print_predicates_with_types,
    print_types_or_functions_with_parents,
    remove_empty_lines,
    sort_and_print_collection,
)
from pddl.helpers.base import _typed_parameters
from pddl.logic.base import And
from pddl.logic.predicates import Predicate
from pddl.parser import domain, GRAMMAR_FILE
from pddl._validation import Types
from textwrap import indent

# ----- TRANSFORMER FUNCTIONS -----

def action_transformer(self, args):
    """Adapted from the pddl.parser.domain.DomainTransformer.action_def method."""
    action_name = args[2]
    variables = args[6]

    # process action body
    _children = args[7].children
    action_body = {
        _children[i][1:]: _children[i + 1] for i in range(0, len(_children), 2)
    }
    a = Action(action_name, variables, **action_body)
    a.derive_condition = args[4]
    return a

def agent_transformer(self, args):
    """Transformer for a single agent."""
    if len(args) != 1:
        raise ValueError(f"Invalid agent definition: {args}")
    return args[0].value

def agents_transformer(self, args):
    """Transformer for agents."""
    # assign the agents
    self._agents = set(args[1:-1])
    return {"agents": self._agents}

def atomic_formula_skeleton(self, args):   
    """Adapted from the pddl.parser.domain.DomainTransformer.atomic_formula_skeleton method."""
    predicate_name = args[2] # get name of the predicate
    ak = False
    # have an "always known"
    ak = True if args[0] else False
    # remove "always known" so variable is are in the correct position
    args = args[1:]
    variables = self._formula_skeleton(args)
    p = Predicate(predicate_name, *variables)
    p.always_known = True if ak else False
    return p

def atomic_formula_term(self, args):
    """Adapted from the pddl.parser.domain.DomainTransformer.atomic_formula_term method"""
    # figure out where the BDI term ends, e.g. (!)[b, ?agent]{index} or (!)<b, ?agent>{index}.
    # (if there's no BDI term, we just skip over None)
    after_bdi = None
    for i in range(len(args)):
        if type(args[i]) is Token:
            if "LPAR" in args[i].type: #accounting for import being part of the type name
                # reached the end of the BDI terms
                after_bdi = i
                break
    negated = False
    if args[after_bdi + 1]:
        if "EXC" in args[after_bdi + 1].type:
            negated = True
    name = args[after_bdi + 2] # add 2 to skip the EXC space
    var_pred = False
    if type(name) is list:
        # indicates that we are dealing with a variable predicate instead of a predicate
        # e.g. (?mu)
        name =  Token("NAME", "".join(p.value for p in name))
        var_pred = True        
    terms = list(map(self._constant_or_variable, args[after_bdi + 3:-1]))
    if var_pred:
        p = VariablePredicate(name, *terms)
    else:
        p = Predicate(name, *terms)
    bdi = args[:after_bdi]  # store the BDI term
    if bdi == [None]:
        bdi = None
    p.bdi = bdi
    p.negated = negated # store the negated term, e.g. (!term ?a ?b)
    return p

# ----- STRING AND PRINT FUNCTIONS -----

def recursive_print_bdi(tree):
    """Recursive print for the BDI function."""
    tree_str = recursive_print(tree)
    # add a space after the comma
    return tree_str if "," not in tree_str else f"{', '.join(tree_str.split(','))}"

def new_action_str(self):
    """New action string adapted from the pddl.action.Action.__str__ method."""
    # TODO: add support for derived conditions
    operator_str = "(:action {0}\n".format(self.name)
    if self.derive_condition:
        operator_str += f"    :derive-condition {recursive_print(self.derive_condition)}\n"
    operator_str += f"    :parameters ({_typed_parameters(self.parameters)})\n"
    if self.precondition is not None:
        operator_str += f"    :precondition ({self.precondition.SYMBOL}{NL_AND_TABS}{NL_AND_TABS.join(map(str, self.precondition.operands))}{NL_AND_TAB})\n"
    if self.effect is not None:
        operator_str += f"    :effect ({self.effect.SYMBOL}{NL_AND_TABS}{NL_AND_TABS.join(map(str, self.effect.operands))}{NL_AND_TAB})\n"
    operator_str += ")"
    return operator_str

def get_predicate_prefix(self):
    """Return the string version of a predicate previx (with AK and BDI terms if necessary)."""
    p_str = ""
    if self.always_known:
        p_str += "{AK}"
    if self.bdi:
        p_str += recursive_print_bdi(self.bdi)
    return p_str

def new_predicate_str(self):
    """New predicate string adapted from the pddl.logic.Predicate.__str__ method."""
    p_str = self.get_predicate_prefix()
    if self.negated:
        p_str += f"(!{self.name}"
    else:
        p_str += f"({self.name}"
    if self.arity == 0:
        return f"{p_str})"
    else:
        return f"{p_str} {' '.join(map(str, self.terms))})"   
    
def get_merged_token_value(token):
    if token.type == "LSQB":
        return ""
    elif token.type == "RSQB":
        return "_"
    elif token.type == "LESSER_OP":
        return "P"
    elif token.type == "GREATER_OP":
        return "_"
    elif token.type == "COMMA":
        return ""
    elif token.type == "BELIEF":
        return "B"
    elif token.type == "DESIRE":
        return "D"
    elif token.type == "INTENTION":
        return "I"
    else:
        return token.value
    
def new_predicate_str_rmls(self):
    """New predicate string adapted from the pddl.logic.Predicate.__str__ method."""
    p_str = ""
    if self.bdi:
        bdi_str = "("      
        for bdi_term in self.bdi[1:]:
            for token in bdi_term:
                if type(token) is list:
                    for t in token:
                        bdi_str += get_merged_token_value(t)
                else:
                    bdi_str += get_merged_token_value(token)
        if self.bdi[0]:
            if self.bdi[0].type == "EXC":
                bdi_str += "not_"
        p_str += bdi_str
        name = self.name
    else:
        name = f"({self.name}"
    if self.arity == 0:
        terms = f")"
    else:
        terms = f"{'_'.join(map(str, self.terms))})" 
    if self.negated:
            p_str = f"(not {p_str}{name}_{terms})"
    else:
        p_str = f"{p_str}{name}_{terms}"
    
    return p_str   


def new_domain_str(self):
    """New domain string adapted from the pddl.core.Domain.__str__ method."""
    # adapted from the PDDL Domain class __str__ method
    result = f"(define (domain {self.name})"
    body = ""
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    body += f"(:agents {' '.join(sorted(self._agents)) if self._agents else ''})\n"
    # del self.types["agent"]  # remove agents from types
    self._types = Types(self.types, self._requirements)
    types_str = print_types_or_functions_with_parents("(:types", self.types, ")\n")
    types_str = types_str.replace(" - object", "")  # remove the default object type
    body += types_str
    body += print_constants("(:constants", self.constants, ")\n")
    if self.predicates:
        predicates_str = NL_AND_TAB.join([f"{p.get_predicate_prefix()}{print_predicates_with_types([p])}" for p in self.predicates])
        body += f"(:predicates{NL_AND_TAB}{predicates_str}\n)\n"
    if self.functions:
        body += print_types_or_functions_with_parents(
            "(:functions", self.functions, ")\n", print_function_skeleton
        )
    body += sort_and_print_collection(
        "",
        self.derived_predicates,
        "",
        to_string=lambda obj: str(obj) + "\n",
    )
    body += sort_and_print_collection(
        "",
        self.actions,
        "",
        to_string=lambda obj: str(obj) + "\n",
    )
    result = result + "\n" + indent(body, "\t") + "\n)"
    result = remove_empty_lines(result)

    return result

# ----- OTHER CLASS MODIFICATIONS -----

def new_init_domain(self, *args, **kwargs):
    """New init function for the pddl.core.Domain that takes into account agents."""
    self._agents = kwargs["agents"]
    # adds an agent type so agent variables are recognized
    kwargs["types"]["agent"] = None
    kwargs.pop("agents")
    self.orig_init(*args, **kwargs)

def new_predicate_eq(self, other):
    """New predicate equality check that takes into account the new always_known, bdi, and negated terms."""
    # adapted from the PDDL Predicate class __eq__ method
    return (
            isinstance(other, Predicate)
            and self.name == other.name
            and self.terms == other.terms
            and self.always_known == other.always_known
            and self.bdi == other.bdi
            and self.negated == other.negated
        )

def new_predicate_hash(self):
    """New predicate hash that takes into account the new always_known, bdi, and negated terms."""
    bdi_str = recursive_print_bdi(self.bdi) if self.bdi else ""
    return hash((self.name, self.arity, self.terms, self.always_known, bdi_str, self.negated))

# ----- GRAMMAR CONSTRUCTION -----

def inject_domain_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    """Inject the new rule and its rule into the .lark file and assign the rule
    to a function in the transformer."""
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(domain.DomainTransformer, label, function)

# to build the domain grammar via Python magic
def construct_domain_grammar(print_rml_style=True):
    """Construct the entire domain grammar."""
    # reassign these predicate functions
    if print_rml_style:
        pddl.logic.predicates.Predicate.__str__ = new_predicate_str_rmls
    else:
        pddl.logic.predicates.Predicate.__str__ = new_predicate_str
    pddl.logic.predicates.Predicate.__eq__ = new_predicate_eq
    pddl.logic.predicates.Predicate.__hash__ = new_predicate_hash
    pddl.logic.predicates.Predicate.get_predicate_prefix = get_predicate_prefix
    pddl.logic.predicates.Predicate.always_known = None
    pddl.logic.predicates.Predicate.bdi = None
    pddl.logic.predicates.Predicate.negated = None
    pddl.action.Action.__str__ = new_action_str
    pddl.action.Action.derive_condition = None
    # inject rules for defining agents
    inject_domain_grammar("agents", "LPAR \":agents\" agent+ RPAR", agents_transformer)
    inject_domain_grammar("agent", "/[a-zA-Z_][a-zA-Z0-9_]*/", agent_transformer)
    # replace the overall structure
    replace_in_grammar(
        "LPAR DEFINE domain_def [requirements] [types] [constants] [predicates] [functions] structure_def* RPAR",
        "LPAR DEFINE domain_def agents [requirements] [types] [constants] [predicates] [functions] structure_def* RPAR"
    )   
    # inject rules for always known predicates
    inject_domain_grammar("AK", "\"{AK}\"", basic_token_transformer)
    # replace the atomic formula skeleton
    replace_in_grammar(
        "atomic_formula_skeleton:   LPAR NAME typed_list_variable RPAR",
        ""
    )
    inject_domain_grammar("atomic_formula_skeleton", "[AK] LPAR NAME typed_list_variable RPAR", atomic_formula_skeleton)
    # inject rules for derived conditions
    inject_domain_grammar("DLR", "\"$\"", basic_token_transformer)
    inject_domain_grammar("derived_term", "var | DLR NAME DLR", basic_tokens_transformer)
    inject_domain_grammar("ALWAYS", "\"always\"", basic_token_transformer)
    inject_domain_grammar("NEVER", "\"never\"", basic_token_transformer)
    inject_domain_grammar("derived_conditions", "ALWAYS | NEVER | LPAR predicate derived_term* RPAR", basic_tokens_transformer)
    inject_domain_grammar("DERIVE_CONDITION", "\":derive-condition\"", basic_tokens_transformer)
    # replace the action definition
    replace_in_grammar(
        "action_def:        LPAR ACTION NAME PARAMETERS action_parameters action_body_def RPAR",
        ""
    )
    inject_domain_grammar("action_def", "LPAR ACTION NAME [DERIVE_CONDITION derived_conditions] PARAMETERS action_parameters action_body_def RPAR", action_transformer)
    # inject the rule for a BDI version of the atomic_formula_term
    replace_in_grammar(
        "atomic_formula_term:   LPAR predicate term* RPAR",
        ""
    )
    inject_domain_grammar("atomic_formula_term", "[EXC] bdi* LPAR [EXC] predicate term* RPAR", atomic_formula_term)
    # replace the init and string functions
    pddl.core.Domain.orig_init = pddl.core.Domain.__init__
    pddl.core.Domain.__init__ = new_init_domain
    pddl.core.Domain.__str__ = new_domain_str
    # delete the start attribute (a new start rule will be made)
    delattr(domain.DomainTransformer, "start")
