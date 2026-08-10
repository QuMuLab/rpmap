import pddl as pddl
import pddl.core
from .domain import atomic_formula_term, terminal_predicate
from .anc_eff import modl, MODL
from ..utils import *
from pddl.formatter import (
    print_constants,
    remove_empty_lines,
    sort_and_print_collection,
)
from pddl.helpers.base import assert_
from pddl.logic.terms import Constant
from pddl.logic.base import Formula, Atomic, Not
from pddl.parser import problem, GRAMMAR_FILE
from textwrap import indent

# ----- TRANSFORMER FUNCTIONS -----

def projection_transformer(self, args):
    """Transformer for the problem depth."""
    args = basic_tokens_transformer(self, args)
    return ("projection", args)

def depth_transformer(self, args):
    """Transformer for the problem depth."""
    args = basic_tokens_transformer(self, args)
    return ("depth", args)

def goal_transformer(self, args):
    """Transformer for the problem goal."""
    args = self.init(args)[1]
    args = args[2] if args else args
    return ("goal", frozenset(args))

def init_type_transformer(self, args):
    """Transformer for the problem init type."""
    args = basic_tokens_transformer(self, args)
    return ("init_type", args) 

def plan_transformer(self, args):
    """Transformer for the problem plan."""
    args = self.init(args)[1]
    args = args[2] if args else args
    return ("plan", frozenset(args)) 

def task_transformer(self, args):
    """Transformer for the problem task."""
    args = basic_tokens_transformer(self, args)
    return ("task", args)

# ----- STRING AND PRINT FUNCTIONS -----
def pprint_pddl_collection(prefix, collection,):
    """Pretty print function to print a PDDL prefix and its collection."""
    return f"{prefix} {NL_AND_TAB}{NL_AND_TAB.join(map(str, collection))}{NL})\n"

def new_problem_str(self):
    """Adapted from the pddl.core.Problem.__str__ method."""
    result = f"(define (problem {self.name})"
    body = f"(:domain {self.domain_name})\n"
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    if self.objects:
        body += print_constants("(:objects", self.objects, ")\n")
    # TODO: handle projection later
    # body += f"(:projection )\n"
    # body += f"(:depth {self.depth})\n"
    # body += f"(:task {self.task})\n"
    # body += f"(:init-type {self.init_type})\n"
    body += pprint_pddl_collection("(:init", self.init)
    body += f"(:goal {self.goal})\n"
    body += f"{'(:metric ' + str(self.metric) + ')'}\n" if self.metric else ""
    # body += pprint_pddl_collection("(:plan", self.plan)
    result = result + "\n" + indent(body, "\t") + "\n)"
    result = remove_empty_lines(result)
    return result

# ----- OTHER CLASS MODIFICATIONS -----

def new_init_problem(self, *args, **kwargs):
    """New init function for the problem that takes depth, task, init type, and plan into account."""
    self.depth = kwargs["depth"]  # store the depth
    self.task = kwargs["task"]  # store the task
    self.init_type = kwargs["init_type"]  # store the init type
    self.plan = kwargs["plan"] # store the plan
    self.projection = kwargs["projection"]  # store the projection
    kwargs.pop("projection")
    kwargs.pop("depth")
    kwargs.pop("task")
    kwargs.pop("init_type")
    kwargs.pop("plan")
    self.orig_init(*args, **kwargs)

def problem__constant(self, args):
    """
    Process the 'constant' rule.

    NOTE: This is taken (verbatim) from pddl.parser.problem.ProblemTransformer.constant.
    The purpose of this function is to rename that transformer function such that it doesn't
    overlap with the domain "constant" transformer function (since all the transformer
    functions are being combined under one Transformer). Note that the domain constant transformer
    also ensures that any constant defined is defined under the domain 'constants.'
    """
    return Constant(args[0])

def is_literal_w_modl(formula: Formula) -> bool:
    """
    Check whether a formula is a literal.

    That is, whether it is one of the following:
    - an atomic formula,
    - a Not formula whose argument is an atomic formula.

    :param formula: the formula.
    :return: True if the formula is a literal; False otherwise.
    """
    return (
        isinstance(formula, Atomic)
        or (isinstance(formula, Not)
            and isinstance(formula.argument, Atomic))
        or (isinstance(formula, MODL)
            and isinstance(formula._get_predicate(), Atomic)) 
    )

# ----- GRAMMAR CONSTRUCTION -----

def inject_problem_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    """Inject the new rule and its rule into the .lark file and assign the rule
    to a function in the transformer."""
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(problem.ProblemTransformer, label, function)

def construct_problem_grammar():
    """Construct the entire problem grammar."""
    replace_in_grammar(
        "LPAR DEFINE problem_def problem_domain [requirements] [objects] init goal [metric_spec] RPAR",
        "LPAR DEFINE problem_def problem_domain [objects] projection depth task init_type init goal [metric_spec] [plan] RPAR"
    )
    # inject the basic problem tokens
    inject_problem_grammar("PROJECTION", "\":projection\"", basic_token_transformer)
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
    inject_problem_grammar("terminal_predicate_constant_problem", "LPAR [EXC] predicate problem__constant* RPAR", terminal_predicate)
    inject_problem_grammar("atomic_formula_name", "[EXC] problem_modl* terminal_predicate_constant_problem", atomic_formula_term)
    inject_problem_grammar("problem_modl", "LSQB modl_term COMMA problem__constant RSQB | LESSER_OP modl_term COMMA problem__constant GREATER_OP", modl)
    # TODO: handle projection later
    inject_problem_grammar("projection", "LPAR PROJECTION RPAR", projection_transformer)
    inject_problem_grammar("depth", "LPAR DEPTH NUMBER RPAR", depth_transformer)
    inject_problem_grammar("task", "LPAR TASK require_task_key RPAR", task_transformer)
    inject_problem_grammar("init_type", "LPAR INIT_TYPE COMPLETE RPAR", init_type_transformer)
    inject_problem_grammar("plan", "LPAR PLAN gd_name* RPAR", plan_transformer)
    inject_problem_grammar("goal", "LPAR GOAL gd_name* RPAR", goal_transformer)
    inject_problem_grammar("gd_name", "atomic_formula_name | LPAR NOT atomic_formula_name RPAR | LPAR AND gd_name* RPAR | LPAR binary_comp metric_f_exp metric_f_exp RPAR", basic_tokens_transformer)
    pddl.core.Problem.orig_init = pddl.core.Problem.__init__
    pddl.core.Problem.__init__ = new_init_problem
    pddl.core.Problem.__str__ = new_problem_str

    # delete the start attribute (a new start rule will be made)
    delattr(problem.ProblemTransformer, "start")
    # delete the other attributes overlapping with the domain,
    # as we are combining the transformers into one Transformer
    delattr(problem.ProblemTransformer, "atomic_formula_term")
    delattr(problem.ProblemTransformer, "typed_list_name")
    delattr(problem.ProblemTransformer, "f_exp")
    delattr(problem.ProblemTransformer, "f_head")
    delattr(problem.ProblemTransformer, "gd")
    delattr(problem.ProblemTransformer, "constant")
    inject_problem_grammar("problem__constant", "NAME", problem__constant)
    delattr(problem.ProblemTransformer, "requirements")
    delattr(pddl.logic.base, "is_literal")
    pddl.logic.base.is_literal = is_literal_w_modl
    pddl.core.is_literal = is_literal_w_modl