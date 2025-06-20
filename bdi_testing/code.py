# adapted from the PDDL library
import pddl
import pddl.core
import pddl.logic
from pddl.logic.terms import Constant
from pddl.parser import domain
from pddl.parser import problem
import pddl.parser
from pddl.parser.symbols import Symbols
from pddl.parser.domain import DomainParser
from pddl.parser.problem import ProblemParser
from pddl.logic.predicates import Predicate
from pddl.exceptions import PDDLMissingRequirementError
from pddl.requirements import Requirements
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
from pddl.helpers.base import _typed_parameters
from lark.lexer import Token
from textwrap import indent

# FOR THE DOMAIN FILE
def inject_domain_grammar(label, rule, function):
    domain._domain_parser_lark += f"\n{label}: {rule}\n"
    setattr(domain.DomainTransformer, label, function)

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

def atomic_formula_term(self, args):
    # adapted from the PDDL DomainTransformer class atomic_formula_term method
        # figure out where the BDI term ends, e.g. (!)[?agent] or (!)<?agent>
        # (if there's no BDI term, we just skip over None)
    for i in range(len(args)):
        if type(args[i]) == Token and args[i].type != "EXC":
            # reached the end of the BDI terms
            after_bdi = i
            break
    predicate_name = args[after_bdi + 1] # (add one to skip the LPAR)
    terms = list(map(self._constant_or_variable, args[after_bdi + 2:-1]))
    p = Predicate(predicate_name, *terms)
    p.bdi = args[:after_bdi]  # store the BDI term
    return p

def basic_tokens_transformer(self, args):
    if not args or args is None:
        raise ValueError(f"Invalid definition of tokens: {args}")
    return args

def basic_token_transformer(self, args):
    if type(args) is not Token:
        raise ValueError(f"Invalid token definition: {args}")
    return args

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

# for Predicate class
def get_predicate_prefix(self):
    p_str = ""
    if self.always_known:
        p_str += "{AK}"
    if self.bdi:
        for bdi_term in self.bdi:
            if bdi_term:
                p_str += f"{''.join(bdi_term)}"
    return p_str

def new_predicate_str(self):
    # adapted from the PDDL Predicate class __str__ method
    p_str = self.get_predicate_prefix()
    if self.arity == 0:
        return f"{p_str}({self.name})"
    else:
        return f"{p_str}({self.name} {' '.join(map(str, self.terms))})"   
    
# for Action class
def new_action_str(self):
    # TODO: add support for derived conditions
    # adapted from the PDDL Action class __str__ method
    operator_str = "(:action {0}\n".format(self.name)
    if self.derive_condition:
        operator_str += f"   :derive-condition "
        for term in self.derive_condition:
            if type(term) == list:
                operator_str += f"{''.join(term)} "
            else:
                operator_str += f"{term} "
                
        operator_str += "\n"
    operator_str += f"    :parameters ({_typed_parameters(self.parameters)})\n"
    if self.precondition is not None:
        operator_str += f"    :precondition {str(self.precondition)}\n"
    if self.effect is not None:
        operator_str += f"    :effect {str(self.effect)}\n"
    operator_str += ")"
    return operator_str

# for Domain class
def new_str(self):
    # adapted from the PDDL Domain class __str__ method
    result = f"(define (domain {self.name})"
    body = ""
    indentation = " " * 4
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    body += f"(:agents {' '.join(sorted(self.agents)) if self.agents else ''})\n"
    del self.types["agent"]  # remove agents from types
    self._types = Types(self.types, self._requirements)
    body += print_types_or_functions_with_parents("(:types", self.types, ")\n")
    body += print_constants("(:constants", self.constants, ")\n")
    if self.predicates:
        predicates_str = "\n\t".join([f"{p.get_predicate_prefix()}{print_predicates_with_types([p])}" for p in self.predicates])
        body += f"(:predicates\n\t{predicates_str}\n)\n"
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
    result = result + "\n" + indent(body, indentation) + "\n)"
    result = remove_empty_lines(result)

    return result

def new_init(self, *args, **kwargs):
    self._agents = kwargs["agents"]
    kwargs["types"]["agent"] = None
    kwargs.pop("agents")
    self.orig_init(*args, **kwargs)

# FOR THE PROBLEM FILE
def inject_problem_grammar(label, rule, function):
    problem._problem_parser_lark += f"\n{label}: {rule}\n"
    setattr(problem.ProblemTransformer, label, function)

