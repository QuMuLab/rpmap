from .parsing_utils import *
from lark.visitors import Transformer
from pddl.helpers.base import _typed_parameters
from pddl.logic.terms import Constant
from abc import ABC, abstractmethod
from enum import Enum


# def get_merged_token_value(token):
#     if token.type == "LSQB":
#         return ""
#     elif token.type == "RSQB":
#         return "_"
#     elif token.type == "LESSER_OP":
#         return "P"
#     elif token.type == "GREATER_OP":
#         return "_"
#     elif token.type == "COMMA":
#         return ""
#     elif token.type == "BELIEF":
#         return "B"
#     elif token.type == "DESIRE":
#         return "D"
#     elif token.type == "INTENTION":
#         return "I"
#     else:
#         return token.value

class BDIType(Enum):
    BELIEF = 1
    DESIRE = 2
    INTENTION = 3

class Agent:
    def __init__(self, agent):
        self.var = False
        self.name = None
        if type(agent) is str:
            self.name = agent
        elif type(agent) is Token:
            self.name = agent.value
        elif type(agent) is list: # var parsing
            self.var = True
            try:
                self.name = agent[1].value
            except Exception as e:
                raise ValueError(f"Error parsing agent variable name from args {agent}: {e}")
            
    def __eq__(self, other):
        if not isinstance(other, Agent):
            return False
        return self.name == other.name and self.var == other.var
    
    def __hash__(self):
        return hash((self.name, self.var))

class BDI(ABC):
    def __init__(self, negate_inner_rml, bdi_args):
        self.negate_inner_rml = negate_inner_rml
        self.hard_bdi = None
        self.agent = None
        self.nested = []

        if bdi_args:
            self.hard_bdi = True if bdi_args[0].type == "LSQB" else False
            self.agent = Agent(bdi_args[3])

    def __str__(self):
        class_name = self.__class__.__name__
        bdi_str = "P"  if not self.hard_bdi and class_name != "NegateOnly" else ""
        
        if class_name != "NegateOnly":
            bdi_str += f"{self.__class__.__name__[0]}{self.agent.name}"
            if self.negate_inner_rml:
                bdi_str += "_not"
        else:
            if self.negate_inner_rml:
                bdi_str += "not"        
        return bdi_str
    
    def __eq__(self, other):
        if not isinstance(other, BDI):
            return False
        return self.negate_inner_rml == other.negate_inner_rml and \
               self.hard_bdi == other.hard_bdi and \
               self.agent == other.agent and \
               self.nested == other.nested
    
    def __hash__(self):
        return hash((self.negate_inner_rml, self.hard_bdi, self.agent, tuple(self.nested)))

    def negate(self, already_negated: bool=False):
        self.hard_bdi = not self.hard_bdi
        if not already_negated:
            self.negate_inner_rml = not self.negate_inner_rml
        if self.nested:
            for b in self.nested:
                b.hard_bdi = not b.hard_bdi
            if self.negate_inner_rml and self.nested[-1].negate_inner_rml:
                self.nested[-1].negate_inner_rml = False
                self.negate_inner_rml = False
            elif self.negate_inner_rml ^ self.nested[-1].negate_inner_rml:
                self.nested[-1].negate_inner_rml = True
                self.negate_inner_rml = False

class NegateOnly(BDI):
    def __init__(self, negate_inner_rml):
        super().__init__(negate_inner_rml, None)

    def negate(self):
        self.negate_inner_rml = not self.negate_inner_rml

class Belief(BDI):
    def __init__(self, negate_inner_rml, bdi_args):
        super().__init__(negate_inner_rml, bdi_args)  

class Desire(BDI):
    def __init__(self, negate_inner_rml, bdi_args):
        super().__init__(negate_inner_rml, bdi_args)

class Intention(BDI):
    def __init__(self, negate_inner_rml, bdi_args):
        super().__init__(negate_inner_rml, bdi_args)

def instantiate_bdi(bdi_args):
    """Instantiate the appropriate BDI class based on the type of BDI term."""
    if not bdi_args:
        return None
    # get rid of superfluous None values
    bdi_args = [a for a in bdi_args if a is not None]
    if not bdi_args:
        return None
    else:
        if len(bdi_args) == 1:
            if type(bdi_args[0]) is Token:
                if bdi_args[0].type == "EXC":
                    return NegateOnly(True)
        negate_inner_rml = False
        bdi_body = bdi_args[0]
        if type(bdi_args[0]) is Token:
            if bdi_args[0].type == "EXC":
                negate_inner_rml = True
                bdi_body = bdi_args[1]
        bdi_type = bdi_body[1][0].type
        if bdi_type == "BELIEF":
            return Belief(negate_inner_rml, bdi_body)
        elif bdi_type == "DESIRE":
            return Desire(negate_inner_rml, bdi_body)
        elif bdi_type == "INTENTION":
            return Intention(negate_inner_rml, bdi_body)


