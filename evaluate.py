from bdi_extension.domain import construct_domain_grammar
from bdi_extension.problem import construct_problem_grammar
from parsing_injection import write_no_duplicate, read_pdkbddl_file, AncEffDomProbParser, ground, write, solve
from bdi_extension.apply_cond_effs import apply_cond_effs
from pddl.parser import GRAMMAR_FILE
import csv
import os
import pddl
import time
import time
import sys
import re


def write_plan_output():
    output = "planner_output.txt"

    with open(output, "r") as f:
        output_text = f.read()
    # 1. Check if solution was found
    solution_found = bool(re.search(r"Solution found\.", output_text))
    if not solution_found:
        raise ValueError("No plan found!")

    # 2. Extract planner time (INFO     Planner time: 0.39s)
    planner_time_match = re.search(r"Planner time:\s*([0-9.]+)s", output_text)
    planner_time = float(planner_time_match.group(1)) if planner_time_match else None

    # 3. Extract plan length (Plan length: 4 step(s).)
    plan_len_match = re.search(r"Plan length:\s*(\d+)", output_text)
    plan_length = int(plan_len_match.group(1)) if plan_len_match else None

    # read the CSV into a list of rows
    with open("evaluation.csv", "r", newline="") as f:
        reader = csv.reader(f)
        rows = list(reader)

    # append the time value to the last row
    rows[-1].extend([planner_time, plan_length])

    # write the updated rows back to the CSV
    with open("evaluation.csv", "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(rows)


def get_agents_str(num_agents):
    return f"\t(:agents {' '.join(['alice', 'bob', 'cindy', 'derek', 'evelyn'][:num_agents])})"

def eval_single(dom, problem_num, num_agents, parser):
    base_path = os.path.join("bdi_extension", dom)
    domain_path = os.path.join(base_path, "domain.pdkbddl")
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
    
    result = parser(pddl_str)
    grounded_dom_path = os.path.join(base_path, "pdkb-domain.pddl")
    grounded_prob_path = os.path.join(base_path, "pdkb-problem.pddl")
    anc_effs, domain, problem = (result[0].children, *ground(result[1], result[2], grounded_dom_path))
    num_fluents_before_pre = len(domain.predicates)
    print("Applying conditional effects...")
    domain, problem = apply_cond_effs(anc_effs, domain, problem)
    print("Done preprocessing!")
    num_fluents_after_pre = len(domain.predicates)
    pddl.core.Domain.grounded_print = True
    pddl.core.Action.grounded_print = True
    write(grounded_dom_path, str(domain))
    write(grounded_prob_path, str(problem))
    preprocessing_time = time.time() - t0
    with open("evaluation.csv", "a", newline="") as file:
        writer = csv.writer(file)
        writer.writerows([[dom, problem_num, num_agents, problem.depth, num_fluents_before_pre, num_fluents_after_pre, preprocessing_time]])

def evaluate(domain, prob, num_agents):
    # --- GENERAL PARSING SETUP ---
    # read the ancillary effects grammar file and add to the main grammar file
    with open("bdi_extension/ancillary_effects.lark", "r") as f:
        anceff_grammar = f.read()
    write_no_duplicate("\n" + anceff_grammar, GRAMMAR_FILE)
    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_problem_grammar() 
    # read the lark file
    with open(GRAMMAR_FILE, "r") as f:
        grammar = f.read()
    # set up the parser with the lark and parse the PDDL
    parser = AncEffDomProbParser(grammar)
    
    # to create a new database
    # with open("evaluation.csv", "w", newline="") as file:
    #     writer = csv.writer(file)
    #     writer.writerows([["Domain Name", "Problem Name", "Number of Agents", "Depth", "Number of Fluents before Preprocessing", "Number of Fluents after Preprocessing", "Preprocessing Time", "Solve Time", "Plan Length"]])

    # --- MAIN EVALUATION BODY ---
    eval_single(domain, prob, num_agents, parser)

if __name__ == "__main__":
    args = sys.argv[1:]   # everything after the script name
    if len(args) == 3:
        args[1] = int(args[1])
        args[2] = int(args[2])
        evaluate(*args)
    elif len(args) == 0:
        write_plan_output()
    else:
        raise ValueError("Unexpected arguments.")