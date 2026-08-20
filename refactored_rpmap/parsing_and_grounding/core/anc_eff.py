from __future__ import annotations
from enum import Enum
from lark.visitors import Transformer, Token
from pddl.core import Predicate
from pddl.exceptions import PDDLValidationError
from pddl.logic.terms import Variable, Constant, Term
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
from copy import deepcopy
from ..utils import return_option

# ----- CLASSES -----

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
    def __init__(self, term: Term):
        if term.type_tags != frozenset(["agent"]):
            raise ValueError("The agent term must have `agent` as a type tag.")
        self.term = term

    def __eq__(self, other):
        return isinstance(other, Agent) and self.term == other.term
    
    def __hash__(self):
        return hash((Agent, self.term))
    
    def __repr__(self):
        return str(self.term)

class GeneralRML:
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent):
        self.mod_type = mod_type
        self.agent = agent
        self.child: GeneralRML | Predicate = None

    def __str__(self):
        child = f"_{str(self.child)[1:-1]}" if self.child else ""
        return f"({self.mod_type.name}_{self.agent}{child})"

    def __repr__(self):
        child = repr(self.child) if self.child else ""
        return f"[{self.mod_type.name}, {self.agent}]{child}" if self.mod_type in GenericMODLType or self.mod_type in ActionMODLType else f"<{self.mod_type.name[1:]}, {self.agent}>{child}"

    def __eq__(self, other):
        return (
            isinstance(other, self.__class__)
            and self.mod_type == other.mod_type
            and self.agent == other.agent
            and self.child == other.child
        )

    def __hash__(self):
        return hash((self.__class__, self.mod_type, self.agent, self.child))

    def set_child(self, arg):
        if arg:
            if (self.mod_type in ActionMODLType or self.mod_type in PossibleActionMODLType) and not isinstance(arg, Predicate):
                raise PDDLValidationError("Cannot apply an Action MODL to another MODL.")
        self.child = arg

class Nesting(GeneralRML):
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent):
        super().__init__(mod_type, agent)
        self.child: Nesting | RML | Predicate

    def __call__(self, arg):
        if isinstance(arg, Nesting):
            new_base = deepcopy(self)
            new_base.set_child(deepcopy(arg))
            return new_base
        elif isinstance(arg, RML) or isinstance(arg, Predicate):
            return RML(self.mod_type, self.agent, deepcopy(arg))
        else:
            raise PDDLValidationError(f"A Nesting can only be applied to another Nesting or an RML, not {type(arg)}.")

    def _negate(self):
        if self.mod_type in GenericMODLType:
            new_base = Nesting(list(PossibleGenericMODLType)[list(GenericMODLType).index(self.mod_type)], self.agent)
        elif self.mod_type in PossibleGenericMODLType:
            new_base = Nesting(list(GenericMODLType)[list(PossibleGenericMODLType).index(self.mod_type)], self.agent)
        elif self.mod_type in ActionMODLType:
            new_base = Nesting(list(PossibleActionMODLType)[list(ActionMODLType).index(self.mod_type)], self.agent)
        else:
            new_base = Nesting(list(ActionMODLType)[list(PossibleActionMODLType).index(self.mod_type)], self.agent)
        if self.child:
            return new_base(self.child._negate())
        return new_base

class RML(GeneralRML):
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent, child: RML | Predicate):
        super().__init__(mod_type, agent)
        self.set_child(child)
        self._check_terminal()

    def _get_predicate(self):
        current = deepcopy(self)
        while isinstance(current.child, RML):
            current = deepcopy(current.child)
        return deepcopy(current.child)

    def _check_terminal(self):
        # check that the RML is "terminal" (ends in a Predicate)
        current = deepcopy(self)
        while isinstance(current.child, RML):
            current = deepcopy(current.child)
        if not isinstance(current.child, Predicate):
            raise PDDLValidationError("RML does not terminate with a Predicate.")

    def _negate(self):
        if self.mod_type in GenericMODLType:
            return RML(list(PossibleGenericMODLType)[list(GenericMODLType).index(self.mod_type)], self.agent, self.child._negate())
        elif self.mod_type in PossibleGenericMODLType:
            return RML(list(GenericMODLType)[list(PossibleGenericMODLType).index(self.mod_type)], self.agent, self.child._negate())
        elif self.mod_type in ActionMODLType:
            return RML(list(PossibleActionMODLType)[list(ActionMODLType).index(self.mod_type)], self.agent, self.child._negate())
        else:
            return RML(list(ActionMODLType)[list(PossibleActionMODLType).index(self.mod_type)], self.agent, self.child._negate())

