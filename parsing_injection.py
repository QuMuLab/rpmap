from copy import deepcopy
import bdi_extension.anc_eff as anc_eff
import os
import pddl
import sys
import time
from bdi_extension.domain import construct_domain_grammar
from bdi_extension.anc_eff import Agent, NegateOnly, Intention
from lark import Lark
from lark.visitors import Transformer
from bdi_extension.parsing_utils import *
from pddl.action import Action
import pddl.core as pddl_core
from pddl.logic.base import And, Not
from pddl.logic.effects import Forall, When
from pddl.logic.terms import Constant
from pddl.parser import GRAMMAR_FILE
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
from pdkb.test.utils import run_command, parse_output_ipc
from bdi_extension.problem import construct_problem_grammar
from bdi_extension.apply_cond_effs import apply_cond_effs
from bdi_extension.parsing_utils import create_valuations


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

# ----- GROUNDING FUNCTIONS -----
def create_fluents(domain, problem):
    """Create the set of fluents by grounding the predicates.
    Adapted from the pdkb.pddl.grounder.GroundProblem._create_fluents method."""
    fluents = set([])
    for p in domain.predicates:
        val_generator = create_valuations(domain._agents, problem.objects, p.terms)
        for valuation in val_generator:
            grounded_p = Predicate(p.name, *(Constant(c) for c in valuation))
            grounded_p.bdi = p.bdi
            grounded_p.negated = p.negated
            grounded_p.always_known = p.always_known
            fluents.add(grounded_p)
    return fluents

def predicates_to_fluents(predicates: list[Predicate], assignment, domain_preds):
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
            f.negated = (p.argument.negated == True) # become False if it's None
            f.always_known = p.argument.always_known
            fluents.append(outside_formula_type(f))
        else:
            f = Predicate(p.name, *new_terms)
            if p.bdi:  
                if p.bdi.agent.var:
                    p.bdi.agent = Agent(assignment[p.bdi.agent.name], False)   
                if p.bdi.nested:
                    for i in range(len(p.bdi.nested)):
                        p.bdi.nested[i].agent = Agent(assignment[p.bdi.nested[i].agent.name], False)
            f.bdi = p.bdi
            f.negated = (p.negated == True) # become False if it's None
            # find the "always known" status by referencing it from the domain predicates
            for dp in domain_preds:
                if dp.name == f.name and len(dp.terms) == len(f.terms):
                    f.always_known = dp.always_known
                    break
            if not f.always_known and f.negated:
                f.negated = False
                if f.bdi:
                    if f.bdi.nested:
                        f.bdi.nested[-1].negate_inner_rml = not p.bdi.nested[-1].negate_inner_rml
                    else:
                        f.bdi.negate_inner_rml = not f.bdi.negate_inner_rml
                else:
                    f.bdi = NegateOnly(True)
            fluents.append(f)
    return fluents

def ground_formula(domain, problem, formula, assignment):
    if type(formula) is Predicate:
        return predicates_to_fluents([formula], assignment, domain.predicates)[0]
    elif type(formula) is Not:
        p = ground_formula(domain, problem, formula.argument, assignment)
        if type(p) is Predicate:
            p.negated = True
            return p
        else:
            raise NotImplementedError("Deal with a complex Not formula?")
    elif type(formula) is And:
        return And(*[ground_formula(domain, problem, o, assignment)  for o in formula.operands])
    elif type(formula) is Forall:
        # need to get all values for this variable
        grounded = []
        var_names = [v.name for v in formula.variables]
        val_generator = create_valuations(domain._agents, problem.objects, formula.variables)
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
    action_intention_f = set()

    for a in domain.actions:
        var_names = [v.name for v in a.parameters]
        val_generator = create_valuations(domain._agents, problem.objects, a.parameters)
        for valuation in val_generator:
            assignment = {var_name: val for var_name, val in zip(var_names, valuation)}
            op_name_suffix = "_".join([assignment[var.name] for var in a.parameters])
            if op_name_suffix:
                op_name = a.name + "_" + op_name_suffix
            else:
                op_name = a.name
            # TODO: handle other types of formulas?
            precondition = And(*predicates_to_fluents(a.precondition.operands, assignment, domain.predicates))
            effect = ground_formula(domain, problem, a.effect, assignment) 
            intend_action_p = Predicate(a.name, *[Constant(assignment[t.name]) for t in a.parameters])
            intend_action_p.always_known = False
            intend_action_p.negated = False
            all_iaps = []
            action_iaps = []
            for ag in domain._agents:
                iap = deepcopy(intend_action_p)
                iap.bdi = Intention(True, True, Agent(ag, False))
                action_iaps.append(iap)
                all_iaps.append(iap)
                # these are for the predicates to add to the domain.
                # we're adding them with the intention already nested,
                # because we don't allow other modalities on them
                # (although other modalities can be nested on top).
                # add version with no negation
                iap_c = deepcopy(iap)
                iap_c.bdi.negate_inner_rml = False
                all_iaps.append(iap_c)
                # add versions with possible intention
                iap_c = deepcopy(iap)
                iap_c.bdi.hard_bdi = False
                all_iaps.append(iap_c)
                iap_c = deepcopy(iap)
                iap_c.bdi.negate_inner_rml = False
                iap_c.bdi.hard_bdi = False
                all_iaps.append(iap_c)
            and_ = And(*[])
            if type(effect) is And:
                and_._operands.extend(effect._operands)
            else:
                and_._operands.append(effect)
            and_._operands.extend(action_iaps)
            effect = and_

            action_intention_f.update(all_iaps)

            new_a = Action(
                    op_name,
                    None,
                    precondition,
                    effect
                )
            new_a.assignment = assignment
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
    return operators, action_intention_f

