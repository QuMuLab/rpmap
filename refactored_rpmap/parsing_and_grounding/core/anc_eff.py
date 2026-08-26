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
        if (isinstance(term, Constant) and term.type_tag != "agent") or (isinstance(term, Variable) and term.type_tags != frozenset(["agent"])):
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
        if isinstance(arg, Nesting) or isinstance(arg, NOT_MODL):
            new_base = deepcopy(self)
            new_base.set_child(deepcopy(arg))
            return new_base
        elif isinstance(arg, RML) or isinstance(arg, Predicate):
            return RML(self.mod_type, self.agent, deepcopy(arg))
        elif isinstance(arg, BLANK_MODL):
            return deepcopy(self)
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

class BLANK_MODL:
    def __init__(self):
        pass

    def __eq__(self, other):
        return isinstance(other, NOT_MODL)

    def __hash__(self):
        return hash(NOT_MODL)

    def __repr__(self):
        return "BLANK_MODL"

class NOT_MODL:
    def __init__(self):
        pass

    def _negate(self):
        return BLANK_MODL()

    def __call__(self, arg):
        return arg._negate()

    def __eq__(self, other):
        return isinstance(other, NOT_MODL)

    def __hash__(self):
        return hash(NOT_MODL)

    def __repr__(self):
        return "NOT_MODL"

class RMLOrPredTerm:
    def __init__(self):
        pass

    def __eq__(self, other):
        return isinstance(other, self.__class__)

    def __hash__(self):
        return hash(self.__class__)

class RMLTerm(RMLOrPredTerm):
    def __repr__(self):
        return "{rml}"

class PredTerm(RMLOrPredTerm):
    def __repr__(self):
        return "{pred}"

class RMLorPredTermNegated(RMLOrPredTerm):
    def __init__(self):
        pass

class RMLTermNegated(RMLTerm):
    def __repr__(self):
        return "!{rml}"

class PredTermNegated(PredTerm):
    def __repr__(self):
        return "!{pred}"

class NestedRMLorPredTerm(RMLOrPredTerm):
    def __init__(self, child: RMLTerm | RMLTermNegated | PredTerm | PredTermNegated):
        self.child = child

    def __repr__(self):
        return f"[{self.child}]"

    def __eq__(self, other):
        return isinstance(other, self.__class__) and self.child == other.child

class NestedRMLTerm(NestedRMLorPredTerm):
    def __init__(self, child: RMLTerm | RMLTermNegated):
        super().__init__(child)

class NestedPredTerm(NestedRMLorPredTerm):
    def __init__(self, child: PredTerm | PredTermNegated):
        super().__init__(child)

class ListCompVar:
    def __init__(self, term: RMLOrPredTerm | RML, var: Variable):
        self.term = term
        self.var = var

    def __eq__(self, other):
        return isinstance(other, ListCompVar) and self.term == other.term and self.var == other.var

    def __hash__(self):
        return hash((ListCompVar, self.term, self.var))

class ListCompAgents:
    def __init__(self, term: RMLOrPredTerm | RML):
        self.term = term

    def __eq__(self, other):
        return isinstance(other, ListCompAgents) and self.term == other.term

    def __hash__(self):
        return hash((ListCompVar, self.term))


class SeparatedRMLTerm:
    def __init__(self, nestings: list[Nesting | NOT_MODL], rml_or_pred_term: RMLOrPredTerm | Predicate):
        self.nestings = self.normal_form(nestings)
        if isinstance(rml_or_pred_term, Predicate) and rml_or_pred_term.negated:
            raise PDDLValidationError("Any negation in a `SeparatedRMLTerm` should be separated into `nestings`.")
        self.term = rml_or_pred_term

    @staticmethod
    def _get_as_list(term: Predicate | Nesting | RML | NOT_MODL):
        modl_list = []
        if isinstance(term, NOT_MODL) or isinstance(term, BLANK_MODL):
            pass
        elif isinstance(term, Predicate):
            modl_list.append(deepcopy(term))
        elif isinstance(term, Nesting) or isinstance(term, RML):
            if not term.child:
                modl_list.append(deepcopy(term))
            else:
                base = deepcopy(term)
                base.child = None
                modl_list.append(base)
                modl_list.extend(deepcopy(SeparatedRMLTerm._get_as_list(term.child)))
        else:
            raise ValueError(f"Unknown type {type(term)}.")
        return modl_list

    def normal_form(self, nestings):
        if nestings and len(nestings) >= 2:
            not_count = len([n for n in nestings if isinstance(n, NOT_MODL)])
            for i in range(len(nestings) - 2, - 1, - 1):
                nestings[i] = nestings[i](nestings[i + 1])
            nestings = SeparatedRMLTerm._get_as_list(nestings[0])
            if not_count % 2 != 0:
                nestings.append(NOT_MODL()) 
        return nestings

    def __eq__(self, other):
        return isinstance(other, SeparatedRMLTerm) and self.nestings == other.nestings and self.term == other.term

    def __hash__(self):
        return hash((tuple(self.nestings), self.term))

    def __repr__(self):
        return f"{self.nestings} >> {self.term}"

