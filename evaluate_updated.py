from refactored_rpmap.parsing_and_grounding.parser_setup import AncEffDomProbParser, read_pdkbddl_file
from refactored_rpmap.parsing_and_grounding.ground import ground
from refactored_rpmap.parsing_and_grounding.core.domain import construct_domain_grammar
from refactored_rpmap.parsing_and_grounding.core.problem import construct_problem_grammar
from refactored_rpmap.parsing_and_grounding.utils import write
from refactored_rpmap.parsing_and_grounding.apply_anc_effs import ApplyAncEffs
from pddl.parser import GRAMMAR_FILE
import pddl
import os
import sys
import time
import csv

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

def write_plan_output(dom, prob):
    time_output_path = "time_output.txt"
    plan_output_path = os.path.join("domains", dom, f"plan_{prob}.txt")
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

    with open(plan_output_path, "r", newline="") as f:
        lines = f.readlines()

    # append the plan length to the last row
    rows[-1].append(len(lines) - 1)

    # write the updated rows back to the CSV
    with open(db_path, "w", newline="") as f:
        writer = csv.writer(f)
        writer.writerows(rows)

def create_updated_grammar_file():
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
    construct_domain_grammar()
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

def eval_single(dom, problem_num, num_agents, parser):
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
    anc_effs, grounded_domain, grounded_problem = (parse_result[1][0], *ground(parse_result[1][0], parse_result[0], parse_result[2]))
    num_fluents_before_pre = len(grounded_domain.predicates)
    print("Applying conditional effects...")
    domain, problem = ApplyAncEffs(anc_effs, grounded_domain, grounded_problem).apply_anc_effs()
    print("Done preprocessing!")
    num_fluents_after_pre = len(domain.predicates)
    pddl.core.Domain.grounded_print = True
    pddl.core.Action.grounded_print = True
    write(grounded_dom_path, str(domain))
    write(grounded_prob_path, str(problem))
    preprocessing_time = time.time() - t0
    with open(db_path, "a", newline="") as file:
        writer = csv.writer(file)
        writer.writerows([[dom, problem_num, num_agents, problem.depth, num_fluents_before_pre, num_fluents_after_pre, round(preprocessing_time, 2)]])

def evaluate(dom, prob):
    parser = AncEffDomProbParser(create_updated_grammar_file())

    # anc_effs, grounded_domain, grounded_problem = (parse_result[1][0], *ground(parse_result[1][0], parse_result[0], parse_result[2]))
    
    eval_single(dom, prob, get_num_agents(prob), parser)


    # domain, problem = ApplyAncEffs(anc_effs, grounded_domain, grounded_problem).apply_anc_effs()
    # base_path = os.path.join("refactored_rpmap", "test_files")
    # grounded_dom_path = os.path.join(base_path, "pdkb-domain.pddl")
    # grounded_prob_path = os.path.join(base_path, "pdkb-problem.pddl")
    # pddl.core.Domain.grounded_print = True
    # pddl.core.Action.grounded_print = True
    # write(grounded_dom_path, str(domain))
    # write(grounded_prob_path, str(problem))


if __name__ == "__main__":
    # single_file_run("\n".join(read_pdkbddl_file(os.path.join("refactored_rpmap", "test_files", "problem_1.pdkbddl"))))
    args = sys.argv[1:]   # everything after the script name
    # args = ["bdi-grapevine", "4", "solve"] # for testing
    args[1] = int(args[1]) # problem number (args[0] is the domain name)
    if args[-1] == "solve":
        evaluate(*args[:-1])
    elif args[-1] == "write-plan":
        write_plan_output(*args[:-1])
    else:
        raise ValueError("Unexpected arguments.")