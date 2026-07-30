from __future__ import annotations
from enum import Enum
from lark.visitors import Transformer, Token
from pddl.core import Predicate
from pddl.logic.terms import Variable
from copy import deepcopy
import pddl

class GenericMODLType(Enum):
    BEL = 1
    DES = 2
    DSD = 3
    LOV = 4

class PossibleGenericMODLType(Enum):
    PBEL = 1
    PDES = 2
    PDSD = 3
    PLOV = 4

class ActionMODLType(Enum):
    ITN = 1

class PossibleActionMODLType(Enum):
    PITN = 1

class Agent:
    def __init__(self, name: str, var: bool):
        self.name = name
        self.var = var

    def __eq__(self, other):
        if not isinstance(other, Agent):
            return False
        return self.name == other.name and self.var == other.var
    
    def __hash__(self):
        return hash((self.name, self.var))
    
    def __repr__(self):
        return f"?{self.name}" if self.var else f"{self.name}"

class MODL:
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent):
        self.mod_type = mod_type
        self.agent = agent
        self.child = None | MODL | NOT_MODL

    def __call__(self, arg):
        if isinstance(arg, MODL) or isinstance(arg, NOT_MODL) or isinstance(arg, Predicate):
            if (self.mod_type in ActionMODLType or self.mod_type in PossibleActionMODLType) and not isinstance(arg, Predicate):
                raise ValueError("Cannot apply an Action MODL to another MODL.")
            new_base = deepcopy(self)
            new_base.child = deepcopy(arg)
            return new_base
        else:
            raise TypeError("Expecting another MODL or a Predicate.")
            
    def __repr__(self):
        return f"[{self.mod_type.name}, {self.agent}]{str(self.child)}" if self.mod_type in GenericMODLType or self.mod_type in ActionMODLType else f"<{self.mod_type.name[1:]}, {self.agent}>{str(self.child)}"
    
    def _negate(self):
        if self.mod_type in GenericMODLType:
            new_base = self.__class__(list(PossibleGenericMODLType)[list(GenericMODLType).index(self.mod_type)], self.agent)
        elif self.mod_type in PossibleGenericMODLType:
            new_base = self.__class__(list(GenericMODLType)[list(PossibleGenericMODLType).index(self.mod_type)], self.agent)
        elif self.mod_type in ActionMODLType:
            new_base = self.__class__(list(PossibleActionMODLType)[list(ActionMODLType).index(self.mod_type)], self.agent)
        else:
            new_base = self.__class__(list(ActionMODLType)[list(PossibleActionMODLType).index(self.mod_type)], self.agent)
        if self.child:
            return new_base(self.child._negate())
        return new_base

class NOT_MODL:
    def __init__(self):
        pass

    def __call__(self, arg):
        return arg._negate()

def negate_predicate(self):
    new_base = deepcopy(self)
    new_base.negated = not self.negated
    return new_base

def new_predicate_str(self):
    """New predicate string adapted from the pddl.logic.Predicate.__str__ method."""
    p_str = f"(!{self.name}" if self.negated else f"({self.name}"
    return f"{p_str})" if self.arity == 0 else f"{p_str} {' '.join(map(str, self.terms))})"

class RMLPredicate(Predicate):
    def __init__(self, name):
        super().__init__(name)
        self.negated = False
        self.nest = False
    
def var(self, args):
    return Variable(args[1].value)

def modl(self, args):
    # hard modality
    hard_modality = True
    if args[0].type == "LSQB":
        possible_classes = [GenericMODLType, ActionMODLType]
    else:
        hard_modality = False
        possible_classes = [PossibleGenericMODLType, PossibleActionMODLType]
    term_name = args[1].children[0].upper()
    if not hard_modality:
        term_name = "P" + term_name
    for modl_type in possible_classes:
        if term_name in [m.name for m in modl_type]:
            return MODL(modl_type[term_name], Agent(args[3].name, True if isinstance(args[3], Variable) else False))
    raise ValueError(f"MODL Type {term_name} is not specified in any of the MODLType categories in 'anc_eff.py.'")
        
def anceff_atomic_formula_term(self, args):
    negate_modalities = True if args[0] else False
    modls_no_neg = args[1:]
    for i in range(len(modls_no_neg) - 1, - 1, - 1):
        if isinstance(modls_no_neg[i], RMLPredicate):
            continue
        modls_no_neg[i] = modls_no_neg[i](modls_no_neg[i + 1])
    modl = modls_no_neg[0]
    return NOT_MODL()(modl) if negate_modalities else modl

def terminal_helper(args, name):
    pred = RMLPredicate(name)
    # nesting is present
    if args[0]:
        pred.nest = True
    # negation is present
    if args[2]:
        pred.negated = True
    return pred

def terminal_rml(self, args):
    return terminal_helper(args, "rml")

def terminal_r(self, args):
    return terminal_helper(args, "r")

class ListCompVar:
    def __init__(self, rml_pred: RMLPredicate, var: Variable):
        self.rml_pred = RMLPredicate
        self.var = Variable

class ListCompAgents:
    def __init__(self, rml_pred: RMLPredicate):
        self.rml_pred = RMLPredicate

