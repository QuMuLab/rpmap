from copy import deepcopy
import itertools
from typing import Sequence
import bdi_extension.anc_eff as anc_eff
import os
import pddl
import sys
from bdi_extension.domain import construct_domain_grammar
from lark import Lark
from lark.visitors import Transformer
from bdi_extension.parsing_utils import *
from pddl.action import Action
import pddl.core as pddl_core
from pddl.logic.base import And
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant, Variable
from pddl.parser import GRAMMAR_FILE
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
import pdkb.pddl.grounder as grounder
from pdkb.rml import parse_rml
from pdkb.problems import Domain, convert_action, parse_problem
from bdi_extension.problem import construct_problem_grammar
from bdi_extension.apply_cond_effs import apply_cond_effs

def write(file_path, content):
    """Write content to a file."""
    with open(file_path, "w") as file:
        file.write(content)

def read_pdkbddl_file(fname):
    """Adapted from the pdkb.problems.read_pdkbddl_file function
    and the pdkb.test.utils.read_file function.
    
    Reads a pdkbddl file to a list of lines."""

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
    for _, transformer in transformers_to_merge.items():
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
    
def new_solve(parsed_pdkbddl_file):
    with open(parsed_pdkbddl_file, "r") as f:
        lines = f.readlines()
    
    dom_index = -1
    prob_index = -1
    for i in range(len(lines)):
        if '(define (domain' in lines[i]:
            assert -1 == dom_index
            dom_index = i
        if '(define (problem' in lines[i]:
            assert -1 == prob_index
            prob_index = i
    assert dom_index != -1, "Error: No domain type defined"
    assert prob_index != -1, "Error: No problem type defined"
    prob = grounder.GroundProblem(lines[dom_index:prob_index], lines[prob_index:])

    fluents = [x for x in prob.fluents if not x.always_known]
    akfluents = [x for x in prob.fluents if x.always_known]

    props = [parse_rml('_'.join(str(p)[1:-1].split())) for p in fluents]
    akprops = [parse_rml('_'.join(str(p)[1:-1].split())) for p in akfluents]

    domain = Domain(prob.agents, props, akprops,
                    [convert_action(a, prob.depth, prob.agents, props, akprops) for a in prob.operators],
                    prob.depth, prob.types, prob.domain_name)

    problem = parse_problem(prob, domain)
    problem.preprocess()
    problem.solve()
    problem.output_solution()

# ----- GROUNDING FUNCTIONS -----
def create_valuations(domain, problem, variables: Sequence[Variable]):
    assignment = {}
    for var in variables:
        if var.type_tags == frozenset({"agent"}):
            assignment[var.name] = list(domain._agents)
        else:
            assignment[var.name] = [o.name for o in problem.objects if o.type_tags == var.type_tags]
    return itertools.product(*assignment.values())

def create_fluents(domain, problem):
    """Create the set of fluents by grounding the predicates.
    Adapted from the pdkb.pddl.grounder.GroundProblem._create_fluents method."""
    fluents = set([])
    for p in domain.predicates:
        val_generator = create_valuations(domain, problem, p.terms)
        for valuation in val_generator:
            grounded_p = Predicate(p.name, *(Constant(c) for c in valuation))
            grounded_p.bdi = p.bdi
            grounded_p.negated = p.negated
            grounded_p.always_known = p.always_known
            fluents.add(grounded_p)
    return fluents

def predicates_to_fluents(predicates: list[Predicate], assignment):
    fluents = []
    for p in predicates:
        p = deepcopy(p)
        new_terms = []
        if type(p) is not Predicate:
            outside_formula_type = type(p)
            terms = p.argument.terms
        else:
            terms = p.terms
        for t in terms:
            new_terms.append(Constant(assignment[t.name]))
        
        if type(p) is not Predicate:
            f = Predicate(p.argument.name, *new_terms)
            f.bdi = p.argument.bdi
            f.negated = p.argument.negated
            f.always_known = p.argument.always_known
            fluents.append(outside_formula_type(f))
        else:
            f = Predicate(p.name, *new_terms)
            if p.bdi:         
                p.bdi[1][3] = Token("NAME", assignment[p.bdi[1][3][1].value]) 
                # for bdi_term in p.bdi[1:]: #exclude the EXC token
                #     for i in range(len(bdi_term)):
                #         token = bdi_term[i]
                #         if type(token) is list:
                #             if token[0].type == "QMRK":
                #                 if token[1] in assignment:
                #                     token[1].value = assignment[token[1].value]
                #                     bdi_term[i] = token[1]
            f.bdi = p.bdi
            f.negated = p.negated
            f.always_known = p.always_known
            fluents.append(f)
    return fluents

