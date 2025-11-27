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

DEPTH = [2, 3]


def get_agents_str(num_agents):
    return f"\t(:agents {' '.join(['alice', 'bob', 'cindy', 'derek', 'evelyn'][:num_agents])})"

def eval_solve(dom, parser):
    for i in range(4):
        for dep in DEPTH:   
            problem = i + 1 # iterating through [0-3], problem files are [1-4]
            num_agents = i + 2 # iterating through [0-3], number of agents is [2-5]
            print(f"Domain: {dom}\nProblem: {problem}")
            
            base_path = os.path.join("bdi_extension", dom)
            domain_path = os.path.join(base_path, "domain.pdkbddl")
            with open(domain_path) as f:
                lines = f.readlines()

            with open(domain_path, "w") as f:
                for line in lines:
                    if line.lstrip().startswith("(:agents"):
                        f.write(get_agents_str(num_agents) + "\n") 
                    elif line.lstrip().startswith("(:depth"):
                        f.write(f"(:depth {dep})")
                    else:
                        f.write(line)

            # add the correct number of agents to the domain
            t0 = time.time()
            # grab the PDDL
            problem_name = f"problem_{problem}" 
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
            print("Solving...")
            plan_length, solve_time = solve(base_path)
            with open("evaluation.csv", "a", newline="") as file:
                writer = csv.writer(file)
                writer.writerows([[dom, problem.name, num_agents, dep, i >= 2, num_fluents_before_pre, num_fluents_after_pre, preprocessing_time, solve_time, plan_length]])

            if plan_length == 0:
                print("No plan found!")
                break

def evaluate(domain):
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
    
    with open("evaluation.csv", "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerows([["Domain Name", "Problem Name", "Number of Agents", "Depth", "Requires Depth 3", "Number of Fluents before Preprocessing", "Number of Fluents after Preprocessing", "Preprocessing Time", "Solve Time", "Plan Length"]])

    # --- MAIN EVALUATION BODY ---
    eval_solve(domain, parser)
