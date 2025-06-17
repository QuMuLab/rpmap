# adapted from the PDDL library
import pddl
import pddl.core
from pddl.parser import domain
from pddl.parser.domain import DomainParser
from pddl.logic.predicates import Predicate
from pddl.formatter import (
    print_constants,
    print_function_skeleton,
    print_predicates_with_types,
    print_types_or_functions_with_parents,
    remove_empty_lines,
    sort_and_print_collection,
)
from lark.lexer import Token
from textwrap import indent


def inject_domain_grammar(label, rule, function):
    domain._domain_parser_lark += f"\n{label}: {rule}\n"
    setattr(domain.DomainTransformer, label, function)

def agents_transformer(self, args):
    self._agents = set(args[1:-1])
    return {"agents": self._agents}

def agent_transformer(self, args):
    if len(args) != 1:
        raise ValueError(f"Invalid agent definition: {args}")
    return args[0].value

def atomic_formula_skeleton(self, args):   
    if not args:
        raise ValueError(f"Invalid atomic formula skeleton definition: {args}")
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


def bdi_transformer(self, args):
    print()
    print()

def derived_term_transformer(self, args):
    print()
    print()

def derived_conditions_transformer(self, args):
    print()
    print()
    return args

def always_known_transformer(self, args):
    # NEXT TODO: INJECT {AK} PARAMETER INTO THE PREDICATE OBJECT, THEN MODIFY THE DOMAIN PRINT
    print(type(args))
    if type(args) is not Token:
        raise ValueError(f"Invalid agent definition: {args}")
    return args

def new_init(self, *args, **kwargs):
    self._agents = kwargs["agents"]
    kwargs.pop("agents")
    self.orig_init(*args, **kwargs)

def new_str(self):
    # adapted from the PDDL Domain class __str__ method
    result = f"(define (domain {self.name})"
    body = ""
    indentation = " " * 4
    body += sort_and_print_collection("(:requirements ", self.requirements, ")\n")
    body += f"(:agents {' '.join(sorted(self.agents)) if self.agents else ''})\n"
    body += print_types_or_functions_with_parents("(:types", self.types, ")\n")
    body += print_constants("(:constants", self.constants, ")\n")
    if self.predicates:
        predicates_str = []
        for p in self.predicates:
            p_str = ""
            if p.always_known:
                p_str += "{AK}"
            predicates_str.append(f"{p_str}{print_predicates_with_types([p])}")
        predicates_str = "\n\t".join(predicates_str)
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

def construct_domain_grammar():
    # domain._domain_parser_lark += 
    inject_domain_grammar("agents", "LPAR \":agents\" agent+ RPAR", agents_transformer)
    inject_domain_grammar("agent", "/[a-zA-Z_][a-zA-Z0-9_]*/", agent_transformer)
    domain._domain_parser_lark = domain._domain_parser_lark.replace(
        "LPAR DEFINE domain_def [requirements]",
        "LPAR DEFINE domain_def agents [requirements]"
    )    

    inject_domain_grammar("AK", "\"{AK}\"", always_known_transformer)
    # print(domain._domain_parser_lark)

    # inject_domain_grammar("bdi", "\"[\" variable \"]\" | LESSER_OP variable GREATER_OP", bdi_transformer)
    domain._domain_parser_lark = domain._domain_parser_lark.replace(
        "atomic_formula_skeleton:   LPAR NAME typed_list_variable RPAR",
        ""
    )
    inject_domain_grammar("atomic_formula_skeleton", "[AK] LPAR NAME typed_list_variable RPAR", atomic_formula_skeleton)
    # inject_domain_grammar("derived_term", "term | \"$\" constant \"$\"", derived_term_transformer)
    # inject_domain_grammar("derived_conditions", "\"always\" | \"never\" | LPAR predicate derived_term* RPAR", derived_conditions_transformer)
    # domain._domain_parser_lark = domain._domain_parser_lark.replace(
    #     "action_def:        LPAR ACTION NAME PARAMETERS action_parameters action_body_def RPAR",
    #     "action_def:        LPAR ACTION NAME [\":derive-condition\" derived_conditions] PARAMETERS action_parameters action_body_def RPAR"
    # )
    # domain._domain_parser_lark = domain._domain_parser_lark.replace(
    #     "atomic_formula_term:   LPAR predicate term* RPAR",
    #     "atomic_formula_term:   [\"!\"] bdi* LPAR predicate term* RPAR"
    # )
    
    print(domain._domain_parser_lark)

    # Monkey patching to add agents to the Domain class
    pddl.core.Domain.orig_init = pddl.core.Domain.__init__
    pddl.core.Domain.__init__ = new_init
    pddl.core.Domain.agents = property(lambda self: self._agents)
    # Similar monkey patching for the string representation of the Domain class
    pddl.core.Domain.orig_str = pddl.core.Domain.__str__
    pddl.core.Domain.__str__ = new_str


if __name__ == "__main__":
    construct_domain_grammar()
    parser = DomainParser()
    with open("bdi_testing/mvex.pdkbddl", "r") as f:
        d_pddl = f.read()
    result = parser(d_pddl)
    print(f"\n{result}\n")
    print(f"Agents: {result.agents}\n")