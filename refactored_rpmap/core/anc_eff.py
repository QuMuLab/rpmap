from __future__ import annotations
from enum import Enum
from pddl.core import Predicate
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
        return f"[{self.mod_type.name}, {self.agent}]{str(self.child)}" if self.mod_type in GenericMODLType or self.mod_type in ActionMODLType else f"<{self.mod_type.name}, {self.agent}>{str(self.child)}"
    
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
    if self.arity == 0:
        return f"{p_str})"
    else:
        return f"{p_str} {' '.join(map(str, self.terms))})"

def setup_predicate_class():
    pddl.logic.predicates.Predicate.negated = False
    pddl.logic.predicates.Predicate._negate = negate_predicate
    pddl.logic.predicates.Predicate.__str__ = new_predicate_str

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