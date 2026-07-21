from __future__ import annotations
from enum import Enum
from pddl.core import Predicate

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
    
# ----- PREDICATE CLASS -----
class RML:
    def __init__(self, name: str):
        self.name = name

    def __repr__(self):
        return str(self.name)

# ----- OVERARCHING MODALITY CLASS -----

class Modality:
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType, agent: Agent):
        self.mod_type = mod_type
        self.agent = agent
    
    def negate(self):
        return self.__class__(list(PossibleGenericMODLType)[list(GenericMODLType).index(self.mod_type)] if self.mod_type in GenericMODLType else list(GenericMODLType)[list(PossibleGenericMODLType).index(self.mod_type)], self.agent)

class NMODL(Modality):
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType, agent: Agent):
        super().__init__(mod_type, agent)
        self.child = None

    def __call__(self, other):
        if not isinstance(other, Modality):
            raise TypeError("Can only add a Modality as a child to a NMODL.")
        self.child = other
        return self
    
    def __repr__(self):
        return f"[{self.mod_type.name}, {self.agent}]{str(self.child)}" if self.mod_type in GenericMODLType else f"<{self.mod_type.name}, {self.agent}>{str(self.child)}"
    
    def negate(self):
        return super().negate()(self.child.negate())

class LMODL(Modality):
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType, agent: Agent):
        super().__init__(mod_type, agent)
        self.predicate = None
        self.negated = False

    def __call__(self, predicate, negated):
        if not isinstance(predicate, Predicate) or not isinstance(negated, bool):
            raise TypeError("LMODL must take a Predicate and a bool for its call parameters.")
        self.predicate = predicate
        self.negated = negated
        return self
    
    def __repr__(self):
        terms = " ".join(self.predicate.terms) if self.predicate.terms else ""
        if self.negated:
            pred_str = f"({'!' + self.predicate.name + terms})"
        else:
            pred_str = str(self.predicate)
        return f"[{self.mod_type.name}, {self.agent}]{pred_str}" if self.mod_type in GenericMODLType else f"<{self.mod_type.name}, {self.agent}>{pred_str}"
    
    def negate(self):
        return super().negate()(self.predicate, not self.negated)
    
# ----- HARD AND SOFT MODALITIES -----
    
# class HardModality(Modality):
#     def __init__(self, mod_type: GenericMODLType, agent: Agent):
#         super().__init__(mod_type, agent)

#     def __repr__(self):
#         return f"[{self.mod_type.name}, {self.agent}]{str(self.child) if self.child else ''}"
    
#     # def negate(self):
#     #     if self.child:
#     #         return globals()[f"P{self.__class__.__name__}"](self.agent, self.child.negate())
#     #     else:
#     #         return globals()[f"P{self.__class__.__name__}"](self.agent)
    
# class SoftModality(Modality):
#     def __init__(self, mod_type: GenericMODLType, agent: Agent):
#         super().__init__(mod_type, agent)

#     def __repr__(self):
#         return f"<{self.mod_type.name}, {self.agent}>{str(self.child) if self.child else ''}"
    
#     # def negate(self):
#     #     return globals()[f"{self.__class__.__name__[1:]}"](self.agent, self.child.negate())

# ----- GENERIC MODALITIES -----

# class G_MODL(HardModality):
#     def __init__(self, mod_type: GenericMODLType, agent: Agent):
#         super().__init__(mod_type, agent)

# class GA_MODL(HardModality):
#     def __init__(self, mod_type: ActionMODLType, agent: Agent):
#         super().__init__(mod_type, agent)

# # ----- GENERIC ACTION MODALITIES -----

# class PG_MODL(SoftModality):
#     def __init__(self, mod_type: GenericMODLType, agent: Agent):
#         super().__init__(mod_type, agent)

# class PGA_MODL(SoftModality):
#     def __init__(self, mod_type: ActionMODLType, agent: Agent):
#         super().__init__(mod_type, agent)

# ----- CUSTOM MODALITIES -----

# class BEL(G_MODL):
#     def __init__(self, agent: Agent):
#         super().__init__(GenericMODLType.BEL, agent)

# class PBEL(PG_MODL):
#     def __init__(self, agent: Agent):
#         super().__init__(GenericMODLType.BEL, agent)

# class DES(G_MODL):
#     def __init__(self, agent: Agent):
#         super().__init__(GenericMODLType.DES, agent)

# class PDES(PG_MODL):
#     def __init__(self, agent: Agent):
#         super().__init__(GenericMODLType.DES, agent)

# class ITN(GA_MODL):
#     def __init__(self, agent: Agent):
#         super().__init__(ActionMODLType.ITN, agent)

# class PITN(PGA_MODL):
#     def __init__(self, agent: Agent):
#         super().__init__(ActionMODLType.ITN, agent)

if __name__ == "__main__":
    # Example usage
    agent1 = Agent("alice", False)
    agent2 = Agent("bob", False)
    pred = Predicate("secret")

    BEL = NMODL(GenericMODLType.BEL, agent1)
    DES = LMODL(PossibleGenericMODLType.PDES, agent2)

    rml = BEL(DES(pred, True))
    print(rml)

    rml_negated = rml.negate()
    print(rml_negated)
    print(rml)