def ground_formula(domain, problem, formula, assignment):
    if type(formula) is Predicate:
        return predicates_to_fluents([formula], assignment)[0]
    elif type(formula) is And:
        return And(*predicates_to_fluents(formula.operands, assignment))
    elif type(formula) is Forall:
        # need to get all values for this variable
        grounded = []
        var_names = [v.name for v in formula.variables]
        val_generator = create_valuations(domain, problem, formula.variables)
        for valuation in val_generator:
            # need to add onto the existing assignment so we retain knowledge of outer variables
            for var_name, val in zip(var_names, valuation):
                assignment[var_name] = val
            grounded.append(ground_formula(domain, problem, formula.effect, assignment))
        return And(*grounded)
    elif type(formula) is When:
        cond = ground_formula(domain, problem, formula.condition, assignment)
        if type(cond) is Predicate:
            # for formatting reasons we want to force this into being an "And"
            and_term = And(*[])
            and_term._operands.append(cond)
            cond = and_term
        return When(cond, ground_formula(domain, problem, formula.effect, assignment))


def create_operators(domain, problem, fluent_dict):
    """Create the set of operators by grounding the actions.
    Adapted from the pdkb.pddl.grounder.GroundProblem._create_operators method"""

    operators = set([])

    for a in domain.actions:
        var_names = [v.name for v in a.parameters]
        val_generator = create_valuations(domain, problem, a.parameters)
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            op_name_suffix = "_".join([assignment[var.name] for var in a.parameters])
            if op_name_suffix:
                op_name = a.name + "_" + op_name_suffix
            else:
                op_name = a.name
            # TODO: handle other types of formulas?
            precondition = And(*predicates_to_fluents(a.precondition.operands, assignment))
            effect = ground_formula(domain, problem, a.effect, assignment)     
            new_a = Action(
                    op_name,
                    None,
                    precondition,
                    effect
                )
            if type(a.derive_condition) is list:
                # have a complex derived condition
                # need to ensure we handle any variables here
                dev_cond_copy = deepcopy(a.derive_condition)
                for i in range(len(dev_cond_copy)):
                    if type(dev_cond_copy[i]) is list:
                        if type(dev_cond_copy[i][0]) is list:
                            if dev_cond_copy[i][0][0].type == "QMRK":
                                dev_cond_copy[i] = Constant(assignment[dev_cond_copy[i][0][1].value])
            new_a.derive_condition = dev_cond_copy
            operators.add(new_a)
    return operators

def ground(domain, problem):
    """Convert this problem into a ground problem."""

    fluents = create_fluents(domain, problem)

    # to avoid creating a bunch new fluent objects, create a dictionary mapping fluent names to their objects
    fluent_dict = {hash(f): f for f in fluents}
    operators = create_operators(domain, problem, fluent_dict)
    
    grounded_domain = pddl_core.Domain(
        name=domain.name, 
        requirements=domain.requirements, 
        types=domain.types, 
        constants=domain.constants, 
        predicates=fluents,
        derived_predicates=domain.derived_predicates, 
        functions=domain.functions, 
        actions=operators, 
        agents=domain._agents)
    write("bdi_extension/bdi_pdkbddl_files/grounded_domain.pdkbddl", str(grounded_domain))
    print()
    return grounded_domain, problem
    # self._ground_init(fluent_dict)
    # self._ground_goal(fluent_dict)

if __name__ == "__main__":
    # read the ancillary effects grammar file and add to the main grammar file
    with open("bdi_extension/ancillary_effects.lark", "r") as f:
        anceff_grammar = f.read()
    write_no_duplicate("\n" + anceff_grammar, GRAMMAR_FILE)
    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_problem_grammar()
    # grab the PDDL
    pddl = "\n".join(read_pdkbddl_file("bdi_extension/bdi_pdkbddl_files/bdi_mvex_problem.pdkbddl"))
    # read the lark file
    with open(GRAMMAR_FILE, "r") as f:
        grammar = f.read()
    # set up the parser with the lark and parse the PDDL
    parser = AncEffDomProbParser(grammar)
    result = parser(pddl)

    # with open("bdi_extension/bdi_pdkbddl_files/parsed.pdkbddl", "w") as f:
    #     # one result for the ancillary effects, one for the domain, and one for the problem
    #     for r in result:
    #         f.write(f"{r}\n")
    # new_solve("bdi_extension/bdi_pdkbddl_files/parsed.pdkbddl")

    # from pdkb.pddl.grounder.GroundProblem._ground
    anc_eff, domain, problem = (result[0], *ground(result[1], result[2]))
    apply_cond_effs(anc_eff, domain, problem)
    write("bdi_extension/bdi_pdkbddl_files/grounded_domain.pdkbddl", str(domain))
