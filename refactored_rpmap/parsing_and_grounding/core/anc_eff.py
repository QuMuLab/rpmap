from __future__ import annotations
from enum import Enum
from lark.visitors import Transformer, Token
from pddl.core import Predicate
from pddl.exceptions import PDDLValidationError
from pddl.logic.base import Not
from pddl.logic.terms import Variable, Constant, Term
from pddl.parser.domain import DomainTransformer
from pddl.parser.problem import ProblemTransformer
import warnings
from ..utils import return_option, basic_tokens_transformer

# ----- CLASSES -----

class GenericMODLType(Enum):
    BEL = 1
    DES = 2
    # DSD = 3
    # LOV = 4

class PossibleGenericMODLType(Enum):
    PBEL = 1
    PDES = 2
    # PDSD = 3
    # PLOV = 4

class ActionMODLType(Enum):
    ITN = 1

class PossibleActionMODLType(Enum):
    PITN = 1

class AncEffType(Enum):
    ADD = 1
    DEL = 2

class Agent:
    def __init__(self, term: Term):
        if (isinstance(term, Constant) and term.type_tag != "agent") or (isinstance(term, Variable) and term.type_tags != frozenset(["agent"])):
            raise ValueError("The agent term must have `agent` as a type tag.")
        self._term = term

    @property
    def term(self) -> Term:
        return self._term

    def __eq__(self, other):
        return isinstance(other, Agent) and self.term == other.term
    
    def __hash__(self):
        return hash((Agent, self.term))
    
    def __repr__(self):
        return str(self.term)

class GeneralRML:
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent, child: GeneralRML | Predicate = None):
        if child:
            if (mod_type in ActionMODLType or mod_type in PossibleActionMODLType) and not isinstance(child, Predicate) and not isinstance(child, NOT_MODL):
                raise PDDLValidationError("Cannot apply an Action MODL to another MODL.")
        self._mod_type = mod_type
        self._agent = agent
        self._child = child

    @property
    def mod_type(self) ->  GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType:
        return self._mod_type

    @property
    def agent(self) -> Agent:
        return self._agent

    @property
    def child(self) -> GeneralRML | Predicate:
        return self._child

    @staticmethod
    def _get_counterpart_modl(mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType):
        if mod_type in GenericMODLType:
            return list(PossibleGenericMODLType)[list(GenericMODLType).index(mod_type)]
        elif mod_type in PossibleGenericMODLType:
            return list(GenericMODLType)[list(PossibleGenericMODLType).index(mod_type)]
        elif mod_type in ActionMODLType:
            return list(PossibleActionMODLType)[list(ActionMODLType).index(mod_type)]
        elif mod_type in PossibleActionMODLType:
            return list(ActionMODLType)[list(PossibleActionMODLType).index(mod_type)]
        else:
            raise PDDLValidationError(f"Unknown modl type {mod_type}")

    def _negate(self):
        return self.__class__(GeneralRML._get_counterpart_modl(self.mod_type), self.agent, self.child._negate()) if self.child else self.__class__(GeneralRML._get_counterpart_modl(self.mod_type), self.agent)

    def __str__(self):
        child_str = f"_{str(self.child)[1:-1]}" if self.child else ""
        return f"({self.mod_type.name}_{self.agent}{child_str})"

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

class Nesting(GeneralRML):
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent, child: GeneralRML | Predicate = None):
        super().__init__(mod_type, agent, child)

    def __call__(self, arg):
        if isinstance(arg, NOT_MODL):
            return Nesting(self.mod_type, self.agent, arg)
        elif isinstance(arg, BLANK_MODL):
            return Nesting(self.mod_type, self.agent, self.child)
        elif isinstance(arg, Predicate):
            if arg.always_known:
                warnings.warn(f"Nesting {self} being applied to a Predicate {arg} that is always known. Returning {arg}...", Warning)
                return arg
            return RML(self.mod_type, self.agent, arg)
        elif isinstance(arg, GeneralRML):
            if (arg.mod_type == self.mod_type or self.mod_type == Nesting._get_counterpart_modl(arg.mod_type)) and arg.agent == self.agent:
                return arg
            return arg.__class__(self.mod_type, self.agent, arg)
        else:
            raise PDDLValidationError(f"A Nesting can only be applied to another Nesting or an RML, not {type(arg)}.")

