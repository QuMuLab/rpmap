import pddl as pddl
import pddl.core
from .domain import terminal_predicate, get_constants
from .anc_eff import modl, atomic_formula_term, RML
from ..utils import *
from pddl.formatter import (
    print_constants,
    remove_empty_lines,
    sort_and_print_collection,
)
from pddl.logic.base import Formula, Atomic, Not, And
from pddl.logic.effects import Forall
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
    return ("goal", frozenset(args[2:-1]))

def init_type_transformer(self, args):
    """Transformer for the problem init type."""
    args = basic_tokens_transformer(self, args)
    return ("init_type", args) 

def plan_transformer(self, args):
#     """Transformer for the problem plan."""
    return ("plan", frozenset(args[2:-1])) 

def task_transformer(self, args):
    """Transformer for the problem task."""
    args = basic_tokens_transformer(self, args)
    return ("task", args)

def problem_forall(self, args):
    """Transformer for foralls, adapted from the pddl.parser.domain.c_effect method."""
    variables = [Variable(var_name, tags) for var_name, tags in args[3]]
    return Forall(effect=args[-2], variables=variables)

# def problem__gd_and(self, args):
#     return self._domain_transformer.gd_and(args)

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
    # body += f"(:projection )\n"
    # body += f"(:depth {self.depth})\n"
    # body += f"(:task {self.task})\n"
    # body += f"(:init-type {self.init_type})\n"
    body += pprint_pddl_collection("(:init", self.init)
    body += pprint_pddl_collection("(:goal", self.goal)
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

def is_literal_modified(formula: Formula) -> bool:
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
        or (isinstance(formula, And)
            and False not in [is_literal_modified(o) for o in formula._operands])
        or (isinstance(formula, Not)
            and isinstance(formula.argument, Atomic))
        or (isinstance(formula, RML)
            and isinstance(formula._get_predicate(), Atomic))
        or (isinstance(formula, Forall)
            and is_literal_modified(formula.effect))
    )

def problem__constant(self, args):
    return get_constants(self, args)

def problem__gd(self, args):
    return self._domain_transformer.gd(args)

# ----- GRAMMAR CONSTRUCTION -----

def inject_problem_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    """Inject the new rule and its rule into the .lark file and assign the rule
    to a function in the transformer."""
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(problem.ProblemTransformer, label, function)

def modify_problem_classes():
    pddl.core.Problem.orig_init = pddl.core.Problem.__init__
    pddl.core.Problem.__init__ = new_init_problem
    pddl.core.Problem.__str__ = new_problem_str
    pddl.logic.base.is_literal = is_literal_modified
    pddl.core.is_literal = is_literal_modified

def modify_problem_classes_and_transformer():
    modify_problem_classes()
    delattr(problem.ProblemTransformer, "literal_name")
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
    delattr(problem.ProblemTransformer, "requirements")
    delattr(problem.ProblemTransformer, "num_literal")
    delattr(pddl.logic.base, "is_literal")

def construct_problem_grammar():
    """Construct the entire problem grammar."""
    modify_problem_classes_and_transformer()
    replace_in_grammar(
        "LPAR DEFINE problem_def problem_domain [requirements] [objects] init goal [metric_spec] RPAR",
        "LPAR DEFINE problem_def problem_domain [objects] projection depth task init_type init goal [metric_spec] [plan_def] RPAR"
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
    replace_in_grammar(
        "init_el:               literal_name",
        "init_el:               init_f"
    )
    inject_problem_grammar("problem__constant", "NAME", problem__constant)
    inject_problem_grammar("terminal_predicate_constant_problem", "LPAR [EXC] predicate problem__constant* RPAR", terminal_predicate)
    inject_problem_grammar("atomic_formula_name", "[EXC] problem_modl* terminal_predicate_constant_problem", atomic_formula_term)
    inject_problem_grammar("problem_modl", "LSQB modl_term COMMA problem__constant RSQB | LESSER_OP modl_term COMMA problem__constant GREATER_OP", modl)
    inject_problem_grammar("projection", "LPAR PROJECTION RPAR", projection_transformer)
    inject_problem_grammar("depth", "LPAR DEPTH NUMBER RPAR", depth_transformer)
    inject_problem_grammar("task", "LPAR TASK require_task_key RPAR", task_transformer)
    inject_problem_grammar("init_type", "LPAR INIT_TYPE COMPLETE RPAR", init_type_transformer)
    inject_problem_grammar("plan_def", "LPAR PLAN init_f* RPAR", plan_transformer)
    inject_problem_grammar("goal", "LPAR GOAL problem__gd RPAR", goal_transformer)
    inject_problem_grammar("and_init_f", "LPAR AND init_f* RPAR", problem__gd)
    inject_problem_grammar("and_paft", "LPAR AND problem__atomic_formula_term* RPAR", problem__gd)

    inject_problem_grammar("init_f", "atomic_formula_name | and_init_f | problem_forall", return_option)
    inject_problem_grammar("problem_forall", "LPAR FORALL LPAR typed_list_variable RPAR problem_effect RPAR", problem_forall)
    inject_problem_grammar("problem_effect", "and_paft | problem__atomic_formula_term", return_option)
    
    inject_problem_grammar("problem__atomic_formula_term", "[EXC] modl* problem__terminal_predicate", atomic_formula_term)
    inject_problem_grammar("problem__terminal_predicate", "LPAR [EXC] predicate problem__const_or_var_term* RPAR", terminal_predicate)
    inject_problem_grammar("problem__const_or_var_term", "problem__constant | var", return_option)
    inject_problem_grammar("problem__gd", "problem__atomic_formula_term | LPAR OR problem__gd* RPAR | LPAR NOT problem__gd RPAR | LPAR AND problem__gd* RPAR | LPAR IMPLY problem__gd problem__gd RPAR | LPAR EXISTS LPAR typed_list_variable RPAR problem__gd RPAR | LPAR FORALL LPAR typed_list_variable RPAR problem__gd RPAR | LPAR binary_comp f_exp f_exp RPAR", problem__gd)
