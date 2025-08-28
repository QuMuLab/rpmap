import pddl.core
from parsing_utils import *
from pddl.formatter import (
    print_constants,
    remove_empty_lines,
    sort_and_print_collection,
)
from pddl.helpers.base import assert_
from pddl.logic.terms import Constant
from pddl.parser import problem, GRAMMAR_FILE
from textwrap import indent

# ----- TRANSFORMER FUNCTIONS -----
def atomic_formula_name(self, args):
    """Adapted from the pddl.parser.problem.ProblemTransformer.atomic_formula_name method."""
    # figure out where the BDI term ends, e.g. (!)[b, ?agent]{index} or (!)<b, ?agent>{index}.
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
    # set up terms
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
    """Transformer for the problem depth."""
    args = basic_tokens_transformer(self, args)
    return ("depth", args)

def goal_transformer(self, args):
    """Transformer for the problem goal."""
    args = self.init(args)
    return ("goal", args[1])

def init_type_transformer(self, args):
    """Transformer for the problem init type."""
    args = basic_tokens_transformer(self, args)
    return ("init_type", args) 

def plan_transformer(self, args):
    """Transformer for the problem plan."""
    args = self.init(args)
    return ("plan", args[1]) 

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

# ----- OTHER CLASS MODIFICATIONS -----

def new_init_problem(self, *args, **kwargs):
    """New init function for the problem that takes depth, task, init type, and plan into account."""
    self.depth = int(kwargs["depth"][2].value)  # store the depth
    self.task = kwargs["task"][2].value  # store the task
    self.init_type = kwargs["init_type"][2].value  # store the init type
    self.plan = kwargs["plan"] # store the plan
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
    functions are being combined under one Transformer). 

    Also note that we can't just import the function because we have to delete it... :P    
    """
    assert_(len(args) == 1, "Unexpected parsing error.")
    return Constant(args[0])

# ----- GRAMMAR CONSTRUCTION -----

def inject_problem_grammar(label, rule, function, grammar_file=GRAMMAR_FILE):
    """Inject the new rule and its rule into the .lark file and assign the rule
    to a function in the transformer."""
    new_rule = f"\n{label}: {rule}\n"
    write_no_duplicate(new_rule, grammar_file)
    setattr(problem.ProblemTransformer, label, function)

def construct_problem_grammar():
    """Construct the entire problem grammar."""
    # replace overall structure
    replace_in_grammar(
        "LPAR DEFINE problem_def problem_domain [requirements] [objects] init goal [metric_spec] RPAR",
        "LPAR DEFINE problem_def problem_domain [objects] depth task init_type init goal [metric_spec] [plan] RPAR"
    )
    # inject the basic problem tokens
    inject_problem_grammar("DEPTH", "\":depth\"", basic_token_transformer)
    inject_problem_grammar("TASK", "\":task\"", basic_token_transformer)
    inject_problem_grammar("INIT_TYPE", "\":init-type\"", basic_token_transformer)
    inject_problem_grammar("VALID", "\"valid_generation\"", basic_token_transformer)
    inject_problem_grammar("ASSESS", "\"valid_assessment\"", basic_token_transformer)
    inject_problem_grammar("PLAN", "\":plan\"", basic_token_transformer)
    inject_problem_grammar("COMPLETE", "\"complete\"", basic_token_transformer)
    inject_problem_grammar("?require_task_key", "VALID | ASSESS", basic_tokens_transformer)
    # prepare to create new atomic_formula_name and goal rules
    replace_in_grammar(
        "atomic_formula_name:   LPAR predicate NAME* RPAR",
        ""
    )
    replace_in_grammar(
        "goal:  LPAR GOAL gd RPAR",
        ""
    )
    # inject BDI capability into the atomic_formula_name transformer
    inject_problem_grammar("atomic_formula_name", "[EXC] problem_bdi* LPAR [EXC] predicate NAME* RPAR", atomic_formula_name)
    inject_problem_grammar("problem_bdi", "LSQB bdi_term COMMA NAME RSQB | LESSER_OP bdi_term COMMA NAME GREATER_OP", basic_tokens_transformer)
    # transformers for depth, task, init type, and goal
    inject_problem_grammar("depth", "LPAR DEPTH NUMBER RPAR", depth_transformer)
    inject_problem_grammar("task", "LPAR TASK require_task_key RPAR", task_transformer)
    inject_problem_grammar("init_type", "LPAR INIT_TYPE COMPLETE RPAR", init_type_transformer)
    inject_problem_grammar("plan", "LPAR PLAN gd_name* RPAR", plan_transformer)
    inject_problem_grammar("goal", "LPAR GOAL gd_name* RPAR", goal_transformer)
    # insert a new problem gd
    inject_problem_grammar("gd_name", "atomic_formula_name | LPAR NOT atomic_formula_name RPAR | LPAR AND gd_name* RPAR | LPAR binary_comp metric_f_exp metric_f_exp RPAR", basic_tokens_transformer)
    # add a new init function and a new string function
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
