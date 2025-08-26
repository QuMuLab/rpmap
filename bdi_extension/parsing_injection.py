# adapted from the PDDL library
from lark import Lark
import pddl
import pddl.core
import pddl.logic
from pddl.logic.terms import Constant
from pddl.parser import domain, problem, GRAMMAR_FILE
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
import anc_eff as anc_eff
from pddl.logic.predicates import Predicate
from pddl.formatter import (
    print_constants,
    print_function_skeleton,
    print_predicates_with_types,
    print_types_or_functions_with_parents,
    remove_empty_lines,
    sort_and_print_collection,
)
from pddl.action import Action
from pddl._validation import Types
from pddl.helpers.base import _typed_parameters, assert_
from lark.lexer import Token
from lark.visitors import Transformer
from textwrap import indent
import os
import sys
from parsing_utils import *


# pretty print PDDL collection
def pprint_pddl_collection(prefix, collection,):
    return f"{prefix} {NL_AND_TAB}{NL_AND_TAB.join(map(str, collection))}{NL})\n"
    
# recursive print for the BDI function
def recursive_print_bdi(tree):
    tree_str = recursive_print(tree)
    return tree_str if "," not in tree_str else f"{', '.join(tree_str.split(','))}"

def write_no_duplicate(content, filename):
    with open(filename, "r") as f:
        grammar = f.read()
    if content not in grammar:
        with open(filename, "a+") as f:
            f.write(content)

def inject_domain_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(domain.DomainTransformer, label, function)

def replace_in_grammar(old, new, grammar_file=GRAMMAR_FILE):
    with open(grammar_file, "r") as f:
        grammar = f.read()
    if old in grammar:
        grammar = grammar.replace(old, new)
        with open(grammar_file, "w") as f:
            f.write(grammar)

# transformers for the new grammar rules
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

# for Predicate class
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

# for Domain class
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

# FOR THE PROBLEM FILE
def inject_problem_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(problem.ProblemTransformer, label, function)

def atomic_formula_name(self, args):
    # adapted from the PDDL ProblemTransformer class atomic_formula_name method
    # figure out where the BDI term ends, e.g. (!)[?agent] or (!)<?agent>
    # (if there's no BDI term, we just skip over None)
    for i in range(len(args)):
        if type(args[i]) == Token:
            if "LPAR" in args[i].type:
                # reached the end of the BDI terms
                after_bdi = i
                break
    negated = False
    if args[after_bdi + 1]:
        if "EXC" in args[after_bdi + 1].type:
            negated = True
    predicate_name = args[after_bdi + 2] # add 2 to skip the EXC space
    terms = []
    for _term_name in args[after_bdi + 3:-1]:
        if self._objects_by_name.get(str(_term_name)) is None:
            terms.append(Constant(str(_term_name)))
        else:
            terms.append(self._objects_by_name.get(str(_term_name)))
    p = Predicate(predicate_name, *terms)
    p.bdi = args[:after_bdi]  # store the BDI term
    p.negated = negated # store the negated term, e.g. (!term ?a ?b)
    return p

def depth_transformer(self, args):
    args = basic_tokens_transformer(self, args)
    return ("depth", args)

def task_transformer(self, args):
    args = basic_tokens_transformer(self, args)
    return ("task", args)

def init_type_transformer(self, args):
    args = basic_tokens_transformer(self, args)
    return ("init_type", args) 

def plan_transformer(self, args):
    args = self.init(args)
    return ("plan", args[1]) 

def goal_transformer(self, args):
    args = self.init(args)
    return ("goal", args[1]) 

def new_init_problem(self, *args, **kwargs):
    self.depth = int(kwargs["depth"][2].value)  # store the depth
    self.task = kwargs["task"][2].value  # store the task
    self.init_type = kwargs["init_type"][2].value  # store the init type
    self.plan = kwargs["plan"] # store the plan
    kwargs.pop("depth")
    kwargs.pop("task")
    kwargs.pop("init_type")
    kwargs.pop("plan")
    self.orig_init(*args, **kwargs)