class AncEffPart:
    def __init__(self, poscond, negcond, rml: list, type: str):
        self.poscond = poscond
        self.negcond = negcond
        self.rml = rml
        self.type = type

class Consequent(AncEffPart):
    def __init__(self, poscond, negcond, rml, type):
        super().__init__(poscond, negcond, rml, type)

class Antecedent(AncEffPart):
    def __init__(self, awareness, rml, type):
        super().__init__(Variable("pos"), Variable("neg"), rml, type)
        self.awareness = awareness

class AncEff:
    def __init__(self, name, parameters, antecedent, consequent):
        self.name = name
        self.parameters = parameters
        self.antecedent = antecedent
        self.consequent = consequent

class AncEffs:
    def __init__(self, anceffs):
        self.anceffs = anceffs

def return_all(self, args):
    return args

def anceffs(self, args):
    return AncEffs(args[2:-1])

def anceff(self, args):
    return AncEff(args[2].value, args[3], args[4], args[5])

def antecedent(self, args):
    return Antecedent(args[4], args[5], args[6])

def consequent(self, args):
    return Consequent(args[2].children[1] if args[2] else None, args[3].children[1] if args[3] else None, args[4], args[5])

def list_comp_var(self, args):
    return ListCompVar(args[1], args[5])

def list_comp_agents(self, args):
    return ListCompAgents(args[1])

def return_option(self, args):
    return args[0]

def plural(self, args):
    return [a for a in args[1:] if a != Token("PLUS", "+")]

def cond_type_def(self, args):
    return args[1].children[0].value

def setup_predicate_classes():
    RMLPredicate._negate = negate_predicate
    RMLPredicate.__str__ = new_predicate_str

    pddl.logic.predicates.Predicate.negated = False
    pddl.logic.predicates.Predicate._negate = negate_predicate
    pddl.logic.predicates.Predicate.__str__ = new_predicate_str

class AncEffTransformer(Transformer):
    def __init__(self):
        """Initialize the AncEffTransformer."""
        super().__init__()
        self.set_up_transformers()
        setup_predicate_classes()

    def start(self, children):
        """Start method for the AncEffTransformer."""
        return children

    def set_up_transformers(self):
        setattr(AncEffTransformer, "atomic_formula_term_rml", anceff_atomic_formula_term)
        setattr(AncEffTransformer, "terminal_rml", terminal_rml)
        setattr(AncEffTransformer, "terminal_r", terminal_r)
        setattr(AncEffTransformer, "modl", modl)
        setattr(AncEffTransformer, "var", var)
        setattr(AncEffTransformer, "atomic_formula_term_list_comp_r", anceff_atomic_formula_term)
        setattr(AncEffTransformer, "list_comp_r_var", list_comp_var)
        setattr(AncEffTransformer, "list_comp_rml_var", list_comp_var)
        setattr(AncEffTransformer, "list_comp_r_agents", list_comp_agents)
        setattr(AncEffTransformer, "list_comp_rml_agents", list_comp_agents)
        setattr(AncEffTransformer, "antecedent", antecedent)
        setattr(AncEffTransformer, "consequent", consequent)
        setattr(AncEffTransformer, "rml_options", return_option)
        setattr(AncEffTransformer, "rml_def", plural)
        setattr(AncEffTransformer, "cond_type_def", cond_type_def)
        setattr(AncEffTransformer, "pos_or_neg_cond_options", return_option)
        setattr(AncEffTransformer, "pos_or_neg_cond", plural)
        setattr(AncEffTransformer, "anceff", anceff)
        setattr(AncEffTransformer, "anceffs", anceffs)
        setattr(AncEffTransformer, "all_anceffs", return_all)

if __name__ == "__main__":
    # Example usage
    agent1 = Agent("alice", False)
    agent2 = Agent("bob", False)
    agent3 = Agent("cindy", False)
    agent4 = Agent("derek", False)
    agent5 = Agent("evelyn", False)
    agent6 = Agent("frank", False)
    BEL = MODL(GenericMODLType.BEL, agent1)
    DES = MODL(GenericMODLType.DES, agent2)
    ITN = MODL(ActionMODLType.ITN, agent3)
    PBEL = MODL(PossibleGenericMODLType.PBEL, agent4)
    PDES = MODL(PossibleGenericMODLType.PDES, agent5)
    PITN = MODL(PossibleActionMODLType.PITN, agent6)
    NOT = NOT_MODL()
    pred = Predicate("secret")

    rml = (DES(ITN(NOT(NOT(BEL(pred))))))
    print(rml)

    # rml = BEL(DES(pred))
    # print("BEL(DES(pred)) -> ", rml, "\n")
    
    # rml = BEL(NOT(DES(pred)))
    # print("BEL(NOT(DES(pred))) -> ", rml, "\n")

    # rml = BEL((DES(NOT(pred))))
    # print("BEL((DES(NOT(pred)))) -> ", rml, "\n")

    # rml = BEL((DES(NOT(NOT(pred)))))
    # print("BEL((DES(NOT(NOT(pred))))) -> ", rml, "\n")

    # rml = NOT(BEL((DES(NOT(NOT(pred))))))
    # print("NOT(BEL((DES(NOT(NOT(pred)))))) -> ", rml, "\n")