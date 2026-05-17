from pdkb.planner import parse_and_preprocess, cleanup
from pdkb.test.utils import write_file
from evaluate import get_num_agents, get_agents_str, write_plan_output
import csv, sys, time, os

def generate_pddl(prob):
    print(prob)
    base_path = os.path.join("bdi_extension", "original_grapevine")
    domain_path = os.path.join(base_path, "domain.pdkbddl")
    db_path = os.path.join("evaluation", "original_grapevine_evaluation.csv")
    with open(domain_path, "r") as f:
        lines = f.readlines()
    num_agents = get_num_agents(prob)
    with open(domain_path, "w") as f:
        for line in lines:
            if line.lstrip().startswith("(:agents"):
                f.write(get_agents_str(num_agents) + "\n") 
            else:
                f.write(line)
    t0 = time.time()
    problem, num_fluents_before_pre, num_fluents_after_pre = parse_and_preprocess(os.path.join(base_path,f"problem_{prob}.pdkbddl"))
    preprocessing_time = time.time() - t0
    domain_path = os.path.join(base_path, "pdkb-domain.pddl")
    problem_path = os.path.join(base_path, "pdkb-problem.pddl")
    write_file(domain_path, problem.domain.pddl())
    write_file(problem_path, problem.pddl())

    depth = 2 if prob < 9 else 3

    with open(db_path, "a", newline="") as file:
        writer = csv.writer(file)
        writer.writerows([["original_grapevine", prob, num_agents, depth, num_fluents_before_pre, num_fluents_after_pre, round(preprocessing_time, 2)]])


if __name__ == "__main__":
    args = sys.argv
    args[1] = int(args[1]) # problem number (args[0] is the domain name)
    # args = ["original_grapevine", 1, "solve"] # for testing
    if args[-1] == "solve":
        generate_pddl(args[1])
    elif args[-1] == "write-plan":
        write_plan_output("original_grapevine", args[1])
        # cleanup()
    else:
        raise ValueError("Unexpected arguments.")
    
