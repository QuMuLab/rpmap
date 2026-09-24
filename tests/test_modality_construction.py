from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.utils import cleaned_not
import pytest


class TestModalityConstruction:
    def get_vars(self):
        agent1 = Agent(Constant("alice", "agent"))
        agent2 = Agent(Constant("bob", "agent"))
        agent3 = Agent(Constant("cindy", "agent"))
        BEL = Nesting(GenericMODLType.BEL, agent1)
        DES = Nesting(GenericMODLType.DES, agent2)
        ITN = Nesting(ActionMODLType.ITN, agent3)
        PBEL = Nesting(PossibleGenericMODLType.PBEL, agent1)
        PDES = Nesting(PossibleGenericMODLType.PDES, agent2)
        PITN = Nesting(PossibleActionMODLType.PITN, agent3)
        NOT = NOT_MODL()
        pred = Predicate("secret")
        pred_negated = Predicate("secret", negated=True)
        pred_always_known = Predicate("secret", always_known=True)
        return BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred, pred_always_known, pred_negated

    def test_basic_modls(self):
        BEL, DES, ITN, _, _, _, _, pred, _, _ = self.get_vars()
        assert repr(BEL(pred)) == "[BEL, alice](secret)"
        assert repr(DES(pred)) == "[DES, bob](secret)"
        assert repr(ITN(pred)) == "[ITN, cindy](secret)"

    def test_basic_modl_squashing(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred, _, _ = self.get_vars()
        assert repr(BEL(BEL(pred))) == "[BEL, alice](secret)"
        assert repr(DES(DES(pred))) == "[DES, bob](secret)"
        assert repr(ITN(ITN(pred))) == "[ITN, cindy](secret)"
        assert repr(BEL(PBEL(pred))) == "<BEL, alice>(secret)"
        assert repr(DES(PDES(pred))) == "<DES, bob>(secret)"
        assert repr(ITN(PITN(pred))) == "<ITN, cindy>(secret)"
        assert repr(PBEL(BEL(pred))) == "[BEL, alice](secret)"
        assert repr(PDES(DES(pred))) == "[DES, bob](secret)"
        assert repr(PITN(ITN(pred))) == "[ITN, cindy](secret)"

    def test_always_known(self):
        BEL, DES, ITN, _, _, _, NOT, _, pred_always_known, _ = self.get_vars()
        with pytest.warns(Warning):
            NOT(pred_always_known)
        with pytest.warns(Warning):
            NOT(BEL(pred_always_known))
        with pytest.raises(PDDLValidationError):
            BEL(NOT(pred_always_known))
        with pytest.warns(Warning):
            NOT(NOT(NOT(pred_always_known)))
        with pytest.raises(PDDLValidationError):
            NOT(BEL(NOT(DES(NOT(ITN(pred_always_known))))))

    def test_not(self):
        BEL, DES, ITN, _, _, _, NOT, pred, _, _ = self.get_vars()
        assert repr(NOT(pred)) == "(!secret)"
        assert repr(cleaned_not(pred)) == "(not (secret))"
        assert repr(cleaned_not(BEL(pred))) == "(not [BEL, alice](secret))"
        assert repr(cleaned_not(NOT(BEL(pred)))) == "(not <BEL, alice>(!secret))"
        assert repr(NOT(cleaned_not(BEL(pred)))) == "[BEL, alice](secret)"

    def test_not_on_always_known(self):
        BEL, DES, ITN, _, _, _, NOT, pred, _, _ = self.get_vars()
        p = Predicate("secret", always_known=True)
        assert repr(NOT(p)) == "(not (secret))"
        assert repr(cleaned_not(p)) == "(not (secret))"
        assert repr(NOT(BEL(p))) == "(not (secret))"
        assert repr(cleaned_not(NOT(BEL(p)))) == "(secret)"
        assert repr(NOT(cleaned_not(BEL(p)))) == "(secret)"


    def test_rml_vs_nesting_formation(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred, _, _ = self.get_vars()
        assert isinstance(BEL, Nesting)
        assert repr(BEL) == "[BEL, alice]"
        assert isinstance(BEL(DES), Nesting)
        assert repr(BEL(ITN)) == "[BEL, alice][ITN, cindy]"
        assert isinstance(BEL(NOT(DES)), Nesting)
        assert repr(BEL(NOT(DES))) == "[BEL, alice]<DES, bob>"
        assert repr(NOT(BEL(DES))) == "<BEL, alice><DES, bob>"
        assert repr(NOT(PDES(PITN))) == "[DES, bob][ITN, cindy]"
        assert isinstance(BEL(pred), RML)
        assert isinstance(BEL(DES(pred)), RML)
        with pytest.raises(TypeError):
            BEL(pred)(pred)
        with pytest.raises(TypeError):
            BEL(DES(pred))(pred)
        with pytest.raises(PDDLValidationError):
            RML(GenericMODLType.BEL, BEL.agent, None)
        with pytest.raises(PDDLValidationError):
            ITN(BEL)
        with pytest.raises(PDDLValidationError):
            ITN(BEL(pred))

    def test_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, _, pred, _, _ = self.get_vars()
        assert repr(BEL(BEL(pred))) == "[BEL, alice](secret)"
        assert repr(BEL(DES(pred))) == "[BEL, alice][DES, bob](secret)"
        assert repr(BEL(ITN(pred))) == "[BEL, alice][ITN, cindy](secret)"

        assert repr(DES(BEL(pred))) == "[DES, bob][BEL, alice](secret)"
        assert repr(DES(DES(pred))) == "[DES, bob](secret)"
        assert repr(DES(ITN(pred))) == "[DES, bob][ITN, cindy](secret)"

    def test_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, _ , pred, _, _ = self.get_vars()

        assert repr(BEL(BEL(BEL(pred)))) == "[BEL, alice](secret)"
        assert repr(BEL(BEL(DES(pred)))) == "[BEL, alice][DES, bob](secret)"
        assert repr(BEL(BEL(ITN(pred)))) == "[BEL, alice][ITN, cindy](secret)"

        assert repr(BEL(DES(BEL(pred)))) == "[BEL, alice][DES, bob][BEL, alice](secret)"
        assert repr(BEL(DES(DES(pred)))) == "[BEL, alice][DES, bob](secret)"
        assert repr(BEL(DES(ITN(pred)))) == "[BEL, alice][DES, bob][ITN, cindy](secret)"

        assert repr(DES(BEL(BEL(pred)))) == "[DES, bob][BEL, alice](secret)"
        assert repr(DES(BEL(DES(pred)))) == "[DES, bob][BEL, alice][DES, bob](secret)"
        assert repr(DES(BEL(ITN(pred)))) == "[DES, bob][BEL, alice][ITN, cindy](secret)"

        assert repr(DES(DES(BEL(pred)))) == "[DES, bob][BEL, alice](secret)"
        assert repr(DES(DES(DES(pred)))) == "[DES, bob](secret)"
        assert repr(DES(DES(ITN(pred)))) == "[DES, bob][ITN, cindy](secret)"

    def test_basic_soft_modls(self):
        _, _, _ , PBEL, PDES, PITN, _ , pred, _, _ = self.get_vars()
        assert repr(PBEL(pred)) == "<BEL, alice>(secret)"
        assert repr(PDES(pred)) == "<DES, bob>(secret)"
        assert repr(PITN(pred)) == "<ITN, cindy>(secret)"

    def test_basic_double_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, _ , pred, _, _ = self.get_vars()
        assert repr(PBEL(PBEL(pred))) == "<BEL, alice>(secret)"
        assert repr(PBEL(PDES(pred))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(PITN(pred))) == "<BEL, alice><ITN, cindy>(secret)"

        assert repr(PDES(PBEL(pred))) == "<DES, bob><BEL, alice>(secret)"
        assert repr(PDES(PDES(pred))) == "<DES, bob>(secret)"
        assert repr(PDES(PITN(pred))) == "<DES, bob><ITN, cindy>(secret)"

    def test_basic_triple_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, _ , pred, _, _ = self.get_vars()
        assert repr(PBEL(PBEL(PBEL(pred)))) == "<BEL, alice>(secret)"
        assert repr(PBEL(PBEL(PDES(pred)))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(PBEL(PITN(pred)))) == "<BEL, alice><ITN, cindy>(secret)"

        assert repr(PBEL(PDES(PBEL(pred)))) == "<BEL, alice><DES, bob><BEL, alice>(secret)"
        assert repr(PBEL(PDES(PDES(pred)))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(PDES(PITN(pred)))) == "<BEL, alice><DES, bob><ITN, cindy>(secret)"

        assert repr(PDES(PBEL(PBEL(pred)))) == "<DES, bob><BEL, alice>(secret)"
        assert repr(PDES(PBEL(PDES(pred)))) == "<DES, bob><BEL, alice><DES, bob>(secret)"
        assert repr(PDES(PBEL(PITN(pred)))) == "<DES, bob><BEL, alice><ITN, cindy>(secret)"

        assert repr(PDES(PDES(PBEL(pred)))) == "<DES, bob><BEL, alice>(secret)"
        assert repr(PDES(PDES(PDES(pred)))) == "<DES, bob>(secret)"
        assert repr(PDES(PDES(PITN(pred)))) == "<DES, bob><ITN, cindy>(secret)"

    def test_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _ , pred, _, _ = self.get_vars()

        # BEL/DES outer == soft inner
        assert repr(BEL(PBEL(pred))) == "<BEL, alice>(secret)"
        assert repr(BEL(PDES(pred))) == "[BEL, alice]<DES, bob>(secret)"
        assert repr(BEL(PITN(pred))) == "[BEL, alice]<ITN, cindy>(secret)"

        assert repr(DES(PBEL(pred))) == "[DES, bob]<BEL, alice>(secret)"
        assert repr(DES(PDES(pred))) == "<DES, bob>(secret)"
        assert repr(DES(PITN(pred))) == "[DES, bob]<ITN, cindy>(secret)"

        # PBEL/PDES outer == hard inner
        assert repr(PBEL(BEL(pred))) == "[BEL, alice](secret)"
        assert repr(PBEL(DES(pred))) == "<BEL, alice>[DES, bob](secret)"
        assert repr(PBEL(ITN(pred))) == "<BEL, alice>[ITN, cindy](secret)"

        assert repr(PDES(BEL(pred))) == "<DES, bob>[BEL, alice](secret)"
        assert repr(PDES(DES(pred))) == "[DES, bob](secret)"
        assert repr(PDES(ITN(pred))) == "<DES, bob>[ITN, cindy](secret)"

    def test_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _ , pred, _, _ = self.get_vars()
        assert repr(BEL(PDES(BEL(pred)))) == "[BEL, alice]<DES, bob>[BEL, alice](secret)"
        assert repr(BEL(PDES(DES(pred)))) == "[BEL, alice][DES, bob](secret)"
        assert repr(BEL(PDES(ITN(pred)))) == "[BEL, alice]<DES, bob>[ITN, cindy](secret)"

        assert repr(DES(PBEL(BEL(pred)))) == "[DES, bob][BEL, alice](secret)"
        assert repr(DES(PBEL(DES(pred)))) == "[DES, bob]<BEL, alice>[DES, bob](secret)"
        assert repr(DES(PBEL(ITN(pred)))) == "[DES, bob]<BEL, alice>[ITN, cindy](secret)"

        assert repr(PBEL(DES(PBEL(pred)))) == "<BEL, alice>[DES, bob]<BEL, alice>(secret)"
        assert repr(PBEL(DES(PDES(pred)))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(DES(PITN(pred)))) == "<BEL, alice>[DES, bob]<ITN, cindy>(secret)"

        assert repr(PDES(BEL(PBEL(pred)))) == "<DES, bob><BEL, alice>(secret)"
        assert repr(PDES(BEL(PDES(pred)))) == "<DES, bob>[BEL, alice]<DES, bob>(secret)"
        assert repr(PDES(BEL(PITN(pred)))) == "<DES, bob>[BEL, alice]<ITN, cindy>(secret)"

    def test_negation_basic_modls(self):
        BEL, DES, ITN, _, _, _, NOT, pred, _, _ = self.get_vars()
        assert repr(BEL(NOT(pred))) == "[BEL, alice](!secret)"
        assert repr(NOT(DES(pred))) == "<DES, bob>(!secret)"
        pred = Predicate(pred.name, *pred.terms, negated=True)
        assert repr(ITN(NOT(pred))) == "[ITN, cindy](secret)"

    def test_negation_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred, _, _ = self.get_vars()
        pred_negated = Predicate(pred.name, negated=True)
        assert repr(BEL(BEL(NOT(pred_negated)))) == "[BEL, alice](secret)"
        assert repr(NOT(BEL(DES(pred_negated)))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(NOT(BEL(ITN(pred)))) == "<BEL, alice><ITN, cindy>(!secret)"

    def test_negation_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred, _, pred_negated = self.get_vars()
        assert repr(NOT(BEL(BEL(BEL(pred))))) == "<BEL, alice>(!secret)"
        assert repr(BEL(BEL(NOT(DES(pred))))) == "[BEL, alice]<DES, bob>(!secret)"
        assert repr(NOT(BEL(BEL(ITN(pred_negated))))) == "<BEL, alice><ITN, cindy>(secret)"

    def test_negation_basic_soft_modls(self):
        _, _, _ , PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(NOT(PBEL(pred))) == "[BEL, alice](!secret)"
        assert repr(NOT(PDES(pred_negated))) == "[DES, bob](secret)"
        assert repr(NOT(PITN(pred_negated))) == "[ITN, cindy](secret)"

    def test_negation_basic_double_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(PBEL(NOT(PBEL(pred_negated)))) == "[BEL, alice](secret)"
        assert repr(PBEL(NOT(PDES(pred_negated)))) == "<BEL, alice>[DES, bob](secret)"
        assert repr(NOT(PBEL(PITN(pred)))) == "[BEL, alice][ITN, cindy](!secret)"

    def test_negation_basic_triple_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(PBEL(NOT(PBEL(PBEL(pred))))) == "[BEL, alice](!secret)"
        assert repr(NOT(PBEL(PBEL(PDES(pred))))) == "[BEL, alice][DES, bob](!secret)"
        assert repr(PBEL(PBEL(PITN(NOT(pred_negated))))) == "<BEL, alice><ITN, cindy>(secret)"

    def test_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(NOT(BEL(PBEL(pred_negated)))) == "[BEL, alice](secret)"
        assert repr(BEL(PDES(NOT(pred_negated)))) == "[BEL, alice]<DES, bob>(secret)"
        assert repr(NOT(BEL(PITN(pred_negated)))) == "<BEL, alice>[ITN, cindy](secret)"

        assert repr(NOT(PBEL(BEL(pred)))) == "<BEL, alice>(!secret)"
        assert repr(PBEL(DES(NOT(pred)))) == "<BEL, alice>[DES, bob](!secret)"
        assert repr(PBEL(ITN(NOT(pred)))) == "<BEL, alice>[ITN, cindy](!secret)"

    def test_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(NOT(BEL(PDES(BEL(pred))))) == "<BEL, alice>[DES, bob]<BEL, alice>(!secret)"
        assert repr(BEL(PDES(DES(NOT(pred))))) == "[BEL, alice][DES, bob](!secret)"
        assert repr(NOT(BEL(PDES(ITN(pred))))) == "<BEL, alice>[DES, bob]<ITN, cindy>(!secret)"

        assert repr(PBEL(NOT(DES(PBEL(pred_negated))))) == "<BEL, alice><DES, bob>[BEL, alice](secret)"
        assert repr(NOT(PBEL(DES(PDES(pred_negated))))) == "[BEL, alice][DES, bob](secret)"
        assert repr(PBEL(NOT(DES(PITN(pred_negated))))) == "<BEL, alice><DES, bob>[ITN, cindy](secret)"

    def test_double_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(NOT(NOT(BEL(PBEL(pred_negated))))) == "<BEL, alice>(!secret)"
        assert repr(NOT(BEL(PDES(NOT(pred_negated))))) == "<BEL, alice>[DES, bob](!secret)"
        assert repr(NOT(BEL(NOT(PITN(pred_negated))))) == "<BEL, alice><ITN, cindy>(!secret)"

        assert repr(NOT(NOT(PBEL(BEL(pred))))) == "[BEL, alice](secret)"
        assert repr(PBEL(NOT(DES(NOT(pred))))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(NOT(ITN(NOT(pred))))) == "<BEL, alice><ITN, cindy>(secret)"
    
    def test_double_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred, _, pred_negated = self.get_vars()
        assert repr(NOT(NOT(NOT(BEL(PDES(BEL(pred))))))) == "<BEL, alice>[DES, bob]<BEL, alice>(!secret)"
        assert repr(NOT(NOT(BEL(PDES(BEL(pred)))))) == "[BEL, alice]<DES, bob>[BEL, alice](secret)"
        assert repr(BEL(PDES(DES(NOT(NOT(pred)))))) == "[BEL, alice][DES, bob](secret)"
        assert repr(NOT(NOT(BEL(PDES(ITN(pred)))))) == "[BEL, alice]<DES, bob>[ITN, cindy](secret)"

        assert repr(PBEL(NOT(DES(PBEL(NOT(pred_negated)))))) == "<BEL, alice><DES, bob>[BEL, alice](!secret)"
        assert repr(NOT(PBEL(DES(NOT(PDES(pred_negated)))))) == "[BEL, alice]<DES, bob>(!secret)"
        assert repr(NOT(PBEL(NOT(DES(PITN(pred_negated)))))) == "[BEL, alice][DES, bob]<ITN, cindy>(!secret)"