def atomic_formula_name(self, args):
    # adapted from the PDDL ProblemTransformer class atomic_formula_name method
    # figure out where the BDI term ends, e.g. (!)[?agent] or (!)<?agent>
    # (if there's no BDI term, we just skip over None)
    for i in range(len(args)):
        if type(args[i]) == Token and args[i].type != "EXC":
            # reached the end of the BDI terms
            after_bdi = i
            break
    predicate_name = args[after_bdi + 1] # (add one to skip the LPAR)
    terms = []
    for _term_name in args[after_bdi + 2:-1]:
        if self._objects_by_name.get(str(_term_name)) is None:
            terms.append(Constant(str(_term_name)))
        else:
            terms.append(self._objects_by_name.get(str(_term_name)))
    p = Predicate(predicate_name, *terms)
    p.bdi = args[:after_bdi]  # store the BDI term
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
    args = basic_tokens_transformer(self, args)
    return ("plan", args) 

def new_init_problem(self, *args, **kwargs):
    self.depth = int(kwargs["depth"][2].value)  # store the depth
    self.task = kwargs["task"][2].value  # store the task
    self.init_type = kwargs["init_type"][2].value  # store the init type
    self.plan = kwargs["plan"][2:-1]  # store the plan
    kwargs.pop("depth")
    kwargs.pop("task")
    kwargs.pop("init_type")
    kwargs.pop("plan")
    self.orig_init(*args, **kwargs)

def new_problem_str(self):
    # adapted from the PDDL Problem class __str__ method
    result = f"(define (problem {self.name})"
    body = f"(:domain {self.domain_name})\n"
    indentation = " " * 4
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    if self.objects:
        body += print_constants("(:objects", self.objects, ")\n")
    body += f"(:depth {self.depth})\n"
    body += f"(:task {self.task})\n"
    body += f"(:init-type {self.init_type})\n"
    body += sort_and_print_collection(
        "(:init ", self.init, ")\n", is_mandatory=True
    )
    body += f"{'(:goal ' + str(self.goal) + ')'}\n"
    body += f"{'(:metric ' + str(self.metric) + ')'}\n" if self.metric else ""
    if self.plan:
        body += sort_and_print_collection(
            "(:plan ", self.plan, ")\n"
        )
    result = result + "\n" + indent(body, indentation) + "\n)"
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
        )

def new_predicate_hash(self):
    # adapted from the PDDL Predicate class __hash__ method
    bdi_str = ""
    if self.bdi:
        for bdi_term in self.bdi:
            if bdi_term:
                bdi_str += f"{''.join(bdi_term)}"
    return hash((self.name, self.arity, self.terms, self.always_known, bdi_str))

# to build the domain grammar via Python magic
def construct_domain_grammar():
    # inject rules for defining agents
    inject_domain_grammar("agents", "LPAR \":agents\" agent+ RPAR", agents_transformer)
    inject_domain_grammar("agent", "/[a-zA-Z_][a-zA-Z0-9_]*/", agent_transformer)
    domain._domain_parser_lark = domain._domain_parser_lark.replace(
        "LPAR DEFINE domain_def [requirements]",
        "LPAR DEFINE domain_def agents [requirements]"
    )    
    # inject rules for always known predicates
    inject_domain_grammar("AK", "\"{AK}\"", basic_token_transformer)
    domain._domain_parser_lark = domain._domain_parser_lark.replace(
        "atomic_formula_skeleton:   LPAR NAME typed_list_variable RPAR",
        ""
    )
    inject_domain_grammar("atomic_formula_skeleton", "[AK] LPAR NAME typed_list_variable RPAR", atomic_formula_skeleton)
    
    # inject rules for derived conditions
    inject_domain_grammar("DLR", "\"$\"", basic_token_transformer)
    inject_domain_grammar("derived_term", "QMRK NAME | DLR NAME DLR", basic_tokens_transformer)
    inject_domain_grammar("ALWAYS", "\"always\"", basic_token_transformer)
    inject_domain_grammar("NEVER", "\"never\"", basic_token_transformer)
    inject_domain_grammar("derived_conditions", "ALWAYS | NEVER | LPAR predicate derived_term* RPAR", basic_tokens_transformer)
    inject_domain_grammar("DERIVE_CONDITION", "\":derive-condition\"", basic_tokens_transformer)
    domain._domain_parser_lark = domain._domain_parser_lark.replace(
        "action_def:        LPAR ACTION NAME PARAMETERS action_parameters action_body_def RPAR",
        ""
    )
    inject_domain_grammar("action_def", "LPAR ACTION NAME [DERIVE_CONDITION derived_conditions] PARAMETERS action_parameters action_body_def RPAR", action_transformer)

    # inject rules for BDI terms
    inject_domain_grammar("LSQB", "\"[\"", basic_token_transformer)
    inject_domain_grammar("RSQB", "\"]\"", basic_token_transformer)
    inject_domain_grammar("QMRK", "\"?\"", basic_token_transformer)
    inject_domain_grammar("bdi", "LSQB QMRK NAME RSQB | LESSER_OP QMRK NAME GREATER_OP", basic_tokens_transformer)
    domain._domain_parser_lark = domain._domain_parser_lark.replace(
        "atomic_formula_term:   LPAR predicate term* RPAR",
        ""
    )
    inject_domain_grammar("EXC", "\"!\"", basic_token_transformer)
    inject_domain_grammar("atomic_formula_term", "[EXC] bdi* LPAR predicate term* RPAR", atomic_formula_term)

    # Monkey patching to add agents to the Domain class
    pddl.core.Domain.orig_init = pddl.core.Domain.__init__
    pddl.core.Domain.__init__ = new_init
    pddl.core.Domain.agents = property(lambda self: self._agents)
    # Similar monkey patching for the string representation of the Domain class
    pddl.core.Domain.orig_str = pddl.core.Domain.__str__
    pddl.core.Domain.__str__ = new_str

