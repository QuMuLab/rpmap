import pddl.core
import pddl.logic
from ..utils import *
from copy import deepcopy
from pddl.action import Action
from pddl.formatter import (
    print_constants,
    print_function_skeleton,
    print_types_or_functions_with_parents,
    remove_empty_lines,
    sort_and_print_collection,
)
from pddl.helpers.base import _typed_parameters
from pddl.logic.predicates import Predicate
from pddl.logic.terms import Variable, Constant
from pddl.parser import domain, GRAMMAR_FILE
from pddl._validation import Types, TypeChecker
from textwrap import indent
from .anc_eff import MODL, NOT_MODL

# ----- TRANSFORMER FUNCTIONS -----

def constant(self, args):
    return Constant(args[0].value)

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
    self._predicates_by_name[a.name] = Predicate(a.name, *a.parameters)
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
    # have an "always known"
    ak = True if args[0] else False
    # remove "always known" so variables are in the correct position
    args = args[1:]
    variables = self._formula_skeleton(args)
    p = Predicate(predicate_name, *variables)
    p.always_known = True if ak else False
    return p

def terminal_predicate(self, args):
    domain_preds = self._predicates_by_name if hasattr(self, "_predicates_by_name") else self._domain_transformer._predicates_by_name
    pred_name = args[2].value
    if pred_name not in domain_preds:
        raise ValueError(f"Predicate {pred_name} not defined in the domain.")
    terms = args[3:-1]
    for i in range(len(terms)):
        terms[i]._type_tags = domain_preds[pred_name].terms[i].type_tags
    pred = Predicate(pred_name, *terms)
    pred.always_known = domain_preds[pred_name].always_known
    if args[1]:
        pred.negated = True
    if pred.negated and not pred.always_known:
        raise ValueError("Cannot apply a `!` to a predicate that is always known.")
    return pred

def atomic_formula_term(self, args):
    negate_modalities = True if args[0] else False
    modls_no_neg = args[1:]
    for i in range(len(modls_no_neg) - 1, - 1, - 1):
        if isinstance(modls_no_neg[i], Predicate):
            continue
        modls_no_neg[i] = modls_no_neg[i](modls_no_neg[i + 1])
    modl = modls_no_neg[0]
    return NOT_MODL()(modl) if negate_modalities else modl

def dollar_term_transformer(self, args):
    return Variable(f"{args[1].value}")

def derived_conditions_transformer(self, args):
    if len(args) == 1: # result is ALWAYS or NEVER
        return args[0].value
    else: # result is a complex derived condition
        return Predicate(f"{args[1].value}", *[a[0] for a in args[2:-1]])

# ----- STRING AND PRINT FUNCTIONS -----

def new_action_str(self):
    """New action string adapted from the pddl.action.Action.__str__ method."""
    operator_str = "(:action {0}\n".format(self.name)
    if not self.grounded_print:
        if self.derive_condition:
            operator_str += f"    :derive-condition {recursive_print(self.derive_condition)}\n"
    operator_str += f"    :parameters ({_typed_parameters(self.parameters)})\n"
    if self.precondition is not None:
        operator_str += f"    :precondition ({self.precondition.SYMBOL}{NL_AND_TABS}{NL_AND_TABS.join(map(str, self.precondition.operands))}{NL_AND_TAB})\n"
    if self.effect is not None:
        operator_str += f"    :effect ({self.effect.SYMBOL}{NL_AND_TABS}"
        for o in self.effect.operands:
            operator_str += f"{NL_AND_TABS}{o}"
            if hasattr(o, "comment"):
                operator_str += f"; {o.comment}"
        operator_str += f"{NL_AND_TAB})" + "\n"
    operator_str += ")"
    return operator_str

def new_predicate_str_rmls(self):
    """New predicate string adapted from the pddl.logic.Predicate.__str__ method."""
    p_str = f"{self.name}"
    if self.arity == 0:
        p_str += f")"
    else:
        terms = f"{'_'.join(map(str, self.terms))})" 
        p_str = f"{p_str}_{terms}"
    if self.negated:
        p_str = f"(not ({p_str})" if self.always_known else f"(not_{p_str}"
    else:
        p_str = f"({p_str}"
    return p_str   

def new_domain_str(self):
    """New domain string adapted from the pddl.core.Domain.__str__ method."""
    # adapted from the PDDL Domain class __str__ method
    result = f"(define (domain {self.name})"
    body = ""
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    if not self.grounded_print:
        body += f"(:agents {' '.join(sorted(self._agents)) if self._agents else ''})\n"
    self._types = Types(self.types, self._requirements)
    types_str = print_types_or_functions_with_parents("(:types", self.types, ")\n")
    types_str = types_str.replace(" - object", "")  # remove the default object type
    body += types_str
    body += print_constants("(:constants", self.constants, ")\n")
    if self.predicates:
        predicates_str = NL_AND_TAB.join([str(p) for p in self.predicates])
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
    kwargs["types"]["agent"] = None
    kwargs.pop("agents")
    self.orig_init(*args, **kwargs)