class RML(GeneralRML):
    def __init__(self, mod_type: GenericMODLType | PossibleGenericMODLType | ActionMODLType | PossibleActionMODLType, agent: Agent, child: RML | Predicate):
        super().__init__(mod_type, agent, child)
        self._check_terminal()

    def _get_root(self):
        current = self
        while isinstance(current.child, RML):
            current = current.child
        return current.child

    def _check_terminal(self):
        """check that the RML is "terminal" (ends in a Predicate)"""
        if not isinstance(self._get_root(), Predicate):
            raise PDDLValidationError("RML does not terminate with a Predicate.")


class BLANK_MODL:
    def __init__(self):
        pass

    def _negate(self):
        return NOT_MODL()

    def __eq__(self, other):
        return isinstance(other, NOT_MODL)

    def __hash__(self):
        return hash(NOT_MODL)

    def __repr__(self):
        return "BLANK_MODL"

class NOT_MODL:
    def __init__(self):
        self._mod_type = self

    @property
    def mod_type(self) -> NOT_MODL:
        return self

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

class RMLTermNegated(RMLOrPredTerm):
    def __repr__(self):
        return "!{rml}"

class PredTermNegated(RMLOrPredTerm):
    def __repr__(self):
        return "!{pred}"

class RTerm(RMLOrPredTerm):
    def __repr__(self):
        return "{r}"

class RTermNegated(RMLOrPredTerm):
    def __repr__(self):
        return "!{r}"

class NestingWildcardTerm:
    def __repr__(self):
        return "{nesting}"

    def __eq__(self, other):
        return isinstance(other, self.__class__)

    def __hash__(self):
        return hash(self.__class__)

class MODLTermWNesting:
    def __init__(self, modl: Nesting):
        if not isinstance(modl, Nesting):
            raise PDDLValidationError(f"Unknown type {type(modl)}")
        self._modl = modl

    @property
    def modl(self) -> Nesting:
        return self._modl

    def __eq__(self, other):
        return isinstance(other, self.__class__)

    def __hash__(self):
        return hash(self.__class__)

class LeadingNesting(MODLTermWNesting):
    def __init__(self, modl: Nesting):
        super().__init__(modl)

    def __repr__(self):
        return "{nesting}" + repr(self.modl)

class TrailingNesting(MODLTermWNesting):
    def __init__(self, modl: Nesting):
        super().__init__(modl)

    def __repr__(self):
        return repr(self.modl) + "{nesting}"

class LeadingTrailingNesting(MODLTermWNesting):
    def __init__(self, modl: Nesting):
        super().__init__(modl)

    def __repr__(self):
        return "{nesting}" + repr(self.modl) + "{nesting}"

def detect_var_pos_neg(var: Variable):
    if var not in [Variable("pos"), Variable("neg")]:
        raise PDDLValidationError("Only ?pos and ?neg can be referenced as variables in an ancillary effect list comprehension.")

class ListCompVar:
    def __init__(self, term: SeparatedRMLTerm, var: Variable):
        self._term = term
        detect_var_pos_neg(var)
        self._var = var

    @property
    def term(self) ->  SeparatedRMLTerm:
        return self._term

    @property
    def var(self) ->  Variable:
        return self._var

    def __eq__(self, other):
        return isinstance(other, ListCompVar) and self.term == other.term and self.var == other.var

    def __hash__(self):
        return hash((ListCompVar, self.term, self.var))

def detect_ag(term: SeparatedRMLTerm):
    for n in term.nestings:
        if isinstance(n, Nesting): # rule out NOT_MODL
            if n.agent.term == Variable("ag", ["agent"]):
                return
    raise PDDLValidationError(f"No ?ag agent detected in the agent list comprehension nestings.")