class ModRML:
    def __init__(self, args):
        self.name = None
        # negate the whole thing, whether that's a bdi term or not
        # ONLY SET IF THERE'S NO BDI TERM OR TERM NEGATION IN THE RML 
        # (because those have their own negations with distinct meanings,
        # and then we're overloading the '!' operator...)
        self.negate_whole_term = False
        self.negate_inner_rml_rml = False
        self.bdi = None
        self.nest = False
        
        # figure out where the BDI term ends, e.g. (!)[b, ?agent]{index} or (!)<b, ?agent>{index}.
        # (if there's no BDI term, we just skip over None)
        after_bdi = None
        for i in range(len(args)):
            if type(args[i]) is Token:
                if "LPAR" in args[i].type: #accounting for import being part of the type name
                    # reached the end of the BDI terms
                    after_bdi = i
                    if type(args[after_bdi - 1]) is Token:
                        if args[after_bdi - 1].type == "LSQB":
                            self.nest = True
                    break
        # check for EXC (negation)
        if args[after_bdi + 1]:
            if "EXC" in args[after_bdi + 1].type:
                self.negate_inner_rml_rml = True
        # get the name
        for a in args[after_bdi + 2:-1]:
            if a:
                if type(a) is Token:
                    if a.type in ["RML_NAME", "R"]:
                        raw_name = [a]
                        break
                elif type(a) is list:
                    if a[0].type == "QMRK":
                        raw_name = a
                        break
        name = []
        # we get either a simple name like (rml) or a variable name like (?mu).
        # we just treat it like the string name of a predicate.
        for t in raw_name:
            if type(t) is list:
                if t[0].type == "QMRK":
                    name.append(f"{t[0]}{t[1]}")
                else:
                    raise ValueError(f"Dealing with an unknown ancillary effect atomic formula term type {t}.")
            elif type(t) is Token:
                name.append(t.value)
            else:
                raise ValueError(f"Dealing with an unknown ancillary effect atomic formula term type {t}.")   
        self.name = "".join(str(name)) if len(name) > 1 else name[0]

        self.bdi = instantiate_bdi(args[:after_bdi])
        if type(self.bdi) is NegateOnly: # just have negation
            self.negate_whole_term = True  

def anceff_atomic_formula_term(self, args):
    """Create a modification of the atomic formula term transformer for ancillary effects.
    Adapted from the pddl.parser.domain.DomainTransformer.atomic_formula_term method.
    """
    return ModRML(args)

class AncillaryEffects:
    """Class for Ancillary Effects, analogous to the pddl.core.Domain and pddl.core.Problem classes."""
    def __init__(self, anc_effs) -> None:
        """Initialize the Ancillary Effects by just saving the passed ancillary effects."""
        self._anceffs = anc_effs

    def __str__(self):
        """String function for Ancillary Effects."""
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
                        if type(item[1]) is list:
                            body += f"{NL_AND_3_TABS}{item[0].value} {recursive_print(item[1], ' ')}"
                        else:
                            body += f"{NL_AND_3_TABS}{recursive_print(item, ' ')}"
                body += f"{NL_AND_TABS})"
            body += f"{NL_AND_TAB})"
        body += f"{NL})\n"
        return body

class AncEffTransformer(Transformer):
    def __init__(self):
        """Initialize the AncEffTransformer."""
        super().__init__()
        self.set_up_transformers()

    def start(self, children):
        """Start method for the AncEffTransformer."""
        return children
    
    def list_comp(self, args):
        """Transformer for list comprehension."""
        if not args or args is None:
            raise ValueError(f"Invalid definition of tokens: {args}")
        # "COMPOUND" is a print tag so we can know to print these differently.
        return ["COMPOUND", *args]
    
    def anceffs(self, args):
        """Transformer for ancillary effects which strips the brackets and ancillary effects name."""
        return AncillaryEffects(args[2:-1])
    
    def set_up_transformers(self):
        """Assign the names of rules to functions in the AncEffTransformer."""
        # use the basic token transformer
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
        # use the basic tokens transformer
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
            "bdi_term",
            "awareness",
            "nest"
        ]
        for f in for_bts:
            setattr(AncEffTransformer, f, basic_tokens_transformer)
        # use the anceff atomic formula transformer
        for_aft = [
            "atomic_formula_term_rml",
            "atomic_formula_term_list_comp_r",
            "atomic_formula_term_condition"
        ]
        for f in for_aft:
            setattr(AncEffTransformer, f, anceff_atomic_formula_term)
