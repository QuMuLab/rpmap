from lark.visitors import Transformer
from parsing_utils import *
from pddl.helpers.base import _typed_parameters


def anceff_atomic_formula_term(self, args):
    # adapted from the PDDL DomainTransformer class atomic_formula_term method
    # figure out where the BDI term ends, e.g. (!)[?agent] or (!)<?agent>
    # (if there's no BDI term, we just skip over None)
    after_bdi = None
    for i in range(len(args)):
        if type(args[i]) == Token:
            if "LPAR" in args[i].type: #accounting for import being part of the type name
                # reached the end of the BDI terms
                after_bdi = i
                break
    negated = False
    if args[after_bdi + 1]:
        if "EXC" in args[after_bdi + 1].type:
            negated = True        
    raw_name = args[after_bdi + 2:-1]
    name = []
    var_pred = False
    for t in raw_name:
        if type(t) == list:
            var_pred = True
            if t[0].type == "QMRK":
                name.append(f"{t[0]}{t[1]}")
            else:
                raise ValueError(f"Dealing with an unknown ancillary effect atomic formula term type {t}.")
        elif type(t) == Token:
            name.append(t.value)
        else:
            raise ValueError(f"Dealing with an unknown ancillary effect atomic formula term type {t}.")
    name = "".join(str(name)) if len(name) > 1 else name[0]
    if var_pred:
        p = VariablePredicate(name)
    else:
        p = Predicate(name)
    p.bdi = args[:after_bdi]  # store the BDI term
    p.negated = negated # store the negated term, e.g. (!term ?a ?b)
    return p

class AncEffTransformer(Transformer):
    def __init__(self):
        """Initialize the AncEffTransformer."""
        super().__init__()
        self.set_up_transformers()

    def start(self, children):
        """Start method for the AncEffTransformer."""
        return children
    
    def list_comp(self, args):
        if not args or args is None:
            raise ValueError(f"Invalid definition of tokens: {args}")
        return ["COMPOUND", *args]
    
    def anceffs(self, args):
        return AncillaryEffects(args[2:-1])
    
    def set_up_transformers(self):
        # use basic token transformers
        for_bt = [
            "ANCEFFS_NAME",
            "ANCEFF_NAME",
            "ANT",
            "CONS",
            "POSCOND",
            "NEGCOND",
            "RML_TYPE",
            "COND_TYPE",
            "CONDITION",
            "LCRL",
            "RCRL",
            "FOR",
            "IN",
            "R",
            "RML_NAME",
            "ADD",
            "DEL"
        ]
        for f in for_bt:
            setattr(AncEffTransformer, f, basic_token_transformer)

        for_bts = [
            "cond_types",
            "anceff_params",
            "poscond",
            "negcond",
            "pos_or_neg_cond_options",
            "pos_or_neg_cond",
            "rml_def",
            "cond_type_def",
            "ant_def",
            "cons_def",
            "condition",
            "anceff",
            "start",
            "var",
            "bdi",
            "bdi_term"
        ]
        for f in for_bts:
            setattr(AncEffTransformer, f, basic_tokens_transformer)

        for_aft = [
            "atomic_formula_term_rml",
            "atomic_formula_term_list_comp_r",
            "atomic_formula_term_condition"
        ]
        for f in for_aft:
            setattr(AncEffTransformer, f, anceff_atomic_formula_term)


class AncillaryEffects:
    def __init__(self, anc_effs) -> None:
        """Initialize the ancillary effect transformer."""
        self._anceffs = anc_effs

    def __str__(self):
        body = f"(:ancillary_effects"
        # loop through all ancillary effects
        for anc_eff in self._anceffs: 
            anc_eff = anc_eff[2:-1]
            # add name
            body += f"{NL_AND_TAB}(:anceff {anc_eff[0]}"
            # add parameters (if any)
            if anc_eff[1]:
                body += f"{NL_AND_TABS}:parameters ({_typed_parameters(*anc_eff[1][1:])})"
            # add conditions
            for cond in anc_eff[2:4]:
                body += f"{NL_AND_TABS}{cond[0]}{NL_AND_TABS}("
                cond = cond[2:-1]
                # add each of the condition items
                for item in cond:
                    if item:
                        if type(item[1]) == list:
                            body += f"{NL_AND_3_TABS}{item[0].value} {recursive_print(item[1], ' ')}"
                        else:
                            body += f"{NL_AND_3_TABS}{recursive_print(item, ' ')}"
                body += f"{NL_AND_TABS})"
            body += f"{NL_AND_TAB})"
        body += f"{NL})\n"
        return body