class ListCompAgents:
    def __init__(self, term: SeparatedRMLTerm):
        detect_ag(term)
        self._term = term

    @property
    def term(self) ->  SeparatedRMLTerm:
        return self._term

    def __eq__(self, other):
        return isinstance(other, ListCompAgents) and self.term == other.term

    def __hash__(self):
        return hash((ListCompVar, self.term))

class ListCompVarAgents:
    def __init__(self, term: SeparatedRMLTerm, var: Variable):
        detect_ag(term)
        self._term = term
        detect_var_pos_neg(var)
        self._var = var

    @property
    def term(self) ->  SeparatedRMLTerm:
        return self._term

    @property
    def var(self) ->  Variable:
        return self._var

    def __eq__(self, other):
        return isinstance(other, ListCompVarAgents) and self.term == other.term and self.var == other.var

    def __hash__(self):
        return hash((ListCompVarAgents, self.term, self.var))

class SeparatedRMLTerm:
    def __init__(self, nestings: list[Nesting | NOT_MODL | MODLTermWNesting], term: RMLOrPredTerm | Predicate):
        self._nestings = self.normal_form(nestings)
        if isinstance(term, Predicate) and term.negated:
            raise PDDLValidationError("Any negation in a `SeparatedRMLTerm` should be separated into `nestings`.")
        self._term = term

    @property
    def nestings(self) -> list[Nesting | NOT_MODL | MODLTermWNesting]:
        return self._nestings

    @property
    def term(self) -> RMLOrPredTerm | Predicate:
        return self._term

    @staticmethod
    def _get_as_list(term: Predicate | Nesting | RML | NOT_MODL):
        modl_list = []
        if isinstance(term, NOT_MODL) or isinstance(term, BLANK_MODL):
            pass
        elif isinstance(term, Predicate):
            modl_list.append(term)
        elif isinstance(term, Nesting) or isinstance(term, RML):
            if not term.child:
                modl_list.append(term)
            else:
                modl_list.append(term.__class__(term.mod_type, term.agent))
                modl_list.extend(SeparatedRMLTerm._get_as_list(term.child))
        else:
            raise ValueError(f"Unknown type {type(term)}.")
        return modl_list

    def normal_form(self, nestings):
        if nestings and len(nestings) >= 2 and MODLTermWNesting not in nestings:
            not_count = len([n for n in nestings if isinstance(n, NOT_MODL)])
            nesting_idxs = [i for i in range(len(nestings)) if isinstance(nestings[i], NestingWildcardTerm)]
            nestings = [n for n in nestings if not isinstance(n, NestingWildcardTerm)]
            for i in range(len(nestings) - 2, - 1, - 1):
                nestings[i] = nestings[i](nestings[i + 1])
            nestings = SeparatedRMLTerm._get_as_list(nestings[0])
            # add the nesting wildcard terms back in
            for i in nesting_idxs:
                nestings.insert(i, NestingWildcardTerm())
            # we have to manually add the NOT_MODL back because usually it will manifest by negating the final Predicate,
            # but we want to keep modalities (including negations) separate in this data structure.
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
    def __init__(self, poscond: list[Variable | ListCompAgents | ListCompVar | ListCompVarAgents | SeparatedRMLTerm | Not], negcond: list[Variable | ListCompAgents | ListCompVar | ListCompVarAgents | SeparatedRMLTerm | Not], rml: SeparatedRMLTerm | list[SeparatedRMLTerm | ListCompAgents | ListCompVar | ListCompVarAgents], anceff_type: AncEffType):
        self._poscond = poscond
        self._negcond = negcond
        self._rml = rml
        self._anceff_type = anceff_type

    @property
    def poscond(self) -> list[Variable | ListCompAgents | ListCompVar | ListCompVarAgents | SeparatedRMLTerm | Not]:
        return self._poscond

    @property
    def negcond(self) -> list[Variable | ListCompAgents | ListCompVar | ListCompVarAgents | SeparatedRMLTerm | Not]:
        return self._negcond

    @property
    def rml(self) -> SeparatedRMLTerm | list[SeparatedRMLTerm | ListCompAgents | ListCompVar | ListCompVarAgents]:
        return self._rml

    @property
    def anceff_type(self) -> AncEffType:
        return self._anceff_type
    
    def __eq__(self, other):
        return (isinstance(other, self.__class__) and
            self.poscond == other.poscond and
            self.negcond == other.negcond and
            self.rml == other.rml and
            self.anceff_type == other.anceff_type)
    
    def __hash__(self):
        return hash((self.poscond, self.negcond, self.rml, self.anceff_type))

