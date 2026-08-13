from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.core.domain import modify_predicate_class
import unittest

class AncillaryEffectConstructionTesting(unittest.TestCase):
    def get_vars(self):
        modify_predicate_class()
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
        self.assertEqual(repr(BEL(pred)), "[BEL, alice](secret)")
        self.assertEqual(repr(DES(pred)), "[DES, bob](secret)")
        self.assertEqual(repr(ITN(pred)), "[ITN, cindy](secret)")

    def test_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()
        self.assertEqual(repr(BEL(BEL(pred))), "[BEL, alice][BEL, alice](secret)")
        self.assertEqual(repr(BEL(DES(pred))), "[BEL, alice][DES, bob](secret)")
        self.assertEqual(repr(BEL(ITN(pred))), "[BEL, alice][ITN, cindy](secret)")

        self.assertEqual(repr(DES(BEL(pred))), "[DES, bob][BEL, alice](secret)")
        self.assertEqual(repr(DES(DES(pred))), "[DES, bob][DES, bob](secret)")
        self.assertEqual(repr(DES(ITN(pred))), "[DES, bob][ITN, cindy](secret)")

    def test_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, _, pred = self.get_vars()

        self.assertEqual(repr(BEL(BEL(BEL(pred)))), "[BEL, alice][BEL, alice][BEL, alice](secret)")
        self.assertEqual(repr(BEL(BEL(DES(pred)))), "[BEL, alice][BEL, alice][DES, bob](secret)")
        self.assertEqual(repr(BEL(BEL(ITN(pred)))), "[BEL, alice][BEL, alice][ITN, cindy](secret)")

        self.assertEqual(repr(BEL(DES(BEL(pred)))), "[BEL, alice][DES, bob][BEL, alice](secret)")
        self.assertEqual(repr(BEL(DES(DES(pred)))), "[BEL, alice][DES, bob][DES, bob](secret)")
        self.assertEqual(repr(BEL(DES(ITN(pred)))), "[BEL, alice][DES, bob][ITN, cindy](secret)")

        self.assertEqual(repr(DES(BEL(BEL(pred)))), "[DES, bob][BEL, alice][BEL, alice](secret)")
        self.assertEqual(repr(DES(BEL(DES(pred)))), "[DES, bob][BEL, alice][DES, bob](secret)")
        self.assertEqual(repr(DES(BEL(ITN(pred)))), "[DES, bob][BEL, alice][ITN, cindy](secret)")

        self.assertEqual(repr(DES(DES(BEL(pred)))), "[DES, bob][DES, bob][BEL, alice](secret)")
        self.assertEqual(repr(DES(DES(DES(pred)))), "[DES, bob][DES, bob][DES, bob](secret)")
        self.assertEqual(repr(DES(DES(ITN(pred)))), "[DES, bob][DES, bob][ITN, cindy](secret)")

    def test_basic_soft_modls(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(repr(PBEL(pred)), "<BEL, alice>(secret)")
        self.assertEqual(repr(PDES(pred)), "<DES, bob>(secret)")
        self.assertEqual(repr(PITN(pred)), "<ITN, cindy>(secret)")

    def test_basic_double_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(repr(PBEL(PBEL(pred))), "<BEL, alice><BEL, alice>(secret)")
        self.assertEqual(repr(PBEL(PDES(pred))), "<BEL, alice><DES, bob>(secret)")
        self.assertEqual(repr(PBEL(PITN(pred))), "<BEL, alice><ITN, cindy>(secret)")

        self.assertEqual(repr(PDES(PBEL(pred))), "<DES, bob><BEL, alice>(secret)")
        self.assertEqual(repr(PDES(PDES(pred))), "<DES, bob><DES, bob>(secret)")
        self.assertEqual(repr(PDES(PITN(pred))), "<DES, bob><ITN, cindy>(secret)")

    def test_basic_triple_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(repr(PBEL(PBEL(PBEL(pred)))), "<BEL, alice><BEL, alice><BEL, alice>(secret)")
        self.assertEqual(repr(PBEL(PBEL(PDES(pred)))), "<BEL, alice><BEL, alice><DES, bob>(secret)")
        self.assertEqual(repr(PBEL(PBEL(PITN(pred)))), "<BEL, alice><BEL, alice><ITN, cindy>(secret)")

        self.assertEqual(repr(PBEL(PDES(PBEL(pred)))), "<BEL, alice><DES, bob><BEL, alice>(secret)")
        self.assertEqual(repr(PBEL(PDES(PDES(pred)))), "<BEL, alice><DES, bob><DES, bob>(secret)")
        self.assertEqual(repr(PBEL(PDES(PITN(pred)))), "<BEL, alice><DES, bob><ITN, cindy>(secret)")

        self.assertEqual(repr(PDES(PBEL(PBEL(pred)))), "<DES, bob><BEL, alice><BEL, alice>(secret)")
        self.assertEqual(repr(PDES(PBEL(PDES(pred)))), "<DES, bob><BEL, alice><DES, bob>(secret)")
        self.assertEqual(repr(PDES(PBEL(PITN(pred)))), "<DES, bob><BEL, alice><ITN, cindy>(secret)")

        self.assertEqual(repr(PDES(PDES(PBEL(pred)))), "<DES, bob><DES, bob><BEL, alice>(secret)")
        self.assertEqual(repr(PDES(PDES(PDES(pred)))), "<DES, bob><DES, bob><DES, bob>(secret)")
        self.assertEqual(repr(PDES(PDES(PITN(pred)))), "<DES, bob><DES, bob><ITN, cindy>(secret)")

    def test_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred = self.get_vars()

        # BEL/DES outer, soft inner
        self.assertEqual(repr(BEL(PBEL(pred))), "[BEL, alice]<BEL, alice>(secret)")
        self.assertEqual(repr(BEL(PDES(pred))), "[BEL, alice]<DES, bob>(secret)")
        self.assertEqual(repr(BEL(PITN(pred))), "[BEL, alice]<ITN, cindy>(secret)")

        self.assertEqual(repr(DES(PBEL(pred))), "[DES, bob]<BEL, alice>(secret)")
        self.assertEqual(repr(DES(PDES(pred))), "[DES, bob]<DES, bob>(secret)")
        self.assertEqual(repr(DES(PITN(pred))), "[DES, bob]<ITN, cindy>(secret)")

        # PBEL/PDES outer, hard inner
        self.assertEqual(repr(PBEL(BEL(pred))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(repr(PBEL(DES(pred))), "<BEL, alice>[DES, bob](secret)")
        self.assertEqual(repr(PBEL(ITN(pred))), "<BEL, alice>[ITN, cindy](secret)")

        self.assertEqual(repr(PDES(BEL(pred))), "<DES, bob>[BEL, alice](secret)")
        self.assertEqual(repr(PDES(DES(pred))), "<DES, bob>[DES, bob](secret)")
        self.assertEqual(repr(PDES(ITN(pred))), "<DES, bob>[ITN, cindy](secret)")

    def test_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(repr(BEL(PDES(BEL(pred)))), "[BEL, alice]<DES, bob>[BEL, alice](secret)")
        self.assertEqual(repr(BEL(PDES(DES(pred)))), "[BEL, alice]<DES, bob>[DES, bob](secret)")
        self.assertEqual(repr(BEL(PDES(ITN(pred)))), "[BEL, alice]<DES, bob>[ITN, cindy](secret)")

        self.assertEqual(repr(DES(PBEL(BEL(pred)))), "[DES, bob]<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(repr(DES(PBEL(DES(pred)))), "[DES, bob]<BEL, alice>[DES, bob](secret)")
        self.assertEqual(repr(DES(PBEL(ITN(pred)))), "[DES, bob]<BEL, alice>[ITN, cindy](secret)")

        self.assertEqual(repr(PBEL(DES(PBEL(pred)))), "<BEL, alice>[DES, bob]<BEL, alice>(secret)")
        self.assertEqual(repr(PBEL(DES(PDES(pred)))), "<BEL, alice>[DES, bob]<DES, bob>(secret)")
        self.assertEqual(repr(PBEL(DES(PITN(pred)))), "<BEL, alice>[DES, bob]<ITN, cindy>(secret)")

        self.assertEqual(repr(PDES(BEL(PBEL(pred)))), "<DES, bob>[BEL, alice]<BEL, alice>(secret)")
        self.assertEqual(repr(PDES(BEL(PDES(pred)))), "<DES, bob>[BEL, alice]<DES, bob>(secret)")
        self.assertEqual(repr(PDES(BEL(PITN(pred)))), "<DES, bob>[BEL, alice]<ITN, cindy>(secret)")

    def test_negation_basic_modls(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        self.assertEqual(repr(BEL(NOT(pred))), "[BEL, alice](!secret)")
        self.assertEqual(repr(NOT(DES(pred))), "<DES, bob>(!secret)")
        pred.negated = True
        self.assertEqual(repr(ITN(NOT(pred))), "[ITN, cindy](secret)")

    def test_negation_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(repr(BEL(BEL(NOT(pred)))), "[BEL, alice][BEL, alice](secret)")
        self.assertEqual(repr(NOT(BEL(DES(pred)))), "<BEL, alice><DES, bob>(secret)")
        pred.negated = False
        self.assertEqual(repr(NOT(BEL(ITN(pred)))), "<BEL, alice><ITN, cindy>(!secret)")

    def test_negation_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        self.assertEqual(repr(NOT(BEL(BEL(BEL(pred))))), "<BEL, alice><BEL, alice><BEL, alice>(!secret)")
        self.assertEqual(repr(BEL(BEL(NOT(DES(pred))))), "[BEL, alice][BEL, alice]<DES, bob>(!secret)")
        pred.negated = True
        self.assertEqual(repr(NOT(BEL(BEL(ITN(pred))))), "<BEL, alice><BEL, alice><ITN, cindy>(secret)")

    def test_negation_basic_soft_modls(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(repr(NOT(PBEL(pred))), "[BEL, alice](!secret)")
        pred.negated = True
        self.assertEqual(repr(NOT(PDES(pred))), "[DES, bob](secret)")
        self.assertEqual(repr(NOT(PITN(pred))), "[ITN, cindy](secret)")

    def test_negation_basic_double_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(repr(PBEL(NOT(PBEL(pred)))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(repr(PBEL(NOT(PDES(pred)))), "<BEL, alice>[DES, bob](secret)")
        pred.negated = False
        self.assertEqual(repr(NOT(PBEL(PITN(pred)))), "[BEL, alice][ITN, cindy](!secret)")

    def test_negation_basic_triple_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(repr(PBEL(NOT(PBEL(PBEL(pred))))), "<BEL, alice>[BEL, alice][BEL, alice](!secret)")
        self.assertEqual(repr(NOT(PBEL(PBEL(PDES(pred))))), "[BEL, alice][BEL, alice][DES, bob](!secret)")
        pred.negated = True
        self.assertEqual(repr(PBEL(PBEL(PITN(NOT(pred))))), "<BEL, alice><BEL, alice><ITN, cindy>(secret)")

    def test_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(repr(NOT(BEL(PBEL(pred)))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(repr(BEL(PDES(NOT(pred)))), "[BEL, alice]<DES, bob>(secret)")
        self.assertEqual(repr(NOT(BEL(PITN(pred)))), "<BEL, alice>[ITN, cindy](secret)")

        pred.negated = False
        self.assertEqual(repr(NOT(PBEL(BEL(pred)))), "[BEL, alice]<BEL, alice>(!secret)")
        self.assertEqual(repr(PBEL(DES(NOT(pred)))), "<BEL, alice>[DES, bob](!secret)")
        self.assertEqual(repr(PBEL(ITN(NOT(pred)))), "<BEL, alice>[ITN, cindy](!secret)")

    def test_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(repr(NOT(BEL(PDES(BEL(pred))))), "<BEL, alice>[DES, bob]<BEL, alice>(!secret)")
        self.assertEqual(repr(BEL(PDES(DES(NOT(pred))))), "[BEL, alice]<DES, bob>[DES, bob](!secret)")
        self.assertEqual(repr(NOT(BEL(PDES(ITN(pred))))), "<BEL, alice>[DES, bob]<ITN, cindy>(!secret)")

        pred.negated = True
        self.assertEqual(repr(PBEL(NOT(DES(PBEL(pred))))), "<BEL, alice><DES, bob>[BEL, alice](secret)")
        self.assertEqual(repr(NOT(PBEL(DES(PDES(pred))))), "[BEL, alice]<DES, bob>[DES, bob](secret)")
        self.assertEqual(repr(PBEL(NOT(DES(PITN(pred))))), "<BEL, alice><DES, bob>[ITN, cindy](secret)")

    def test_double_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(repr(NOT(NOT(BEL(PBEL(pred))))), "[BEL, alice]<BEL, alice>(!secret)")
        self.assertEqual(repr(NOT(BEL(PDES(NOT(pred))))), "<BEL, alice>[DES, bob](!secret)")
        self.assertEqual(repr(NOT(BEL(NOT(PITN(pred))))), "<BEL, alice><ITN, cindy>(!secret)")

        pred.negated = False
        self.assertEqual(repr(NOT(NOT(PBEL(BEL(pred))))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(repr(PBEL(NOT(DES(NOT(pred))))), "<BEL, alice><DES, bob>(secret)")
        self.assertEqual(repr(PBEL(NOT(ITN(NOT(pred))))), "<BEL, alice><ITN, cindy>(secret)")
    
    def test_double_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(repr(NOT(NOT(BEL(PDES(BEL(pred)))))), "[BEL, alice]<DES, bob>[BEL, alice](secret)")
        self.assertEqual(repr(BEL(PDES(DES(NOT(NOT(pred)))))), "[BEL, alice]<DES, bob>[DES, bob](secret)")
        self.assertEqual(repr(NOT(NOT(BEL(PDES(ITN(pred)))))), "[BEL, alice]<DES, bob>[ITN, cindy](secret)")

        pred.negated = True
        self.assertEqual(repr(PBEL(NOT(DES(PBEL(NOT(pred)))))), "<BEL, alice><DES, bob>[BEL, alice](!secret)")
        self.assertEqual(repr(NOT(PBEL(DES(NOT(PDES(pred)))))), "[BEL, alice]<DES, bob><DES, bob>(!secret)")
        self.assertEqual(repr(NOT(PBEL(NOT(DES(PITN(pred)))))), "[BEL, alice][DES, bob]<ITN, cindy>(!secret)")