def construct_problem_grammar():
    problem._problem_parser_lark = problem._problem_parser_lark.replace(
        "LPAR DEFINE problem_def problem_domain [problem_requirements] [objects] init goal [metric_spec] RPAR",
        "LPAR DEFINE problem_def problem_domain [problem_requirements] [objects] depth task init_type init goal [metric_spec] [plan] RPAR"
    )    
    inject_problem_grammar("EXC", "\"!\"", basic_token_transformer)
    inject_problem_grammar("LSQB", "\"[\"", basic_token_transformer)
    inject_problem_grammar("RSQB", "\"]\"", basic_token_transformer)
    inject_problem_grammar("DEPTH", "\":depth\"", basic_token_transformer)
    inject_problem_grammar("TASK", "\":task\"", basic_token_transformer)
    inject_problem_grammar("INIT_TYPE", "\":init-type\"", basic_token_transformer)
    inject_problem_grammar("VALID", "\"valid_generation\"", basic_token_transformer)
    inject_problem_grammar("ASSESS", "\"valid_assessment\"", basic_token_transformer)
    inject_problem_grammar("PLAN", "\":plan\"", basic_token_transformer)
    inject_problem_grammar("COMPLETE", "\"complete\"", basic_token_transformer)
    inject_problem_grammar("?require_task_key", "VALID | ASSESS", basic_tokens_transformer)
    inject_problem_grammar("bdi", "LSQB NAME RSQB | LESSER_OP NAME GREATER_OP", basic_tokens_transformer)

    problem._problem_parser_lark = problem._problem_parser_lark.replace(
        "atomic_formula_name:   LPAR predicate NAME* RPAR",
        ""
    )
    inject_problem_grammar("atomic_formula_name", "[EXC] bdi* LPAR predicate NAME* RPAR", atomic_formula_name)
    inject_problem_grammar("depth", "LPAR DEPTH NUMBER RPAR", depth_transformer)
    inject_problem_grammar("task", "LPAR TASK require_task_key RPAR", task_transformer)
    inject_problem_grammar("init_type", "LPAR INIT_TYPE COMPLETE RPAR", init_type_transformer)
    inject_problem_grammar("plan", "LPAR PLAN gd_name* RPAR", plan_transformer)

    pddl.core.Problem.orig_init = pddl.core.Problem.__init__
    pddl.core.Problem.__init__ = new_init_problem
    pddl.core.Problem.__str__ = new_problem_str
    pddl.core.Problem.depth = None
    pddl.core.Problem.task = None
    pddl.core.Problem.init_type = None
    pddl.core.Problem.plan = None
    print(problem._problem_parser_lark)

if __name__ == "__main__":
    pddl.logic.predicates.Predicate.orig_str = pddl.logic.predicates.Predicate.__str__
    pddl.logic.predicates.Predicate.__str__ = new_predicate_str
    pddl.logic.predicates.Predicate.__eq__ = new_predicate_eq
    pddl.logic.predicates.Predicate.__hash__ = new_predicate_hash
    pddl.logic.predicates.Predicate.get_predicate_prefix = get_predicate_prefix
    pddl.logic.predicates.Predicate.always_known = None
    pddl.logic.predicates.Predicate.bdi = None
    pddl.action.Action.orig_str = pddl.action.Action.__str__
    pddl.action.Action.__str__ = new_action_str
    pddl.action.Action.derive_condition = None

    construct_domain_grammar()
    parser = DomainParser()
    with open("bdi_testing/suspicious_witches_domain.pdkbddl", "r") as f:
        d_pddl = f.read()
    result = parser(d_pddl)
    # print(f"\n{result}\n")
    with open("bdi_testing/parsed_domain.pddl", "w") as f:
        f.write(f"\n{result}\n")

    construct_problem_grammar()
    parser = ProblemParser()
    with open("bdi_testing/witch_problem.pdkbddl", "r") as f:
        p_pddl = f.read()
    result = parser(p_pddl)
    with open("bdi_testing/parsed_problem.pddl", "w") as f:
        f.write(f"\n{result}\n")