class NOT_MODL:
    def __init__(self):
        pass

    def __call__(self, arg):
        return arg._negate()

class RMLPredicate(Predicate):
    def __init__(self, name):
        super().__init__(name)
        self.nest = False

class ListCompVar:
    def __init__(self, term: RMLPredicate | RML, var: Variable):
        self.term = term
        self.var = Variable

class ListCompAgents:
    def __init__(self, term: RMLPredicate | RML):
        self.term = term

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

# ----- TRANSFORMER FUNCTIONS -----

def atomic_formula_term(self, args):
    negate_modalities = True if args[0] else False
    modls_no_neg = args[1:]
    for i in range(len(modls_no_neg) - 1, - 1, - 1):
        if isinstance(modls_no_neg[i], Predicate):
            continue
        modls_no_neg[i] = modls_no_neg[i](modls_no_neg[i + 1])
    modl = modls_no_neg[0]
    return NOT_MODL()(modl) if negate_modalities else modl

def get_constants(transformer_class, args):
    if isinstance(transformer_class, DomainTransformer):
        constants = transformer_class._constants_by_name | transformer_class._agents
    elif isinstance(transformer_class, ProblemTransformer):
        constants = transformer_class._objects_by_name | transformer_class._domain_transformer._constants_by_name | transformer_class._domain_transformer._agents
    elif isinstance(transformer_class, AncEffTransformer):
        constants = transformer_class._domain_transformer._constants_by_name | transformer_class._domain_transformer._agents
    else:
        raise PDDLValidationError(f"Unknown transformer received: {transformer_class}")
    obj = args[0].value
    if obj not in constants:
        raise PDDLValidationError(f"Constant object {obj} not defined.")
    return constants[obj]

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
            if isinstance(args[3], Constant):
                if args[3].name not in self._domain_transformer._agents:
                    raise PDDLValidationError(f"Unknown agent {args[3].name} referenced.")
                args[3]._type_tag = "agent"
                return Nesting(modl_type[term_name], Agent(args[3]))
            else:
                args[3]._type_tags = frozenset(["agent"])
                return Nesting(modl_type[term_name], Agent(args[3]))
    raise PDDLValidationError(f"MODL Type {term_name} is not specified in any of the MODLType categories in 'anc_eff.py.'")

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

def plural(self, args):
    return [a for a in args[1:] if a != Token("PLUS", "+")]

def cond_type_def(self, args):
    return args[1].children[0].value

# ----- ANCILLARY EFFECT TRANSFORMER -----

class AncEffTransformer(Transformer):
    def __init__(self, domain_transformer):
        """Initialize the AncEffTransformer."""
        super().__init__()
        self._domain_transformer = domain_transformer
        self.set_up_transformers()

    def start(self, children):
        """Start method for the AncEffTransformer."""
        return children

    def set_up_transformers(self):
        setattr(AncEffTransformer, "atomic_formula_term_rml", atomic_formula_term)
        setattr(AncEffTransformer, "terminal_rml", terminal_rml)
        setattr(AncEffTransformer, "terminal_r", terminal_r)
        setattr(AncEffTransformer, "modl", modl)
        setattr(AncEffTransformer, "var", var)
        setattr(AncEffTransformer, "atomic_formula_term_list_comp_r", atomic_formula_term)
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

# if __name__ == "__main__":
#     bel = Nesting(GenericMODLType.BEL, Agent("alice", var=False))
#     des = Nesting(GenericMODLType.DES, Agent("bob", var=False))
#     pred = Predicate("secret")

#     nesting = bel(des)
#     rml = bel(des(pred))
#     nested_2 = nesting(rml)
#     negated = NOT_MODL()(nesting)
#     negated_2 = NOT_MODL()(rml)

#     print(nesting, type(nesting))
#     print(rml, type(rml))
#     print(nested_2, type(nested_2))
#     print(nested_2._get_predicate(), type(nested_2._get_predicate()))

#     print(negated, type(negated))
#     print(negated_2, type(negated_2))