class Consequent(AncEffPart):
    def __init__(self, poscond:  list[Variable | ListCompAgents | ListCompVar | ListCompVarAgents | SeparatedRMLTerm | Not], negcond:  list[Variable | ListCompAgents | ListCompVar | ListCompVarAgents | SeparatedRMLTerm | Not], rml: list[SeparatedRMLTerm | ListCompAgents | ListCompVar | ListCompVarAgents], anceff_type: AncEffType):
        super().__init__(poscond, negcond, rml, anceff_type)

class Antecedent(AncEffPart):
    def __init__(self, awareness: bool, rml: SeparatedRMLTerm, anceff_type: AncEffType):
        super().__init__([Variable("pos")], [Variable("neg")], rml, anceff_type)
        self._awareness = awareness

    @property
    def awareness(self) -> bool:
        return self._awareness

    def __eq__(self, other):
        return super().__eq__(other) and self.awareness == other.awareness

    def __hash__(self):
        return hash((self.poscond, self.negcond, self.rml, self.anceff_type, self.awareness))

class AncEff:
    def __init__(self, name: str, parameters: list[Variable], antecedent: Antecedent, consequent: Consequent):
        self._name = name
        self._parameters = parameters if parameters else list()
        ant_vars = AncEff._get_vars(antecedent.rml)
        cons_vars = set()
        if consequent.poscond:
            for r in consequent.poscond:
                cons_vars.update(AncEff._get_vars(r))
        if consequent.negcond:
            for r in consequent.negcond:
                cons_vars.update(AncEff._get_vars(r))
        for r in consequent.rml:
            cons_vars.update(AncEff._get_vars(r))
        vars_to_ignore = {Variable("ag", ["agent"]), Variable("dlr_agent", ["agent"])}    
        for a in ant_vars | cons_vars:
            if a in vars_to_ignore:
                continue
            if not self.parameters or a not in self.parameters:
                raise PDDLValidationError(f"Variable {a} not in the ancillary effect {self.name} parameters, {self.parameters}.")
        diff = cons_vars - ant_vars
        if diff != set() and diff not in [{a} for a in vars_to_ignore]:
            raise PDDLValidationError(f"The consequent in the ancillary effect {name} contains variables {diff} not referenced in the antecedent.")
        ant_terms_w_nesting_types = {type(term) for term in antecedent.rml.nestings if isinstance(term, MODLTermWNesting)}
        cons_terms_w_nesting_types = {type(term) for rml in consequent.rml if isinstance(rml, SeparatedRMLTerm) for term in rml.nestings if isinstance(term, MODLTermWNesting)}
        if ant_terms_w_nesting_types != cons_terms_w_nesting_types:
            raise PDDLValidationError(f"The antecedent and consequent of the {self.name} ancillary effect feature different" + "{nesting} term types.")
        self._antecedent = antecedent
        self._consequent = consequent
        self._agents = {a for a in ant_vars | cons_vars if "agent" in a.type_tags}

    @property
    def name(self) -> str:
        return self._name

    @property
    def parameters(self) -> list[Variable]:
        return self._parameters

    @property
    def antecedent(self) -> Antecedent:
        return self._antecedent

    @property
    def consequent(self) -> Consequent:
        return self._consequent

    @property
    def agents(self) -> set[Agent]:
        return self._agents

    @staticmethod
    def _get_vars(rml: SeparatedRMLTerm | MODLTermWNesting | Nesting | NOT_MODL):
        variables = set()
        if isinstance(rml, NOT_MODL) or isinstance(rml, Variable):
            return variables
        elif isinstance(rml, MODLTermWNesting):
            variables.add(rml.modl.agent.term)
        elif isinstance(rml, Nesting):
            variables.add(rml.agent.term)
        elif isinstance(rml, ListCompVar):
            for n in rml.term.nestings:
                variables.update(AncEff._get_vars(n))
        elif isinstance(rml, ListCompAgents) or isinstance(rml, ListCompVarAgents):
            for n in rml.term.nestings:
                variables.update(AncEff._get_vars(n))
        elif isinstance(rml, SeparatedRMLTerm):
            for n in rml.nestings:
                variables.update(AncEff._get_vars(n))
            if isinstance(rml.term, Predicate):
                variables.update(rml.term.terms)
        elif isinstance(rml, Not):
            variables.update(AncEff._get_vars(rml.argument))
        else:
            raise ValueError(f"Unexpected type {type(rml)}.")
        return variables
                
    def __eq__(self, other):
        return (isinstance(other, AncEff) and 
                other.name == self.name and
                other.parameters == self.parameters and
                other.antecedent == self.antecedent and
                other.consequent == self.consequent
        )
    
    def __hash__(self):
        return hash((self.name, self.parameters, self.antecedent, self.consequent))

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