class AncEffPart:
    def __init__(self, poscond: list, negcond: list, rml: list[RML | Nesting | Predicate], anceff_type: str):
        self.poscond = poscond
        self.negcond = negcond
        self.rml = rml
        self.anceff_type = anceff_type
    
    def __eq__(self, other):
        return (isinstance(other, self.__class__) and
            self.poscond == other.poscond and
            self.negcond == other.negcond and
            self.rml == other.rml and
            self.anceff_type == other.anceff_type)
    
    def __hash__(self):
        return hash((self.poscond, self.negcond, self.rml, self.anceff_type))

class Consequent(AncEffPart):
    def __init__(self, poscond: list, negcond: list, rml: list[RML | Nesting | Predicate], anceff_type: str):
        super().__init__(poscond, negcond, rml, anceff_type)

class Antecedent(AncEffPart):
    def __init__(self, awareness: bool, rml: list[RML | SeparatedRMLTerm | Predicate], anceff_type: str):
        super().__init__([Variable("pos")], [Variable("neg")], rml, anceff_type)
        self.awareness = awareness

    def __eq__(self, other):
        return super().__eq__(other) and self.awareness == other.awareness

    def __hash__(self):
        return hash((self.poscond, self.negcond, self.rml, self.anceff_type, self.awareness))

class AncEff:
    def __init__(self, name: str, parameters: list[Variable], antecedent: Antecedent, consequent: Consequent):
        self.name = name
        self.parameters = parameters
        self.antecedent = antecedent
        self.consequent = consequent

    def __eq__(self, other):
        return (isinstance(other, AncEff) and 
                other.name == self.name and
                other.parameters == self.parameters and
                other.antecedent == self.antecedent and
                other.consequent == self.consequent
        )
    
    def __hash__(self):
        return hash((self.name, self.parameters, self.antecedent, self.consequent))

class AncEffs:
    def __init__(self, anceffs):
        self.anceffs = anceffs

# ----- TRANSFORMER FUNCTIONS -----

def atomic_formula_term(self, args):
    all_nestings = []
    term = None
    for a in args[:-1]:
        if isinstance(a, list):
            all_nestings.extend(a)
        else:
            raise ValueError(f"Unknown type {type(a)}.")
    if isinstance(args[-1], SeparatedRMLTerm):
        all_nestings.extend(args[-1].nestings)
        term = args[-1].term
    elif isinstance(args[-1], RMLOrPredTerm):
        term = args[-1]
    else:
        raise ValueError(f"Unknown type {type(args[-1])}.")
    return SeparatedRMLTerm(all_nestings, term)

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
    if args[1].type == "LSQB":
        possible_classes = [GenericMODLType, ActionMODLType]
    else:
        hard_modality = False
        possible_classes = [PossibleGenericMODLType, PossibleActionMODLType]
    term_name = args[2].children[0].upper()
    if not hard_modality:
        term_name = "P" + term_name
    for modl_type in possible_classes:
        if term_name in [m.name for m in modl_type]:
            if isinstance(args[4], Constant):
                if args[4].name not in self._domain_transformer._agents:
                    raise PDDLValidationError(f"Unknown agent {args[4].name} referenced.")
                args[4] = Constant(args[4].name, "agent")
            else:
                args[4]._type_tags = frozenset(["agent"])
            modl = [NOT_MODL()] if args[0] else []
            modl.append(Nesting(modl_type[term_name], Agent(args[4])))
            return modl
    raise PDDLValidationError(f"MODL Type {term_name} is not specified in any of the MODLType categories in 'anc_eff.py.'")

