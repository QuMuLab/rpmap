from lark.visitors import Transformer
from pddl.helpers.base import _typed_parameters
from parsing_utils import *

class AncEffTransformer(Transformer):
    def __init__(self):
        """Initialize the AncEffTransformer."""
        super().__init__()

    def start(self, children):
        """Start method for the AncEffTransformer."""
        return children
    
    def list_comp(self, args):
        if not args or args is None:
            raise ValueError(f"Invalid definition of tokens: {args}")
        return ["COMPOUND", *args]
    
    def anceffs(self, args):
        return AncillaryEffects(args[2:-1])

class AncillaryEffects:
    def __init__(self, anc_effs) -> None:
        """Initialize the ancillary effect transformer."""
        self._anceffs = anc_effs

    def __str__(self):
        body = f"({self._anceffs[1]}"
        # loop through all ancillary effects
        for anc_eff in self._anceffs: 
            anc_eff = anc_eff.children[2:-1]
            # add name
            body += f"{NL_AND_TAB}(:anceff {anc_eff[0]}"
            # add parameters (if any)
            if anc_eff[1]:
                body += f"{NL_AND_TABS}:parameters ({_typed_parameters(*anc_eff[1].children[1:])})"
            # add conditions
            for cond in anc_eff[2:4]:
                body += f"{NL_AND_TABS}{cond.children[0]}{NL_AND_TABS}("
                cond = cond.children[2:-1]
                # add each of the condition items
                for item in cond:
                    if item:
                        if type(item.children[1]) == list:
                            body += f"{NL_AND_3_TABS}{item[0].value} {recursive_print(item.children[1], ' ')}"
                        else:
                            body += f"{NL_AND_3_TABS}{recursive_print(item, ' ')}"
                body += f"{NL_AND_TABS})"
            body += f"{NL_AND_TAB})"
        body += f"{NL})\n"
        return body