def atomic_formula_term_anceff(self, args):
    nestings = []
    term = None
    for a in args[:-1]:
        if isinstance(a, list):
            nestings.extend(a)
        elif isinstance(a, MODLTermWNesting):
            nestings.append(a)
            break
        else:
            raise ValueError(f"Unknown type {type(a)}.")
    if isinstance(args[-1], RMLOrPredTerm):
        term = args[-1]
    else:
        raise ValueError(f"Unknown type {type(args[-1])}.")
    return SeparatedRMLTerm(nestings, term)

def get_constants(transformer_class, args):
    if isinstance(transformer_class, DomainTransformer):
        constants = transformer_class._constants_by_name | transformer_class.agents
    elif isinstance(transformer_class, ProblemTransformer):
        constants = transformer_class._objects_by_name | transformer_class._domain_transformer._constants_by_name | transformer_class._domain_transformer.agents
    elif isinstance(transformer_class, AncEffTransformer):
        constants = transformer_class._domain_transformer._constants_by_name | transformer_class._domain_transformer.agents
    else:
        raise PDDLValidationError(f"Unknown transformer received: {transformer_class}")
    obj = args[0].value
    if obj not in constants:
        raise PDDLValidationError(f"Constant object {obj} not defined.")
    return constants[obj]

def var(self, args):
    return Variable(args[1].value)

def modls(self, args):
    if len(args) > 0:
        modl_terms = []
        for a in args:
            modl_terms.extend(a)
        return modl_terms
    else:
        return list()

def plural_modl_check(args):
    if len(args) != 1:
        raise PDDLValidationError("Only a single MODL is allowed when {nesting} terms are used.")

def modls_trailing_nesting(self, args):
    plural_modl_check(args[0])
    return TrailingNesting(args[0][0])

def modls_leading_nesting(self, args):
    plural_modl_check(args[1])
    return LeadingNesting(args[1][0])

def modls_leading_trailing_nesting(self, args):
    plural_modl_check(args[1])
    return LeadingTrailingNesting(args[1][0])

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
                if args[4].name not in self._domain_transformer.agents:
                    raise PDDLValidationError(f"Unknown agent {args[4].name} referenced.")
                args[4] = Constant(args[4].name, "agent")
            else:
                args[4]._type_tags = frozenset(["agent"])
            modls = [NOT_MODL()] if args[0] else []
            modls.append(Nesting(modl_type[term_name], Agent(args[4])))
            return modls
    raise PDDLValidationError(f"MODL Type {term_name} is not specified in any of the MODLType categories in 'anc_eff.py.'")

def rml_term(self, args):
    if args[0] is not None:
        return RMLTermNegated()
    return RMLTerm()