def new_problem_str(self):
    # adapted from the PDDL Problem class __str__ method
    result = f"(define (problem {self.name})"
    body = f"(:domain {self.domain_name})\n"
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    if self.objects:
        body += print_constants("(:objects", self.objects, ")\n")
    body += f"(:depth {self.depth})\n"
    body += f"(:task {self.task})\n"
    body += f"(:init-type {self.init_type})\n"
    
    body += pprint_pddl_collection("(:init", self.init)
    body += f"(:goal {recursive_print(self.goal, ' ')})" + "\n"
    body += f"{'(:metric ' + str(self.metric) + ')'}\n" if self.metric else ""
    body += pprint_pddl_collection("(:plan", self.plan)
    result = result + "\n" + indent(body, "\t") + "\n)"
    result = remove_empty_lines(result)
    return result

# FOR THE PREDICATE CLASS
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

def problem__constant(self, args):
    """Process the 'constant' rule."""
    assert_(len(args) == 1, "Unexpected parsing error.")
    return Constant(args[0])

def construct_problem_grammar():
    # replace overall structure
    replace_in_grammar(
        "LPAR DEFINE problem_def problem_domain [requirements] [objects] init goal [metric_spec] RPAR",
        "LPAR DEFINE problem_def problem_domain [objects] depth task init_type init goal [metric_spec] [plan] RPAR"
    )    
    inject_problem_grammar("DEPTH", "\":depth\"", basic_token_transformer)
    inject_problem_grammar("TASK", "\":task\"", basic_token_transformer)
    inject_problem_grammar("INIT_TYPE", "\":init-type\"", basic_token_transformer)
    inject_problem_grammar("VALID", "\"valid_generation\"", basic_token_transformer)
    inject_problem_grammar("ASSESS", "\"valid_assessment\"", basic_token_transformer)
    inject_problem_grammar("PLAN", "\":plan\"", basic_token_transformer)
    inject_problem_grammar("COMPLETE", "\"complete\"", basic_token_transformer)
    inject_problem_grammar("?require_task_key", "VALID | ASSESS", basic_tokens_transformer)

    replace_in_grammar(
        "atomic_formula_name:   LPAR predicate NAME* RPAR",
        ""
    )
    replace_in_grammar(
        "goal:  LPAR GOAL gd RPAR",
        ""
    )
    inject_problem_grammar("atomic_formula_name", "[EXC] problem_bdi* LPAR [EXC] predicate NAME* RPAR", atomic_formula_name)
    inject_problem_grammar("problem_bdi", "LSQB bdi_term COMMA NAME RSQB | LESSER_OP bdi_term COMMA NAME GREATER_OP", basic_tokens_transformer)

    inject_problem_grammar("depth", "LPAR DEPTH NUMBER RPAR", depth_transformer)
    inject_problem_grammar("task", "LPAR TASK require_task_key RPAR", task_transformer)
    inject_problem_grammar("init_type", "LPAR INIT_TYPE COMPLETE RPAR", init_type_transformer)
    inject_problem_grammar("plan", "LPAR PLAN gd_name* RPAR", plan_transformer)
    inject_problem_grammar("goal", "LPAR GOAL gd_name* RPAR", goal_transformer)
    inject_problem_grammar("gd_name", "atomic_formula_name | LPAR NOT atomic_formula_name RPAR | LPAR AND gd_name* RPAR | LPAR binary_comp metric_f_exp metric_f_exp RPAR", basic_tokens_transformer)

    pddl.core.Problem.orig_init = pddl.core.Problem.__init__
    pddl.core.Problem.__init__ = new_init_problem
    pddl.core.Problem.__str__ = new_problem_str
    pddl.core.Problem.agents = None
    pddl.core.Problem.depth = None
    pddl.core.Problem.task = None
    pddl.core.Problem.init_type = None
    pddl.core.Problem.plan = None

    delattr(problem.ProblemTransformer, "start")
    delattr(problem.ProblemTransformer, "atomic_formula_term")
    delattr(problem.ProblemTransformer, "typed_list_name")
    delattr(problem.ProblemTransformer, "f_exp")
    delattr(problem.ProblemTransformer, "f_head")
    delattr(problem.ProblemTransformer, "gd")

    # have to remove duplicates with the domain file
    delattr(problem.ProblemTransformer, "constant")
    inject_problem_grammar("problem__constant", "NAME", problem__constant)
    # don't need to define requirements twice
    delattr(problem.ProblemTransformer, "requirements")

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
    for prefix, transformer in transformers_to_merge.items():
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