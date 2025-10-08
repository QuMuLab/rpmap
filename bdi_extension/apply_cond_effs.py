def apply_cond_effs(anc_effs, domain, problem):
    for anc_eff in anc_effs._anceffs:
        print(anc_eff[2].value)
        anc_eff = anc_eff[3:-1] # remove parantheses and anceff name    
        # parameters are optional
        if anc_eff[0]:
            params = anc_eff[0][1]
        # antecedent
        ant = anc_eff[1][2:-1]
        ant_pos_cond = ant[0]
        ant_neg_cond = ant[1]
        ant_rml = ant[3]
        ant_cond_type = ant[4]
        # consequent
        cons = anc_eff[2][2:-1]
        cons_pos_cond = cons[0]
        cons_neg_cond = cons[1]
        cons_rml = cons[2]
        cons_cond_type = cons[3]
        for action in domain._actions:
            print()
            