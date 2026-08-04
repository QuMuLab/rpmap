from .parsing_utils import create_valuations
from pddl.logic.predicates import Predicate
from pddl.logic.terms import Constant

def create_fluents(domain, problem):
    """Create the set of fluents by grounding the predicates.
    Adapted from the pdkb.pddl.grounder.GroundProblem._create_fluents method."""
    fluents = set([])
    for p in domain.predicates:
        val_generator = create_valuations(domain._agents, problem.objects, p.terms)
        for valuation in val_generator:
            grounded_p = Predicate(p.name, *(Constant(c) for c in valuation))
            grounded_p.negated = p.negated
            grounded_p.always_known = p.always_known
            fluents.add(grounded_p)
    return fluents

def ground(domain, problem, grounded_dom_path):
    fluents = create_fluents(domain, problem)
    return domain, problem