@TypeChecker.check_type.register
def _(self, modl: MODL) -> None:
    """Check types annotations of a MODL."""
    self.check_type(modl._get_predicate())

def new_predicate_eq(self, other):
    """New predicate equality check that takes into account the new always_known, modl, and negated terms."""
    # adapted from the PDDL Predicate class __eq__ method
    return (
            isinstance(other, Predicate)
            and self.name == other.name
            and self.arity == other.arity
            and self.terms == other.terms
            and self.always_known == other.always_known
            and self.negated == other.negated
        )

def new_predicate_hash(self):
    """New predicate hash that takes into account the new always_known, modl, and negated terms."""
    return hash((self.name, self.arity, self.terms, self.always_known, self.negated))

def negate_predicate(self):
    new_base = deepcopy(self)
    new_base.negated = not self.negated
    return new_base

# ----- GRAMMAR CONSTRUCTION -----

def inject_domain_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    """Inject the new rule and its rule into the .lark file and assign the rule
    to a function in the transformer."""
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(domain.DomainTransformer, label, function)

def modify_predicate_class():
    pddl.logic.predicates.Predicate.__str__ = new_predicate_str_rmls
    pddl.logic.predicates.Predicate.__repr__ = new_predicate_str_rmls
    pddl.logic.predicates.Predicate.__eq__ = new_predicate_eq
    pddl.logic.predicates.Predicate.__hash__ = new_predicate_hash
    pddl.logic.predicates.Predicate.always_known = False
    pddl.logic.predicates.Predicate.negated = False
    pddl.logic.predicates.Predicate._negate = negate_predicate
    pddl.logic.predicates.Predicate._get_predicate = lambda self: deepcopy(self)

# to build the domain grammar via Python magic
def construct_domain_grammar():
    """Construct the entire domain grammar."""
    modify_predicate_class()
    pddl.action.Action.__str__ = new_action_str
    pddl.action.Action.derive_condition = None
    inject_domain_grammar("agents", "LPAR \":agents\" agent+ RPAR", agents_transformer)
    inject_domain_grammar("agent", "/[a-zA-Z_][a-zA-Z0-9_]*/", agent_transformer)
    replace_in_grammar(
        "LPAR DEFINE domain_def [requirements] [types] [constants] [predicates] [functions] structure_def* RPAR",
        "LPAR DEFINE domain_def agents [requirements] [types] [constants] [predicates] [functions] structure_def* RPAR"
    )   
    inject_domain_grammar("AK", "\"{AK}\"", basic_token_transformer)
    replace_in_grammar(
        "atomic_formula_skeleton:   LPAR NAME typed_list_variable RPAR",
        ""
    )
    inject_domain_grammar("atomic_formula_skeleton", "[AK] LPAR NAME typed_list_variable RPAR", atomic_formula_skeleton)
    inject_domain_grammar("dollar_term", "DLR NAME DLR", dollar_term_transformer)
    inject_domain_grammar("DLR", "\"$\"", basic_token_transformer)
    inject_domain_grammar("derived_term", "var | dollar_term", basic_tokens_transformer)
    inject_domain_grammar("ALWAYS", "\"always\"", basic_token_transformer)
    inject_domain_grammar("NEVER", "\"never\"", basic_token_transformer)
    inject_domain_grammar("derived_conditions", "ALWAYS | NEVER | LPAR predicate derived_term* RPAR", derived_conditions_transformer)
    inject_domain_grammar("DERIVE_CONDITION", "\":derive-condition\"", basic_tokens_transformer)
    replace_in_grammar(
        "action_def:        LPAR ACTION NAME PARAMETERS action_parameters action_body_def RPAR",
        ""
    )
    inject_domain_grammar("action_def", "LPAR ACTION NAME [DERIVE_CONDITION derived_conditions] PARAMETERS action_parameters action_body_def RPAR", action_transformer)
    replace_in_grammar(
        "atomic_formula_term:   LPAR predicate term* RPAR",
        ""
    )
    inject_domain_grammar("terminal_predicate", "LPAR [EXC] predicate const_or_var_term* RPAR", terminal_predicate)
    inject_domain_grammar("atomic_formula_term", "[EXC] modl* terminal_predicate", atomic_formula_term)
    pddl.core.Domain.orig_init = pddl.core.Domain.__init__
    pddl.core.Domain.__init__ = new_init_domain
    pddl.core.Domain.__str__ = new_domain_str
    pddl.core.Domain.grounded_print = False
    pddl.core.Action.grounded_print = False
    # delete the start attribute (a new start rule will be made)
    delattr(domain.DomainTransformer, "start")
    delattr(domain.DomainTransformer, "constant")
    inject_domain_grammar("const_or_var_term", "constant | var", return_option)
    inject_domain_grammar("constant", "NAME", constant)

