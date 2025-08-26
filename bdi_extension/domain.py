import pddl.core
import pddl.logic
from lark.lexer import Token
from parsing_utils import *
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
from pddl.logic.predicates import Predicate
from pddl.parser import domain, GRAMMAR_FILE
from pddl._validation import Types
from textwrap import indent


def inject_domain_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(domain.DomainTransformer, label, function)

def agents_transformer(self, args):
    self._agents = set(args[1:-1])
    return {"agents": self._agents}

def agent_transformer(self, args):
    if len(args) != 1:
        raise ValueError(f"Invalid agent definition: {args}")
    return args[0].value

def atomic_formula_skeleton(self, args):   
    # adapted from the PDDL DomainTransformer class atomic_formula_skeleton method
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

def action_transformer(self, args):
    # adapted from the PDDL DomainTransformer class action_def method
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

def atomic_formula_term(self, args):
    # adapted from the PDDL DomainTransformer class atomic_formula_term method
    # figure out where the BDI term ends, e.g. (!)[?agent] or (!)<?agent>
    # (if there's no BDI term, we just skip over None)
    after_bdi = None
    for i in range(len(args)):
        if type(args[i]) == Token:
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
    if type(name) == list:
        # indicates that we are dealing with a variable predicate instead of a predicate
        # e.g. (?mu)
        name =  Token("NAME", "".join(p.value for p in name))
        var_pred = True        
    terms = list(map(self._constant_or_variable, args[after_bdi + 3:-1]))
    if var_pred:
        p = VariablePredicate(name, *terms)
    else:
        p = Predicate(name, *terms)
    p.bdi = args[:after_bdi]  # store the BDI term
    p.negated = negated # store the negated term, e.g. (!term ?a ?b)
    return p

def get_predicate_prefix(self):
    p_str = ""
    if self.always_known:
        p_str += "{AK}"
    if self.bdi:
        p_str += recursive_print_bdi(self.bdi)
    return p_str

def new_predicate_str(self):
    # adapted from the PDDL Predicate class __str__ method
    p_str = self.get_predicate_prefix()
    if self.negated:
        p_str += f"(!{self.name}"
    else:
        p_str += f"({self.name}"
    if self.arity == 0:
        return f"{p_str})"
    else:
        return f"{p_str} {' '.join(map(str, self.terms))})"   
    
# for Action class
def new_action_str(self):
    # TODO: add support for derived conditions
    # adapted from the PDDL Action class __str__ method
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

def new_domain_str(self):
    # adapted from the PDDL Domain class __str__ method
    result = f"(define (domain {self.name})"
    body = ""
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    body += f"(:agents {' '.join(sorted(self.agents)) if self.agents else ''})\n"
    del self.types["agent"]  # remove agents from types
    self._types = Types(self.types, self._requirements)
    body += print_types_or_functions_with_parents("(:types", self.types, ")\n")
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

def new_init_domain(self, *args, **kwargs):
    self._agents = kwargs["agents"]
    kwargs["types"]["agent"] = None
    kwargs.pop("agents")
    self.orig_init(*args, **kwargs)

def new_predicate_eq(self, other):
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
    bdi_str = recursive_print_bdi(self.bdi) if self.bdi else ""
    return hash((self.name, self.arity, self.terms, self.always_known, bdi_str, self.negated))

# recursive print for the BDI function
def recursive_print_bdi(tree):
    tree_str = recursive_print(tree)
    return tree_str if "," not in tree_str else f"{', '.join(tree_str.split(','))}"

# to build the domain grammar via Python magic
def construct_domain_grammar():
    pddl.logic.predicates.Predicate.orig_str = pddl.logic.predicates.Predicate.__str__
    pddl.logic.predicates.Predicate.__str__ = new_predicate_str
    pddl.logic.predicates.Predicate.__eq__ = new_predicate_eq
    pddl.logic.predicates.Predicate.__hash__ = new_predicate_hash
    pddl.logic.predicates.Predicate.get_predicate_prefix = get_predicate_prefix
    pddl.logic.predicates.Predicate.always_known = None
    pddl.logic.predicates.Predicate.bdi = None
    pddl.logic.predicates.Predicate.negated = None
    pddl.action.Action.orig_str = pddl.action.Action.__str__
    pddl.action.Action.__str__ = new_action_str
    pddl.action.Action.derive_condition = None

    # inject rules for defining agents
    inject_domain_grammar("agents", "LPAR \":agents\" agent+ RPAR", agents_transformer)
    inject_domain_grammar("agent", "/[a-zA-Z_][a-zA-Z0-9_]*/", agent_transformer)

    # inject_domain_grammar("anceffs_and_domain", "[anceffs] domain", basic_tokens_transformer)

    replace_in_grammar(
        "LPAR DEFINE domain_def [requirements] [types] [constants] [predicates] [functions] structure_def* RPAR",
        "LPAR DEFINE domain_def agents [requirements] [types] [constants] [predicates] [functions] structure_def* RPAR"
    )   

    # inject rules for always known predicates
    inject_domain_grammar("AK", "\"{AK}\"", basic_token_transformer)
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
    replace_in_grammar(
        "action_def:        LPAR ACTION NAME PARAMETERS action_parameters action_body_def RPAR",
        ""
    )

    inject_domain_grammar("action_def", "LPAR ACTION NAME [DERIVE_CONDITION derived_conditions] PARAMETERS action_parameters action_body_def RPAR", action_transformer)

    # inject rules for BDI terms    
    replace_in_grammar(
        "atomic_formula_term:   LPAR predicate term* RPAR",
        ""
    )
    inject_domain_grammar("atomic_formula_term", "[EXC] bdi* LPAR [EXC] predicate term* RPAR", atomic_formula_term)

    # Monkey patching to add agents to the Domain class
    pddl.core.Domain.orig_init = pddl.core.Domain.__init__
    pddl.core.Domain.__init__ = new_init_domain
    pddl.core.Domain.agents = None
    # Similar monkey patching for the string representation of the Domain class
    pddl.core.Domain.orig_str = pddl.core.Domain.__str__
    pddl.core.Domain.__str__ = new_domain_str

    delattr(domain.DomainTransformer, "start")