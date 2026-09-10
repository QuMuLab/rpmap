from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from pddl.logic.terms import Variable

def get_template_anceff():
    # create a generic AncEff object to test
    pos_var = Variable("pos")
    neg_var = Variable("neg")
    rml_term = RMLTerm()
    rml_term_negated = RMLTermNegated()
    return AncEff(
        name="some-anceff",
        parameters=None,
        antecedent=Antecedent(False, SeparatedRMLTerm(list(), rml_term), "add"),
        consequent=Consequent([Variable("pos")], [Variable("neg")], [SeparatedRMLTerm(list(), rml_term_negated)], "del")
    )