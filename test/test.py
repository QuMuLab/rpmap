from refactored_rpmap.core.anc_eff import *
import unittest

class AncillaryEffectConstructionTesting(unittest.TestCase):
    def get_vars(self):
        setup_predicate_class()
        agent1 = Agent("alice", False)
        agent2 = Agent("bob", False)
        agent3 = Agent("cindy", False)
        BEL = MODL(GenericMODLType.BEL, agent1)
        DES = MODL(GenericMODLType.DES, agent2)
        ITN = MODL(ActionMODLType.ITN, agent3)
        PBEL = MODL(PossibleGenericMODLType.PBEL, agent1)
        PDES = MODL(PossibleGenericMODLType.PDES, agent2)
        PITN = MODL(PossibleActionMODLType.PITN, agent3)
        NOT = NOT_MODL()
        pred = Predicate("secret")
        return BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred

    def test_basic_modls(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()
        self.assertEqual(str(BEL(pred)), "[BEL, alice](secret)")
        self.assertEqual(str(DES(pred)), "[DES, bob](secret)")
        self.assertEqual(str(ITN(pred)), "[ITN, cindy](secret)")

    def test_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()
        self.assertEqual(str(BEL(BEL(pred))), "[BEL, alice][BEL, alice](secret)")
        self.assertEqual(str(BEL(DES(pred))), "[BEL, alice][DES, bob](secret)")
        self.assertEqual(str(BEL(ITN(pred))), "[BEL, alice][ITN, cindy](secret)")

        self.assertEqual(str(DES(BEL(pred))), "[DES, bob][BEL, alice](secret)")
        self.assertEqual(str(DES(DES(pred))), "[DES, bob][DES, bob](secret)")
        self.assertEqual(str(DES(ITN(pred))), "[DES, bob][ITN, cindy](secret)")

    def test_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()

        self.assertEqual(str(BEL(BEL(BEL(pred)))), "[BEL, alice][BEL, alice][BEL, alice](secret)")
        self.assertEqual(str(BEL(BEL(DES(pred)))), "[BEL, alice][BEL, alice][DES, bob](secret)")
        self.assertEqual(str(BEL(BEL(ITN(pred)))), "[BEL, alice][BEL, alice][ITN, cindy](secret)")

        self.assertEqual(str(BEL(DES(BEL(pred)))), "[BEL, alice][DES, bob][BEL, alice](secret)")
        self.assertEqual(str(BEL(DES(DES(pred)))), "[BEL, alice][DES, bob][DES, bob](secret)")
        self.assertEqual(str(BEL(DES(ITN(pred)))), "[BEL, alice][DES, bob][ITN, cindy](secret)")

        self.assertEqual(str(DES(BEL(BEL(pred)))), "[DES, bob][BEL, alice][BEL, alice](secret)")
        self.assertEqual(str(DES(BEL(DES(pred)))), "[DES, bob][BEL, alice][DES, bob](secret)")
        self.assertEqual(str(DES(BEL(ITN(pred)))), "[DES, bob][BEL, alice][ITN, cindy](secret)")

        self.assertEqual(str(DES(DES(BEL(pred)))), "[DES, bob][DES, bob][BEL, alice](secret)")
        self.assertEqual(str(DES(DES(DES(pred)))), "[DES, bob][DES, bob][DES, bob](secret)")
        self.assertEqual(str(DES(DES(ITN(pred)))), "[DES, bob][DES, bob][ITN, cindy](secret)")

    def test_basic_soft_modls(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(PBEL(pred)), "<PBEL, alice>(secret)")
        self.assertEqual(str(PDES(pred)), "<PDES, bob>(secret)")
        self.assertEqual(str(PITN(pred)), "<PITN, cindy>(secret)")

    def test_basic_double_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(PBEL(PBEL(pred))), "<PBEL, alice><PBEL, alice>(secret)")
        self.assertEqual(str(PBEL(PDES(pred))), "<PBEL, alice><PDES, bob>(secret)")
        self.assertEqual(str(PBEL(PITN(pred))), "<PBEL, alice><PITN, cindy>(secret)")

        self.assertEqual(str(PDES(PBEL(pred))), "<PDES, bob><PBEL, alice>(secret)")
        self.assertEqual(str(PDES(PDES(pred))), "<PDES, bob><PDES, bob>(secret)")
        self.assertEqual(str(PDES(PITN(pred))), "<PDES, bob><PITN, cindy>(secret)")

    def test_basic_triple_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(PBEL(PBEL(PBEL(pred)))), "<PBEL, alice><PBEL, alice><PBEL, alice>(secret)")
        self.assertEqual(str(PBEL(PBEL(PDES(pred)))), "<PBEL, alice><PBEL, alice><PDES, bob>(secret)")
        self.assertEqual(str(PBEL(PBEL(PITN(pred)))), "<PBEL, alice><PBEL, alice><PITN, cindy>(secret)")

        self.assertEqual(str(PBEL(PDES(PBEL(pred)))), "<PBEL, alice><PDES, bob><PBEL, alice>(secret)")
        self.assertEqual(str(PBEL(PDES(PDES(pred)))), "<PBEL, alice><PDES, bob><PDES, bob>(secret)")
        self.assertEqual(str(PBEL(PDES(PITN(pred)))), "<PBEL, alice><PDES, bob><PITN, cindy>(secret)")

        self.assertEqual(str(PDES(PBEL(PBEL(pred)))), "<PDES, bob><PBEL, alice><PBEL, alice>(secret)")
        self.assertEqual(str(PDES(PBEL(PDES(pred)))), "<PDES, bob><PBEL, alice><PDES, bob>(secret)")
        self.assertEqual(str(PDES(PBEL(PITN(pred)))), "<PDES, bob><PBEL, alice><PITN, cindy>(secret)")

        self.assertEqual(str(PDES(PDES(PBEL(pred)))), "<PDES, bob><PDES, bob><PBEL, alice>(secret)")
        self.assertEqual(str(PDES(PDES(PDES(pred)))), "<PDES, bob><PDES, bob><PDES, bob>(secret)")
        self.assertEqual(str(PDES(PDES(PITN(pred)))), "<PDES, bob><PDES, bob><PITN, cindy>(secret)")

    def test_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred = self.get_vars()

        # BEL/DES outer, soft inner
        self.assertEqual(str(BEL(PBEL(pred))), "[BEL, alice]<PBEL, alice>(secret)")
        self.assertEqual(str(BEL(PDES(pred))), "[BEL, alice]<PDES, bob>(secret)")
        self.assertEqual(str(BEL(PITN(pred))), "[BEL, alice]<PITN, cindy>(secret)")

        self.assertEqual(str(DES(PBEL(pred))), "[DES, bob]<PBEL, alice>(secret)")
        self.assertEqual(str(DES(PDES(pred))), "[DES, bob]<PDES, bob>(secret)")
        self.assertEqual(str(DES(PITN(pred))), "[DES, bob]<PITN, cindy>(secret)")

        # PBEL/PDES outer, hard inner
        self.assertEqual(str(PBEL(BEL(pred))), "<PBEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(PBEL(DES(pred))), "<PBEL, alice>[DES, bob](secret)")
        self.assertEqual(str(PBEL(ITN(pred))), "<PBEL, alice>[ITN, cindy](secret)")

        self.assertEqual(str(PDES(BEL(pred))), "<PDES, bob>[BEL, alice](secret)")
        self.assertEqual(str(PDES(DES(pred))), "<PDES, bob>[DES, bob](secret)")
        self.assertEqual(str(PDES(ITN(pred))), "<PDES, bob>[ITN, cindy](secret)")

    def test_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(BEL(PDES(BEL(pred)))), "[BEL, alice]<PDES, bob>[BEL, alice](secret)")
        self.assertEqual(str(BEL(PDES(DES(pred)))), "[BEL, alice]<PDES, bob>[DES, bob](secret)")
        self.assertEqual(str(BEL(PDES(ITN(pred)))), "[BEL, alice]<PDES, bob>[ITN, cindy](secret)")

        self.assertEqual(str(DES(PBEL(BEL(pred)))), "[DES, bob]<PBEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(DES(PBEL(DES(pred)))), "[DES, bob]<PBEL, alice>[DES, bob](secret)")
        self.assertEqual(str(DES(PBEL(ITN(pred)))), "[DES, bob]<PBEL, alice>[ITN, cindy](secret)")

        self.assertEqual(str(PBEL(DES(PBEL(pred)))), "<PBEL, alice>[DES, bob]<PBEL, alice>(secret)")
        self.assertEqual(str(PBEL(DES(PDES(pred)))), "<PBEL, alice>[DES, bob]<PDES, bob>(secret)")
        self.assertEqual(str(PBEL(DES(PITN(pred)))), "<PBEL, alice>[DES, bob]<PITN, cindy>(secret)")

        self.assertEqual(str(PDES(BEL(PBEL(pred)))), "<PDES, bob>[BEL, alice]<PBEL, alice>(secret)")
        self.assertEqual(str(PDES(BEL(PDES(pred)))), "<PDES, bob>[BEL, alice]<PDES, bob>(secret)")
        self.assertEqual(str(PDES(BEL(PITN(pred)))), "<PDES, bob>[BEL, alice]<PITN, cindy>(secret)")

    def test_negation_basic_modls(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        self.assertEqual(str(BEL(NOT(pred))), "[BEL, alice](!secret)")
        self.assertEqual(str(NOT(DES(pred))), "<PDES, bob>(!secret)")
        pred.negated = True
        self.assertEqual(str(ITN(NOT(pred))), "[ITN, cindy](secret)")

    def test_negation_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(BEL(BEL(NOT(pred)))), "[BEL, alice][BEL, alice](secret)")
        self.assertEqual(str(NOT(BEL(DES(pred)))), "<PBEL, alice><PDES, bob>(secret)")
        pred.negated = False
        self.assertEqual(str(NOT(BEL(ITN(pred)))), "<PBEL, alice><PITN, cindy>(!secret)")

    def test_negation_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(BEL(BEL(BEL(pred))))), "<PBEL, alice><PBEL, alice><PBEL, alice>(!secret)")
        self.assertEqual(str(BEL(BEL(NOT(DES(pred))))), "[BEL, alice][BEL, alice]<PDES, bob>(!secret)")
        pred.negated = True
        self.assertEqual(str(NOT(BEL(BEL(ITN(pred))))), "<PBEL, alice><PBEL, alice><PITN, cindy>(secret)")

    def test_negation_basic_soft_modls(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(PBEL(pred))), "[BEL, alice](!secret)")
        pred.negated = True
        self.assertEqual(str(NOT(PDES(pred))), "[DES, bob](secret)")
        self.assertEqual(str(NOT(PITN(pred))), "[ITN, cindy](secret)")

    def test_negation_basic_double_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(PBEL(NOT(PBEL(pred)))), "<PBEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(PBEL(NOT(PDES(pred)))), "<PBEL, alice>[DES, bob](secret)")
        pred.negated = False
        self.assertEqual(str(NOT(PBEL(PITN(pred)))), "[BEL, alice][ITN, cindy](!secret)")

    def test_negation_basic_triple_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(PBEL(NOT(PBEL(PBEL(pred))))), "<PBEL, alice>[BEL, alice][BEL, alice](!secret)")
        self.assertEqual(str(NOT(PBEL(PBEL(PDES(pred))))), "[BEL, alice][BEL, alice][DES, bob](!secret)")
        pred.negated = True
        self.assertEqual(str(PBEL(PBEL(PITN(NOT(pred))))), "<PBEL, alice><PBEL, alice><PITN, cindy>(secret)")

    def test_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(NOT(BEL(PBEL(pred)))), "<PBEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(BEL(PDES(NOT(pred)))), "[BEL, alice]<PDES, bob>(secret)")
        self.assertEqual(str(NOT(BEL(PITN(pred)))), "<PBEL, alice>[ITN, cindy](secret)")

        pred.negated = False
        self.assertEqual(str(NOT(PBEL(BEL(pred)))), "[BEL, alice]<PBEL, alice>(!secret)")
        self.assertEqual(str(PBEL(DES(NOT(pred)))), "<PBEL, alice>[DES, bob](!secret)")
        self.assertEqual(str(PBEL(ITN(NOT(pred)))), "<PBEL, alice>[ITN, cindy](!secret)")

    def test_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(BEL(PDES(BEL(pred))))), "<PBEL, alice>[DES, bob]<PBEL, alice>(!secret)")
        self.assertEqual(str(BEL(PDES(DES(NOT(pred))))), "[BEL, alice]<PDES, bob>[DES, bob](!secret)")
        self.assertEqual(str(NOT(BEL(PDES(ITN(pred))))), "<PBEL, alice>[DES, bob]<PITN, cindy>(!secret)")

        pred.negated = True
        self.assertEqual(str(PBEL(NOT(DES(PBEL(pred))))), "<PBEL, alice><PDES, bob>[BEL, alice](secret)")
        self.assertEqual(str(NOT(PBEL(DES(PDES(pred))))), "[BEL, alice]<PDES, bob>[DES, bob](secret)")
        self.assertEqual(str(PBEL(NOT(DES(PITN(pred))))), "<PBEL, alice><PDES, bob>[ITN, cindy](secret)")

    def test_double_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(NOT(NOT(BEL(PBEL(pred))))), "[BEL, alice]<PBEL, alice>(!secret)")
        self.assertEqual(str(NOT(BEL(PDES(NOT(pred))))), "<PBEL, alice>[DES, bob](!secret)")
        self.assertEqual(str(NOT(BEL(NOT(PITN(pred))))), "<PBEL, alice><PITN, cindy>(!secret)")

        pred.negated = False
        self.assertEqual(str(NOT(NOT(PBEL(BEL(pred))))), "<PBEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(PBEL(NOT(DES(NOT(pred))))), "<PBEL, alice><PDES, bob>(secret)")
        self.assertEqual(str(PBEL(NOT(ITN(NOT(pred))))), "<PBEL, alice><PITN, cindy>(secret)")
    
    def test_double_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(NOT(BEL(PDES(BEL(pred)))))), "[BEL, alice]<PDES, bob>[BEL, alice](secret)")
        self.assertEqual(str(BEL(PDES(DES(NOT(NOT(pred)))))), "[BEL, alice]<PDES, bob>[DES, bob](secret)")
        self.assertEqual(str(NOT(NOT(BEL(PDES(ITN(pred)))))), "[BEL, alice]<PDES, bob>[ITN, cindy](secret)")

        pred.negated = True
        self.assertEqual(str(PBEL(NOT(DES(PBEL(NOT(pred)))))), "<PBEL, alice><PDES, bob>[BEL, alice](!secret)")
        self.assertEqual(str(NOT(PBEL(DES(NOT(PDES(pred)))))), "[BEL, alice]<PDES, bob><PDES, bob>(!secret)")
        self.assertEqual(str(NOT(PBEL(NOT(DES(PITN(pred)))))), "[BEL, alice][DES, bob]<PITN, cindy>(!secret)")