from refactored_rpmap.parsing_and_grounding.core.anc_eff import GenericMODLType, PossibleGenericMODLType, ActionMODLType, PossibleActionMODLType
from refactored_rpmap.parsing_and_grounding import apply_anc_effs_grounded
from refactored_rpmap.parsing_and_grounding import apply_anc_effs_lifted
from refactored_rpmap.parsing_and_grounding.core.domain import construct_domain_grammar
from refactored_rpmap.parsing_and_grounding.core.problem import construct_problem_grammar
from refactored_rpmap.parsing_and_grounding.ground import ground
from refactored_rpmap.parsing_and_grounding.normalize import apply_and_check_intention
from refactored_rpmap.parsing_and_grounding.parser_setup import AncEffDomProbParser, read_pdkbddl_file
from refactored_rpmap.parsing_and_grounding.utils import write
from pddl.parser import GRAMMAR_FILE
import argparse
import csv
import os
import pddl
import sys
import time

AGENT_REF_CAP = 10


def get_num_agents(prob):
    if prob == 1:
        return 2
    elif prob >= 2 and prob <= 8:
        return 3
    elif prob == 9:
        return 4
    elif prob == 10:
        return 5

def get_agents_str(num_agents):
    return f"\t(:agents {' '.join(['alice', 'bob', 'cindy', 'derek', 'evelyn'][:num_agents])})"

def write_plan_output(dom):
    time_output_path = "time_output.txt"
    db_path = os.path.join("evaluation_data", f"{dom}_evaluation.csv")

    with open(time_output_path, "r") as f:
        lines = f.readlines()
    time = lines[0].strip()[:-1].split(" ")[-1]

    # read the CSV into a list of rows
    with open(db_path, "r", newline="") as f:
        reader = csv.reader(f)
        rows = list(reader)

    # append the time value to the last row
    rows[-1].append(time)

    # write the updated rows back to the CSV
    with open(db_path, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(rows)

def create_updated_grammar_file(grounded):
    # read the original grammar file
    original_path = os.path.join("refactored_rpmap", "parsing_and_grounding", "grammar.lark")
    with open(original_path, "r") as f:
        original_grammar = f.read()

    # read the ancillary effects grammar file and add to the main grammar file
    lark_path = os.path.join("refactored_rpmap", "parsing_and_grounding", "ancillary_effects.lark")
    with open(lark_path, "r") as f:
        anceff_grammar = f.read()

    with open(GRAMMAR_FILE, "w") as f:
        f.write(original_grammar + "\n" + anceff_grammar)

    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar(grounded)
    construct_problem_grammar() 
    # read the lark file
    with open(GRAMMAR_FILE, "r") as f:
        grammar = f.read()
    return grammar

def parse(grammar, pdkbddl_str):
    parser = AncEffDomProbParser(grammar)
    return parser(pdkbddl_str)

def get_parsing_result(pdkbddl_str):
    grammar = create_updated_grammar_file()
    return parse(grammar, pdkbddl_str)

def eval_single(dom, problem_num, num_agents, parser, grounded, agent_ref_cap):
    base_path = os.path.join("domains", dom)
    domain_path = os.path.join(base_path, "domain.pdkbddl")
    db_path = os.path.join("evaluation_data", f"{dom}_evaluation.csv")
    with open(domain_path, "r") as f:
        lines = f.readlines()

    with open(domain_path, "w") as f:
        for line in lines:
            if line.lstrip().startswith("(:agents"):
                f.write(get_agents_str(num_agents) + "\n") 
            else:
                f.write(line)

    # add the correct number of agents to the domain
    t0 = time.time()
    # grab the PDDL
    problem_name = f"problem_{problem_num}" 
    pddl_str = "\n".join(read_pdkbddl_file(os.path.join(base_path, f"{problem_name}.pdkbddl")))
    
    parse_result = parser(pddl_str)
    grounded_dom_path = os.path.join(base_path, "pdkb-domain.pddl")
    grounded_prob_path = os.path.join(base_path, "pdkb-problem.pddl")
    anc_effs, domain, problem = [anc_eff for anc_eff_set in parse_result[1] for anc_eff in anc_eff_set], parse_result[0], parse_result[2]
    print("Applying conditional effects...")
    
    if grounded:
        anc_effs, domain, problem = (anc_effs, *ground(domain, problem))
        domain, problem, anc_effs_count = apply_anc_effs_grounded.ApplyAncEffs(anc_effs, domain, problem).apply_anc_effs()
    else:
        domain = apply_and_check_intention(domain)
        domain, problem, anc_effs_count = apply_anc_effs_lifted.ApplyAncEffs(anc_effs, domain, problem, agent_ref_cap).apply_anc_effs()
    pddl.core.Domain.post_processing_print = True
    pddl.core.Domain.grounded = grounded
    pddl.core.Action.post_processing_print = True
    write(grounded_dom_path, str(domain))
    write(grounded_prob_path, str(problem))
    preprocessing_time = time.time() - t0
    with open(db_path, "a", newline="") as file:
        writer = csv.writer(file)
        writer.writerows([[dom, problem_num, num_agents, problem.depth, anc_effs_count, round(preprocessing_time, 2)]])
    print("Done preprocessing! Planning...")

def evaluate(dom, prob, grounded, agent_ref_cap):
    eval_single(dom, prob, get_num_agents(prob), AncEffDomProbParser(create_updated_grammar_file(grounded)), grounded, agent_ref_cap)

if __name__ == "__main__":
    p = argparse.ArgumentParser()
    p.add_argument("domain")
    p.add_argument("i", type=int)
    p.add_argument("mode", choices=["solve", "write-plan"])
    group = p.add_mutually_exclusive_group()
    group.add_argument("--disable-cap", action="store_true")
    group.add_argument("--ground", action="store_true")
    group.add_argument("--set-cap", type=int, metavar="N")
    args = p.parse_args()

    if args.mode == "solve":
        if args.disable_cap:
            args.set_cap = sys.maxsize
        if not args.set_cap:
            args.set_cap = AGENT_REF_CAP
        evaluate(args.domain, args.i, args.ground, args.set_cap)
    else:
        write_plan_output(args.domain)