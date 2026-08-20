from refactored_rpmap.parsing_and_grounding.core.anc_eff import *


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
        return BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred

    def test_basic_modls(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()
        assert repr(BEL(pred)) == "[BEL, alice](secret)"
        assert repr(DES(pred)) == "[DES, bob](secret)"
        assert repr(ITN(pred)) == "[ITN, cindy](secret)"

    def test_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()
        assert repr(BEL(BEL(pred))) == "[BEL, alice][BEL, alice](secret)"
        assert repr(BEL(DES(pred))) == "[BEL, alice][DES, bob](secret)"
        assert repr(BEL(ITN(pred))) == "[BEL, alice][ITN, cindy](secret)"

        assert repr(DES(BEL(pred))) == "[DES, bob][BEL, alice](secret)"
        assert repr(DES(DES(pred))) == "[DES, bob][DES, bob](secret)"
        assert repr(DES(ITN(pred))) == "[DES, bob][ITN, cindy](secret)"

    def test_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, _ , pred = self.get_vars()

        assert repr(BEL(BEL(BEL(pred)))) == "[BEL, alice][BEL, alice][BEL, alice](secret)"
        assert repr(BEL(BEL(DES(pred)))) == "[BEL, alice][BEL, alice][DES, bob](secret)"
        assert repr(BEL(BEL(ITN(pred)))) == "[BEL, alice][BEL, alice][ITN, cindy](secret)"

        assert repr(BEL(DES(BEL(pred)))) == "[BEL, alice][DES, bob][BEL, alice](secret)"
        assert repr(BEL(DES(DES(pred)))) == "[BEL, alice][DES, bob][DES, bob](secret)"
        assert repr(BEL(DES(ITN(pred)))) == "[BEL, alice][DES, bob][ITN, cindy](secret)"

        assert repr(DES(BEL(BEL(pred)))) == "[DES, bob][BEL, alice][BEL, alice](secret)"
        assert repr(DES(BEL(DES(pred)))) == "[DES, bob][BEL, alice][DES, bob](secret)"
        assert repr(DES(BEL(ITN(pred)))) == "[DES, bob][BEL, alice][ITN, cindy](secret)"

        assert repr(DES(DES(BEL(pred)))) == "[DES, bob][DES, bob][BEL, alice](secret)"
        assert repr(DES(DES(DES(pred)))) == "[DES, bob][DES, bob][DES, bob](secret)"
        assert repr(DES(DES(ITN(pred)))) == "[DES, bob][DES, bob][ITN, cindy](secret)"

    def test_basic_soft_modls(self):
        _, _, _ , PBEL, PDES, PITN, _ , pred = self.get_vars()
        assert repr(PBEL(pred)) == "<BEL, alice>(secret)"
        assert repr(PDES(pred)) == "<DES, bob>(secret)"
        assert repr(PITN(pred)) == "<ITN, cindy>(secret)"

    def test_basic_double_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, _ , pred = self.get_vars()
        assert repr(PBEL(PBEL(pred))) == "<BEL, alice><BEL, alice>(secret)"
        assert repr(PBEL(PDES(pred))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(PITN(pred))) == "<BEL, alice><ITN, cindy>(secret)"

        assert repr(PDES(PBEL(pred))) == "<DES, bob><BEL, alice>(secret)"
        assert repr(PDES(PDES(pred))) == "<DES, bob><DES, bob>(secret)"
        assert repr(PDES(PITN(pred))) == "<DES, bob><ITN, cindy>(secret)"

    def test_basic_triple_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, _ , pred = self.get_vars()
        assert repr(PBEL(PBEL(PBEL(pred)))) == "<BEL, alice><BEL, alice><BEL, alice>(secret)"
        assert repr(PBEL(PBEL(PDES(pred)))) == "<BEL, alice><BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(PBEL(PITN(pred)))) == "<BEL, alice><BEL, alice><ITN, cindy>(secret)"

        assert repr(PBEL(PDES(PBEL(pred)))) == "<BEL, alice><DES, bob><BEL, alice>(secret)"
        assert repr(PBEL(PDES(PDES(pred)))) == "<BEL, alice><DES, bob><DES, bob>(secret)"
        assert repr(PBEL(PDES(PITN(pred)))) == "<BEL, alice><DES, bob><ITN, cindy>(secret)"

        assert repr(PDES(PBEL(PBEL(pred)))) == "<DES, bob><BEL, alice><BEL, alice>(secret)"
        assert repr(PDES(PBEL(PDES(pred)))) == "<DES, bob><BEL, alice><DES, bob>(secret)"
        assert repr(PDES(PBEL(PITN(pred)))) == "<DES, bob><BEL, alice><ITN, cindy>(secret)"

        assert repr(PDES(PDES(PBEL(pred)))) == "<DES, bob><DES, bob><BEL, alice>(secret)"
        assert repr(PDES(PDES(PDES(pred)))) == "<DES, bob><DES, bob><DES, bob>(secret)"
        assert repr(PDES(PDES(PITN(pred)))) == "<DES, bob><DES, bob><ITN, cindy>(secret)"

    def test_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _ , pred = self.get_vars()

        # BEL/DES outer == soft inner
        assert repr(BEL(PBEL(pred))) == "[BEL, alice]<BEL, alice>(secret)"
        assert repr(BEL(PDES(pred))) == "[BEL, alice]<DES, bob>(secret)"
        assert repr(BEL(PITN(pred))) == "[BEL, alice]<ITN, cindy>(secret)"

        assert repr(DES(PBEL(pred))) == "[DES, bob]<BEL, alice>(secret)"
        assert repr(DES(PDES(pred))) == "[DES, bob]<DES, bob>(secret)"
        assert repr(DES(PITN(pred))) == "[DES, bob]<ITN, cindy>(secret)"

        # PBEL/PDES outer == hard inner
        assert repr(PBEL(BEL(pred))) == "<BEL, alice>[BEL, alice](secret)"
        assert repr(PBEL(DES(pred))) == "<BEL, alice>[DES, bob](secret)"
        assert repr(PBEL(ITN(pred))) == "<BEL, alice>[ITN, cindy](secret)"

        assert repr(PDES(BEL(pred))) == "<DES, bob>[BEL, alice](secret)"
        assert repr(PDES(DES(pred))) == "<DES, bob>[DES, bob](secret)"
        assert repr(PDES(ITN(pred))) == "<DES, bob>[ITN, cindy](secret)"

    def test_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _ , pred = self.get_vars()
        assert repr(BEL(PDES(BEL(pred)))) == "[BEL, alice]<DES, bob>[BEL, alice](secret)"
        assert repr(BEL(PDES(DES(pred)))) == "[BEL, alice]<DES, bob>[DES, bob](secret)"
        assert repr(BEL(PDES(ITN(pred)))) == "[BEL, alice]<DES, bob>[ITN, cindy](secret)"

        assert repr(DES(PBEL(BEL(pred)))) == "[DES, bob]<BEL, alice>[BEL, alice](secret)"
        assert repr(DES(PBEL(DES(pred)))) == "[DES, bob]<BEL, alice>[DES, bob](secret)"
        assert repr(DES(PBEL(ITN(pred)))) == "[DES, bob]<BEL, alice>[ITN, cindy](secret)"

        assert repr(PBEL(DES(PBEL(pred)))) == "<BEL, alice>[DES, bob]<BEL, alice>(secret)"
        assert repr(PBEL(DES(PDES(pred)))) == "<BEL, alice>[DES, bob]<DES, bob>(secret)"
        assert repr(PBEL(DES(PITN(pred)))) == "<BEL, alice>[DES, bob]<ITN, cindy>(secret)"

        assert repr(PDES(BEL(PBEL(pred)))) == "<DES, bob>[BEL, alice]<BEL, alice>(secret)"
        assert repr(PDES(BEL(PDES(pred)))) == "<DES, bob>[BEL, alice]<DES, bob>(secret)"
        assert repr(PDES(BEL(PITN(pred)))) == "<DES, bob>[BEL, alice]<ITN, cindy>(secret)"

    def test_negation_basic_modls(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        assert repr(BEL(NOT(pred))) == "[BEL, alice](!secret)"
        assert repr(NOT(DES(pred))) == "<DES, bob>(!secret)"
        pred.negated = True
        assert repr(ITN(NOT(pred))) == "[ITN, cindy](secret)"

    def test_negation_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        pred.negated = True
        assert repr(BEL(BEL(NOT(pred)))) == "[BEL, alice][BEL, alice](secret)"
        assert repr(NOT(BEL(DES(pred)))) == "<BEL, alice><DES, bob>(secret)"
        pred.negated = False
        assert repr(NOT(BEL(ITN(pred)))) == "<BEL, alice><ITN, cindy>(!secret)"

    def test_negation_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        assert repr(NOT(BEL(BEL(BEL(pred))))) == "<BEL, alice><BEL, alice><BEL, alice>(!secret)"
        assert repr(BEL(BEL(NOT(DES(pred))))) == "[BEL, alice][BEL, alice]<DES, bob>(!secret)"
        pred.negated = True
        assert repr(NOT(BEL(BEL(ITN(pred))))) == "<BEL, alice><BEL, alice><ITN, cindy>(secret)"

    def test_negation_basic_soft_modls(self):
        _, _, _ , PBEL, PDES, PITN, NOT , pred = self.get_vars()
        assert repr(NOT(PBEL(pred))) == "[BEL, alice](!secret)"
        pred.negated = True
        assert repr(NOT(PDES(pred))) == "[DES, bob](secret)"
        assert repr(NOT(PITN(pred))) == "[ITN, cindy](secret)"

    def test_negation_basic_double_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, NOT , pred = self.get_vars()
        pred.negated = True
        assert repr(PBEL(NOT(PBEL(pred)))) == "<BEL, alice>[BEL, alice](secret)"
        assert repr(PBEL(NOT(PDES(pred)))) == "<BEL, alice>[DES, bob](secret)"
        pred.negated = False
        assert repr(NOT(PBEL(PITN(pred)))) == "[BEL, alice][ITN, cindy](!secret)"

    def test_negation_basic_triple_nesting_soft(self):
        _, _, _ , PBEL, PDES, PITN, NOT , pred = self.get_vars()
        assert repr(PBEL(NOT(PBEL(PBEL(pred))))) == "<BEL, alice>[BEL, alice][BEL, alice](!secret)"
        assert repr(NOT(PBEL(PBEL(PDES(pred))))) == "[BEL, alice][BEL, alice][DES, bob](!secret)"
        pred.negated = True
        assert repr(PBEL(PBEL(PITN(NOT(pred))))) == "<BEL, alice><BEL, alice><ITN, cindy>(secret)"

    def test_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred = self.get_vars()
        pred.negated = True
        assert repr(NOT(BEL(PBEL(pred)))) == "<BEL, alice>[BEL, alice](secret)"
        assert repr(BEL(PDES(NOT(pred)))) == "[BEL, alice]<DES, bob>(secret)"
        assert repr(NOT(BEL(PITN(pred)))) == "<BEL, alice>[ITN, cindy](secret)"

        pred.negated = False
        assert repr(NOT(PBEL(BEL(pred)))) == "[BEL, alice]<BEL, alice>(!secret)"
        assert repr(PBEL(DES(NOT(pred)))) == "<BEL, alice>[DES, bob](!secret)"
        assert repr(PBEL(ITN(NOT(pred)))) == "<BEL, alice>[ITN, cindy](!secret)"

    def test_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred = self.get_vars()
        assert repr(NOT(BEL(PDES(BEL(pred))))) == "<BEL, alice>[DES, bob]<BEL, alice>(!secret)"
        assert repr(BEL(PDES(DES(NOT(pred))))) == "[BEL, alice]<DES, bob>[DES, bob](!secret)"
        assert repr(NOT(BEL(PDES(ITN(pred))))) == "<BEL, alice>[DES, bob]<ITN, cindy>(!secret)"

        pred.negated = True
        assert repr(PBEL(NOT(DES(PBEL(pred))))) == "<BEL, alice><DES, bob>[BEL, alice](secret)"
        assert repr(NOT(PBEL(DES(PDES(pred))))) == "[BEL, alice]<DES, bob>[DES, bob](secret)"
        assert repr(PBEL(NOT(DES(PITN(pred))))) == "<BEL, alice><DES, bob>[ITN, cindy](secret)"

    def test_double_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred = self.get_vars()
        pred.negated = True
        assert repr(NOT(NOT(BEL(PBEL(pred))))) == "[BEL, alice]<BEL, alice>(!secret)"
        assert repr(NOT(BEL(PDES(NOT(pred))))) == "<BEL, alice>[DES, bob](!secret)"
        assert repr(NOT(BEL(NOT(PITN(pred))))) == "<BEL, alice><ITN, cindy>(!secret)"

        pred.negated = False
        assert repr(NOT(NOT(PBEL(BEL(pred))))) == "<BEL, alice>[BEL, alice](secret)"
        assert repr(PBEL(NOT(DES(NOT(pred))))) == "<BEL, alice><DES, bob>(secret)"
        assert repr(PBEL(NOT(ITN(NOT(pred))))) == "<BEL, alice><ITN, cindy>(secret)"
    
    def test_double_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT , pred = self.get_vars()
        assert repr(NOT(NOT(BEL(PDES(BEL(pred)))))) == "[BEL, alice]<DES, bob>[BEL, alice](secret)"
        assert repr(BEL(PDES(DES(NOT(NOT(pred)))))) == "[BEL, alice]<DES, bob>[DES, bob](secret)"
        assert repr(NOT(NOT(BEL(PDES(ITN(pred)))))) == "[BEL, alice]<DES, bob>[ITN, cindy](secret)"

        pred.negated = True
        assert repr(PBEL(NOT(DES(PBEL(NOT(pred)))))) == "<BEL, alice><DES, bob>[BEL, alice](!secret)"
        assert repr(NOT(PBEL(DES(NOT(PDES(pred)))))) == "[BEL, alice]<DES, bob><DES, bob>(!secret)"
        assert repr(NOT(PBEL(NOT(DES(PITN(pred)))))) == "[BEL, alice][DES, bob]<ITN, cindy>(!secret)"