def rml_term_no_neg(self, args):
    return RMLTerm()

def pred_term(self, args):
    if args[0] is not None:
        return PredTermNegated()
    return PredTerm()

def pred_term_no_neg(self, args):
    return PredTerm()

def r_term(self, args):
    if args[0] is not None:
        return RTermNegated()
    return RTerm()

def return_all(self, args):
    return args

def anceffs(self, args):
    return args[2:-1]

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

def list_comp_var_agents(self, args):
    return ListCompVarAgents(args[1], args[5])

def plural(self, args):
    return [a for a in args if a != Token("PLUS", "+")]

def rml_plural(self, args):
    return self.pos_or_neg_cond(args[1:])

def cond_type_def(self, args):
    return args[1].children[0].value

def return_second(self, args):
    return args[1]

def return_wildcard_nesting(self, args):
    return NestingWildcardTerm()

def pos_or_neg_var(self, args):
    return Variable(args.value[1:])

def not_derived_atomic_formula_term(self, args):
    return Not(args[2])

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
        setattr(AncEffTransformer, "atomic_formula_term_r", atomic_formula_term)
        setattr(AncEffTransformer, "atomic_formula_term_nesting_term", atomic_formula_term_anceff)
        setattr(AncEffTransformer, "atomic_formula_term_anceff", return_option)
        setattr(AncEffTransformer, "not_derived_atomic_formula_term", not_derived_atomic_formula_term)
        setattr(AncEffTransformer, "r_term", r_term)
        setattr(AncEffTransformer, "rml_term", rml_term)
        setattr(AncEffTransformer, "pred_term", pred_term)
        setattr(AncEffTransformer, "rml_term_no_neg", rml_term_no_neg)
        setattr(AncEffTransformer, "pred_term_no_neg", pred_term_no_neg)
        setattr(AncEffTransformer, "terminal_rml_or_pred_no_neg", return_option)
        setattr(AncEffTransformer, "terminal_rml_or_pred", return_option)
        setattr(AncEffTransformer, "modl", modl)
        setattr(AncEffTransformer, "var", var)
        setattr(AncEffTransformer, "anceff_params", return_second)
        setattr(AncEffTransformer, "nesting_term", return_wildcard_nesting)
        setattr(AncEffTransformer, "modls_trailing_nesting", modls_trailing_nesting)
        setattr(AncEffTransformer, "modls_leading_nesting", modls_leading_nesting)
        setattr(AncEffTransformer, "modls_leading_trailing_nesting", modls_leading_trailing_nesting)
        setattr(AncEffTransformer, "modls", modls)
        setattr(AncEffTransformer, "all_modl_nesting_options", return_option)
        setattr(AncEffTransformer, "modl_with_wildcard_nesting", return_option)
        setattr(AncEffTransformer, "list_comp_rml_var", list_comp_var)
        setattr(AncEffTransformer, "list_comp_rml_agents", list_comp_agents)
        setattr(AncEffTransformer, "list_comp_rml_var_agents", list_comp_var_agents)
        setattr(AncEffTransformer, "antecedent", antecedent)
        setattr(AncEffTransformer, "consequent", consequent)
        setattr(AncEffTransformer, "rml_options", return_option)
        setattr(AncEffTransformer, "rml_cons_def", rml_plural)
        setattr(AncEffTransformer, "rml_ant_def", return_second)
        setattr(AncEffTransformer, "cond_type_def", cond_type_def)
        setattr(AncEffTransformer, "pos_or_neg_cond_options", return_option)
        setattr(AncEffTransformer, "pos_or_neg_cond", plural)
        setattr(AncEffTransformer, "pos_or_neg_term", return_option)
        setattr(AncEffTransformer, "POS", pos_or_neg_var)
        setattr(AncEffTransformer, "NEG", pos_or_neg_var)
        setattr(AncEffTransformer, "anceff", anceff)
        setattr(AncEffTransformer, "anceffs", anceffs)
        setattr(AncEffTransformer, "all_anceffs", return_all)