def rml_term(self, args):
    if args[0] is not None:
        return RMLTermNegated()
    return RMLTerm()

def pred_term(self, args):
    if args[0] is not None:
        return PredTermNegated()
    return PredTerm()

def rml_or_pred_nested(self, args):
    negated = args[0] is not None
    if isinstance(args[2], RMLTerm):
        if negated:
            return SeparatedRMLTerm([NOT_MODL()], NestedRMLTerm(args[2]))
        return NestedRMLTerm(args[2])
    elif isinstance(args[2], PredTerm):
        if negated:
            return SeparatedRMLTerm([NOT_MODL()], NestedPredTerm(args[2]))
        return NestedPredTerm(args[2])
    else:
        raise ValueError(f"Unknown type {type(args[2])}.")

def return_all(self, args):
    return args

def anceffs(self, args):
    return AncEffs(args[2:-1])

def anceff(self, args):
    return AncEff(args[2].value, args[3], args[4], args[5])

def antecedent(self, args):
    args[4] = args[4].children[1].value == 'true' if args[4] else False
    return Antecedent(args[4], args[5], args[6])

def consequent(self, args):
    return Consequent(args[2].children[1] if args[2] else None, args[3].children[1] if args[3] else None, args[4], args[5])

def list_comp_var(self, args):
    return ListCompVar(args[1], args[5])

def list_comp_agents(self, args):
    return ListCompAgents(args[1])

def plural(self, args):
    return [a for a in args if a != Token("PLUS", "+")]

def rml_plural(self, args):
    return self.pos_or_neg_cond(args[1:])

def cond_type_def(self, args):
    return args[1].children[0].value

def anceff_params(self, args):
    return args[1]

def pos_or_neg_var(self, args):
    return Variable(args.value[1:])

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
        setattr(AncEffTransformer, "rml_term", rml_term)
        setattr(AncEffTransformer, "pred_term", pred_term)
        setattr(AncEffTransformer, "rml_or_pred_term", return_option)
        setattr(AncEffTransformer, "terminal_rml_or_pred", return_option)
        setattr(AncEffTransformer, "terminal_rml_nested", rml_or_pred_nested)
        setattr(AncEffTransformer, "terminal_pred_nested", rml_or_pred_nested)
        setattr(AncEffTransformer, "modl", modl)
        setattr(AncEffTransformer, "var", var)
        setattr(AncEffTransformer, "anceff_params", anceff_params)
        setattr(AncEffTransformer, "list_comp_r_var", list_comp_var)
        setattr(AncEffTransformer, "list_comp_rml_var", list_comp_var)
        setattr(AncEffTransformer, "list_comp_r_agents", list_comp_agents)
        setattr(AncEffTransformer, "list_comp_rml_agents", list_comp_agents)
        setattr(AncEffTransformer, "antecedent", antecedent)
        setattr(AncEffTransformer, "consequent", consequent)
        setattr(AncEffTransformer, "rml_options", return_option)
        setattr(AncEffTransformer, "atomic_formula_term_antecedent", atomic_formula_term)
        setattr(AncEffTransformer, "rml_cons_def", rml_plural)
        setattr(AncEffTransformer, "rml_ant_def", rml_plural)
        setattr(AncEffTransformer, "cond_type_def", cond_type_def)
        setattr(AncEffTransformer, "pos_or_neg_cond_options", return_option)
        setattr(AncEffTransformer, "pos_or_neg_cond", plural)
        setattr(AncEffTransformer, "pos_or_neg_term", return_option)
        setattr(AncEffTransformer, "POS", pos_or_neg_var)
        setattr(AncEffTransformer, "NEG", pos_or_neg_var)
        setattr(AncEffTransformer, "anceff", anceff)
        setattr(AncEffTransformer, "anceffs", anceffs)
        setattr(AncEffTransformer, "all_anceffs", return_all)