def ground(domain, problem, path):
    """Convert this problem into a ground problem."""

    fluents = create_fluents(domain, problem)

    # to avoid creating a bunch new fluent objects, create a dictionary mapping fluent names to their objects
    # TODO: actually use this dict
    fluent_dict = {hash(f): f for f in fluents}
    operators, action_intention_f = create_operators(domain, problem, fluent_dict)
    fluents.update(action_intention_f)

    # need to get the always known status for predicates
    for p in problem.init:
        for dom_p in domain.predicates:
            if p.name == dom_p.name:
                p.always_known = dom_p.always_known
                break
        if not p.always_known and p.negated:
            p.negated = False
            if p.bdi:
                if p.bdi.nested:
                    p.bdi.nested[-1].negate_inner_rml = not p.bdi.nested[-1].negate_inner_rml
                else:
                    p.bdi.negate_inner_rml = not p.bdi.negate_inner_rml
            else:
                p.bdi = NegateOnly(True)

    new_goal = None
    if problem.goal[0] == Token("LPAR", "(") and problem.goal[1] == Token("AND", "and") and \
        problem.goal[-1] == Token("RPAR", ")"):
        new_goal = And(*[])
        for g in problem.goal[2:-1]:
            if type(g) is list:
                new_goal._operands.extend(g)
            else:
                new_goal._operands.append(g)
    goal = new_goal._operands if new_goal else problem.goal
    for p in goal:
        for dom_p in domain.predicates:
            if p.name == dom_p.name:
                p.always_known = dom_p.always_known
                break
        if not p.always_known and p.negated:
            p.negated = False
            if p.bdi:
                if p.bdi.nested:
                    p.bdi.nested[-1].negate_inner_rml = not p.bdi.nested[-1].negate_inner_rml
                else:
                    p.bdi.negate_inner_rml = not p.bdi.negate_inner_rml
            else:
                p.bdi = NegateOnly(True)
    
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
    problem = pddl_core.Problem(
        problem.name,
        grounded_domain,
        problem.domain_name,
        domain.requirements,
        problem.objects,
        problem.init,
        new_goal if new_goal else problem.goal,
        # problem.goal,
        problem.metric,
        depth=problem.depth,
        task=problem.task,
        init_type=problem.init_type,
        plan=problem.plan,
        projection=problem.projection
    )
    write(path, str(grounded_domain))
    return grounded_domain, problem

def solve(path=False):
    # Solve the problem
    domain_path = os.path.join(path, "pdkb-domain.pddl")
    problem_path = os.path.join(path, "pdkb-problem.pddl")
    plan_path = os.path.join(path, "pdkb-plan.txt")
    output_path = os.path.join(path, "pdkb-plan.out")
    planner_path = os.path.dirname(os.path.abspath(__file__))

    planner_cmd = f"python3 {planner_path}/pdkb/planners/staged_bfws.py {domain_path} {problem_path} {plan_path}"

    t0 = time.time()
    run_command(planner_cmd,
                output_file = output_path,
                MEMLIMIT = "2000000",
                TIMELIMIT = "1800")
    plan_time = time.time() - t0
    print("\nPlan Time: %.5f\n" % plan_time)
    plan = parse_output_ipc(plan_path)

    print("Plan Length: %d\n" % len(plan.actions))

    return len(plan.actions), plan_time

if __name__ == "__main__":
    # read the ancillary effects grammar file and add to the main grammar file
    with open("bdi_extension/ancillary_effects.lark", "r") as f:
        anceff_grammar = f.read()
    write_no_duplicate("\n" + anceff_grammar, GRAMMAR_FILE)
    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_problem_grammar()
    # grab the PDDL
    base_path = "bdi_extension/belief-intention"
    pddl_str = "\n".join(read_pdkbddl_file(f"{base_path}/problem_1.pdkbddl"))
    # read the lark file
    with open(GRAMMAR_FILE, "r") as f:
        grammar = f.read()
    # set up the parser with the lark and parse the PDDL
    parser = AncEffDomProbParser(grammar)
    result = parser(pddl_str)

    grounded_dom_path = f"{base_path}/pdkb-domain.pddl"
    grounded_prob_path = f"{base_path}/pdkb-problem.pddl"
    anc_effs, domain, problem = (result[0].children, *ground(result[1], result[2], grounded_dom_path))
    domain, problem = apply_cond_effs(anc_effs, domain, problem)

    pddl.core.Domain.grounded_print = True
    pddl.core.Action.grounded_print = True
    write(grounded_dom_path, str(domain))
    write(grounded_prob_path, str(problem))

    solve(base_path)