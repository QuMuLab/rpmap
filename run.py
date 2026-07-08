from rpmap.parsing_injection import *

def test_parse():
    # read the ancillary effects grammar file and add to the main grammar file
    with open("rpmap/ancillary_effects.lark", "r") as f:
        anceff_grammar = f.read()
    write_no_duplicate("\n" + anceff_grammar, GRAMMAR_FILE)
    # modify the domain and problem grammar files to add in the new rules
    construct_domain_grammar()
    construct_problem_grammar()
    # grab the PDDL
    base_path = "domains/disdain"
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

    # solve(base_path)

if __name__ == "__main__":
    test_parse()