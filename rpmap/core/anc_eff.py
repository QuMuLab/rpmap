from ..parsing_utils import *
from lark.visitors import Transformer
from pddl.helpers.base import _typed_parameters
from abc import ABC
from enum import Enum


class GenericMODLType(Enum):
    BELIEF = 1
    DESIRE = 2
    DISDAIN = 4

class Agent:
    def __init__(self, agent, var):
        self.var = var
        self.name = agent
            
    def __eq__(self, other):
        if not isinstance(other, Agent):
            return False
        return self.name == other.name and self.var == other.var
    
    def __hash__(self):
        return hash((self.name, self.var))

class MODL(ABC):
    def __init__(self, modl_type, negate_inner_rml, hard_modl, agent):
        self.modl_type = modl_type
        self.negate_inner_rml = negate_inner_rml
        self.hard_modl = hard_modl
        self.agent = agent
        self.nested = []

    def __str__(self):
        class_name = self.__class__.__name__
        modl_str = "P"  if not self.hard_modl and class_name != "NegateOnly" else ""
        if class_name != "NegateOnly":
            modl_str += f"{self.modl_type.name[:3]}{self.agent.name}"
            for n in self.nested:
                modl_str += f"_{str(n)}"
            if self.negate_inner_rml:
                modl_str += "_not"
        else:
            if self.negate_inner_rml:
                modl_str += "not"        
        return modl_str
    
    def __eq__(self, other):
        if not isinstance(other, self.__class__):
            return False
        return self.negate_inner_rml == other.negate_inner_rml and \
               self.hard_modl == other.hard_modl and \
               self.agent == other.agent and \
               self.nested == other.nested
    
    def __hash__(self):
        return hash((self.negate_inner_rml, self.hard_modl, self.agent, tuple(self.nested)))

    def negate(self, already_negated: bool=False):
        """Propagate a negation through this MODL term and any nested ones.
        - Flip ``hard_modl``/``possible`` status at every level (mirrors how apply_cond_effs
          treats negations when nesting new MODL wrappers).
        - Toggle the inner RML negation unless the caller already handled it
          (``already_negated=True`` is used when the raw predicate was negated upstream).
        - If we have nesting, push the inner-negation marker down to the deepest term so
          only one layer carries it, avoiding duplicate `!` flags after nesting/merging.
        """
        # Will only be None for NegateOnly terms
        if self.hard_modl is not None:
            self.hard_modl = not self.hard_modl
        # Toggle inner RML negation unless already handled
        if not already_negated:
            self.negate_inner_rml = not self.negate_inner_rml
        # Push inner RML negation to deepest nested term
        if self.nested:
            for b in self.nested:
                b.hard_modl = not b.hard_modl
            if self.negate_inner_rml and self.nested[-1].negate_inner_rml:
                self.nested[-1].negate_inner_rml = False
                self.negate_inner_rml = False
            elif self.negate_inner_rml ^ self.nested[-1].negate_inner_rml:
                self.nested[-1].negate_inner_rml = True
                self.negate_inner_rml = False

class NegateOnly(MODL):
    def __init__(self, negate_inner_rml):
        super().__init__(None, negate_inner_rml, None, None)

class GenericModality(MODL):
    def __init__(self, modl_type, negate_inner_rml, hard_modl, agent):
        super().__init__(modl_type, negate_inner_rml, hard_modl, agent)  

class Intention(MODL):
    def __init__(self, modl_type, negate_inner_rml, hard_modl, agent):
        super().__init__(modl_type, negate_inner_rml, hard_modl, agent)

def instantiate_modl(modl_args, ground=True):
    """Instantiate the appropriate MODL class based on the type of MODL term."""
    if not modl_args:
        return None
    # get rid of superfluous None values
    modl_args = [a for a in modl_args if a is not None]
    if not modl_args:
        return None
    else:
        if len(modl_args) == 1:
            if type(modl_args[0]) is Token:
                if modl_args[0].type == "EXC":
                    return NegateOnly(True)
        negate_inner_rml = False
        modl_body = modl_args
        if type(modl_args[0]) is Token:
            if modl_args[0].type == "EXC":
                negate_inner_rml = True
                modl_body = modl_args[1:]
        all_modl = []
        for modl in modl_body:
            # ignore this, this token, if it exists, just indicates nesting
            if modl == Token("LSQB", "["):
                continue
            # compare against names only
            modl_type = modl[1][0].type
            if modl_type in [e.name for e in GenericMODLType] + ["INTENTION"]:
                modl_type = GenericMODLType[modl[1][0].type] if modl[1][0].type != "INTENTION" else "INTENTION"
            else:
                raise ValueError(f"Dealing with an unknown MODL type {modl[1][0].type}.")
            if type(modl[3]) is list:
                agent = Agent(modl[3][1].value, True)
            elif type(modl[3]) is Token:
                agent = Agent(modl[3].value, False)
            hard_modl = modl[0].type == "LSQB"
            if ground:
                if negate_inner_rml:
                    hard_modl = not hard_modl
            if modl_type == "INTENTION":
                all_modl.append(Intention(modl_type, negate_inner_rml, hard_modl, agent))
            else:
                all_modl.append(GenericModality(modl_type, negate_inner_rml, hard_modl, agent))
        main_modl = all_modl[0]
        if len(all_modl) > 1:
            main_modl.nested = all_modl[1:]
        return main_modl


class ModRML:
    def __init__(self, args):
        self.name = None
        # negate the whole thing, whether that's a modl term or not
        # ONLY SET IF THERE'S NO MODL TERM OR TERM NEGATION IN THE RML 
        # (because those have their own negations with distinct meanings,
        # and then we're overloading the '!' operator...)
        self.negate_whole_term = False
        modl_needs_negation = False
        self.modl = None
        self.nest = False
        
        # figure out where the MODL term ends, e.g. (!)[b, ?agent]{index} or (!)<b, ?agent>{index}.
        # (if there's no MODL term, we just skip over None)
        after_modl = None
        for i in range(len(args)):
            if type(args[i]) is Token:
                if "LPAR" in args[i].type: #accounting for import being part of the type name
                    # reached the end of the MODL terms
                    after_modl = i
                    if type(args[after_modl - 1]) is Token:
                        if args[after_modl - 1].type == "LSQB":
                            self.nest = True
                    break
        # check for EXC (negation)
        if args[after_modl + 1]:
            if "EXC" in args[after_modl + 1].type:
                modl_needs_negation = True
        # get the name
        for a in args[after_modl + 2:-1]:
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

        if args[0] == Token("EXC", "!"):
            print()

        self.modl = instantiate_modl(args[:after_modl], ground=False)
        if modl_needs_negation:
            print()
        if self.modl:
            if type(self.modl) != NegateOnly:
                if modl_needs_negation:
                    if self.modl.nested:
                        self.modl.nested[-1].negate_inner_rml = not self.modl.nested[-1].negate_inner_rml
                    else:
                        self.modl.negate_inner_rml = not self.modl.negate_inner_rml
        else:
            if modl_needs_negation:
                self.negate_whole_term = True
        if type(self.modl) is NegateOnly: # just have negation
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
    
    def list_comp_var(self, args):
        """Transformer for list comprehension."""
        if not args or args is None:
            raise ValueError(f"Invalid definition of tokens: {args}")
        # "COMPOUND" is a print tag so we can know to print these differently.
        return ["COMPOUND", *args]
    
    def list_comp_rml(self, args):
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
            "modl",
            "modl_term",
            "awareness",
            "nest",
            "rml_options"
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
