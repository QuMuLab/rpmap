from refactored_rpmap.parsing_and_grounding.core.anc_eff import *
from refactored_rpmap.parsing_and_grounding.core.domain import modify_predicate_class
import unittest

class AncillaryEffectConstructionTesting(unittest.TestCase):
    def get_vars(self):
        modify_predicate_class(print_rml_style=False)
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
        self.assertEqual(str(PBEL(pred)), "<BEL, alice>(secret)")
        self.assertEqual(str(PDES(pred)), "<DES, bob>(secret)")
        self.assertEqual(str(PITN(pred)), "<ITN, cindy>(secret)")

    def test_basic_double_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(PBEL(PBEL(pred))), "<BEL, alice><BEL, alice>(secret)")
        self.assertEqual(str(PBEL(PDES(pred))), "<BEL, alice><DES, bob>(secret)")
        self.assertEqual(str(PBEL(PITN(pred))), "<BEL, alice><ITN, cindy>(secret)")

        self.assertEqual(str(PDES(PBEL(pred))), "<DES, bob><BEL, alice>(secret)")
        self.assertEqual(str(PDES(PDES(pred))), "<DES, bob><DES, bob>(secret)")
        self.assertEqual(str(PDES(PITN(pred))), "<DES, bob><ITN, cindy>(secret)")

    def test_basic_triple_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(PBEL(PBEL(PBEL(pred)))), "<BEL, alice><BEL, alice><BEL, alice>(secret)")
        self.assertEqual(str(PBEL(PBEL(PDES(pred)))), "<BEL, alice><BEL, alice><DES, bob>(secret)")
        self.assertEqual(str(PBEL(PBEL(PITN(pred)))), "<BEL, alice><BEL, alice><ITN, cindy>(secret)")

        self.assertEqual(str(PBEL(PDES(PBEL(pred)))), "<BEL, alice><DES, bob><BEL, alice>(secret)")
        self.assertEqual(str(PBEL(PDES(PDES(pred)))), "<BEL, alice><DES, bob><DES, bob>(secret)")
        self.assertEqual(str(PBEL(PDES(PITN(pred)))), "<BEL, alice><DES, bob><ITN, cindy>(secret)")

        self.assertEqual(str(PDES(PBEL(PBEL(pred)))), "<DES, bob><BEL, alice><BEL, alice>(secret)")
        self.assertEqual(str(PDES(PBEL(PDES(pred)))), "<DES, bob><BEL, alice><DES, bob>(secret)")
        self.assertEqual(str(PDES(PBEL(PITN(pred)))), "<DES, bob><BEL, alice><ITN, cindy>(secret)")

        self.assertEqual(str(PDES(PDES(PBEL(pred)))), "<DES, bob><DES, bob><BEL, alice>(secret)")
        self.assertEqual(str(PDES(PDES(PDES(pred)))), "<DES, bob><DES, bob><DES, bob>(secret)")
        self.assertEqual(str(PDES(PDES(PITN(pred)))), "<DES, bob><DES, bob><ITN, cindy>(secret)")

    def test_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred = self.get_vars()

        # BEL/DES outer, soft inner
        self.assertEqual(str(BEL(PBEL(pred))), "[BEL, alice]<BEL, alice>(secret)")
        self.assertEqual(str(BEL(PDES(pred))), "[BEL, alice]<DES, bob>(secret)")
        self.assertEqual(str(BEL(PITN(pred))), "[BEL, alice]<ITN, cindy>(secret)")

        self.assertEqual(str(DES(PBEL(pred))), "[DES, bob]<BEL, alice>(secret)")
        self.assertEqual(str(DES(PDES(pred))), "[DES, bob]<DES, bob>(secret)")
        self.assertEqual(str(DES(PITN(pred))), "[DES, bob]<ITN, cindy>(secret)")

        # PBEL/PDES outer, hard inner
        self.assertEqual(str(PBEL(BEL(pred))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(PBEL(DES(pred))), "<BEL, alice>[DES, bob](secret)")
        self.assertEqual(str(PBEL(ITN(pred))), "<BEL, alice>[ITN, cindy](secret)")

        self.assertEqual(str(PDES(BEL(pred))), "<DES, bob>[BEL, alice](secret)")
        self.assertEqual(str(PDES(DES(pred))), "<DES, bob>[DES, bob](secret)")
        self.assertEqual(str(PDES(ITN(pred))), "<DES, bob>[ITN, cindy](secret)")

    def test_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, _, pred = self.get_vars()
        self.assertEqual(str(BEL(PDES(BEL(pred)))), "[BEL, alice]<DES, bob>[BEL, alice](secret)")
        self.assertEqual(str(BEL(PDES(DES(pred)))), "[BEL, alice]<DES, bob>[DES, bob](secret)")
        self.assertEqual(str(BEL(PDES(ITN(pred)))), "[BEL, alice]<DES, bob>[ITN, cindy](secret)")

        self.assertEqual(str(DES(PBEL(BEL(pred)))), "[DES, bob]<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(DES(PBEL(DES(pred)))), "[DES, bob]<BEL, alice>[DES, bob](secret)")
        self.assertEqual(str(DES(PBEL(ITN(pred)))), "[DES, bob]<BEL, alice>[ITN, cindy](secret)")

        self.assertEqual(str(PBEL(DES(PBEL(pred)))), "<BEL, alice>[DES, bob]<BEL, alice>(secret)")
        self.assertEqual(str(PBEL(DES(PDES(pred)))), "<BEL, alice>[DES, bob]<DES, bob>(secret)")
        self.assertEqual(str(PBEL(DES(PITN(pred)))), "<BEL, alice>[DES, bob]<ITN, cindy>(secret)")

        self.assertEqual(str(PDES(BEL(PBEL(pred)))), "<DES, bob>[BEL, alice]<BEL, alice>(secret)")
        self.assertEqual(str(PDES(BEL(PDES(pred)))), "<DES, bob>[BEL, alice]<DES, bob>(secret)")
        self.assertEqual(str(PDES(BEL(PITN(pred)))), "<DES, bob>[BEL, alice]<ITN, cindy>(secret)")

    def test_negation_basic_modls(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        self.assertEqual(str(BEL(NOT(pred))), "[BEL, alice](!secret)")
        self.assertEqual(str(NOT(DES(pred))), "<DES, bob>(!secret)")
        pred.negated = True
        self.assertEqual(str(ITN(NOT(pred))), "[ITN, cindy](secret)")

    def test_negation_basic_double_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(BEL(BEL(NOT(pred)))), "[BEL, alice][BEL, alice](secret)")
        self.assertEqual(str(NOT(BEL(DES(pred)))), "<BEL, alice><DES, bob>(secret)")
        pred.negated = False
        self.assertEqual(str(NOT(BEL(ITN(pred)))), "<BEL, alice><ITN, cindy>(!secret)")

    def test_negation_basic_triple_nesting(self):
        BEL, DES, ITN, _, _, _, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(BEL(BEL(BEL(pred))))), "<BEL, alice><BEL, alice><BEL, alice>(!secret)")
        self.assertEqual(str(BEL(BEL(NOT(DES(pred))))), "[BEL, alice][BEL, alice]<DES, bob>(!secret)")
        pred.negated = True
        self.assertEqual(str(NOT(BEL(BEL(ITN(pred))))), "<BEL, alice><BEL, alice><ITN, cindy>(secret)")

    def test_negation_basic_soft_modls(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(PBEL(pred))), "[BEL, alice](!secret)")
        pred.negated = True
        self.assertEqual(str(NOT(PDES(pred))), "[DES, bob](secret)")
        self.assertEqual(str(NOT(PITN(pred))), "[ITN, cindy](secret)")

    def test_negation_basic_double_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(PBEL(NOT(PBEL(pred)))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(PBEL(NOT(PDES(pred)))), "<BEL, alice>[DES, bob](secret)")
        pred.negated = False
        self.assertEqual(str(NOT(PBEL(PITN(pred)))), "[BEL, alice][ITN, cindy](!secret)")

    def test_negation_basic_triple_nesting_soft(self):
        _, _, _, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(PBEL(NOT(PBEL(PBEL(pred))))), "<BEL, alice>[BEL, alice][BEL, alice](!secret)")
        self.assertEqual(str(NOT(PBEL(PBEL(PDES(pred))))), "[BEL, alice][BEL, alice][DES, bob](!secret)")
        pred.negated = True
        self.assertEqual(str(PBEL(PBEL(PITN(NOT(pred))))), "<BEL, alice><BEL, alice><ITN, cindy>(secret)")

    def test_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(NOT(BEL(PBEL(pred)))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(BEL(PDES(NOT(pred)))), "[BEL, alice]<DES, bob>(secret)")
        self.assertEqual(str(NOT(BEL(PITN(pred)))), "<BEL, alice>[ITN, cindy](secret)")

        pred.negated = False
        self.assertEqual(str(NOT(PBEL(BEL(pred)))), "[BEL, alice]<BEL, alice>(!secret)")
        self.assertEqual(str(PBEL(DES(NOT(pred)))), "<BEL, alice>[DES, bob](!secret)")
        self.assertEqual(str(PBEL(ITN(NOT(pred)))), "<BEL, alice>[ITN, cindy](!secret)")

    def test_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(BEL(PDES(BEL(pred))))), "<BEL, alice>[DES, bob]<BEL, alice>(!secret)")
        self.assertEqual(str(BEL(PDES(DES(NOT(pred))))), "[BEL, alice]<DES, bob>[DES, bob](!secret)")
        self.assertEqual(str(NOT(BEL(PDES(ITN(pred))))), "<BEL, alice>[DES, bob]<ITN, cindy>(!secret)")

        pred.negated = True
        self.assertEqual(str(PBEL(NOT(DES(PBEL(pred))))), "<BEL, alice><DES, bob>[BEL, alice](secret)")
        self.assertEqual(str(NOT(PBEL(DES(PDES(pred))))), "[BEL, alice]<DES, bob>[DES, bob](secret)")
        self.assertEqual(str(PBEL(NOT(DES(PITN(pred))))), "<BEL, alice><DES, bob>[ITN, cindy](secret)")

    def test_double_negation_basic_double_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        pred.negated = True
        self.assertEqual(str(NOT(NOT(BEL(PBEL(pred))))), "[BEL, alice]<BEL, alice>(!secret)")
        self.assertEqual(str(NOT(BEL(PDES(NOT(pred))))), "<BEL, alice>[DES, bob](!secret)")
        self.assertEqual(str(NOT(BEL(NOT(PITN(pred))))), "<BEL, alice><ITN, cindy>(!secret)")

        pred.negated = False
        self.assertEqual(str(NOT(NOT(PBEL(BEL(pred))))), "<BEL, alice>[BEL, alice](secret)")
        self.assertEqual(str(PBEL(NOT(DES(NOT(pred))))), "<BEL, alice><DES, bob>(secret)")
        self.assertEqual(str(PBEL(NOT(ITN(NOT(pred))))), "<BEL, alice><ITN, cindy>(secret)")
    
    def test_double_negation_basic_triple_nesting_mixed(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        self.assertEqual(str(NOT(NOT(BEL(PDES(BEL(pred)))))), "[BEL, alice]<DES, bob>[BEL, alice](secret)")
        self.assertEqual(str(BEL(PDES(DES(NOT(NOT(pred)))))), "[BEL, alice]<DES, bob>[DES, bob](secret)")
        self.assertEqual(str(NOT(NOT(BEL(PDES(ITN(pred)))))), "[BEL, alice]<DES, bob>[ITN, cindy](secret)")

        pred.negated = True
        self.assertEqual(str(PBEL(NOT(DES(PBEL(NOT(pred)))))), "<BEL, alice><DES, bob>[BEL, alice](!secret)")
        self.assertEqual(str(NOT(PBEL(DES(NOT(PDES(pred)))))), "[BEL, alice]<DES, bob><DES, bob>(!secret)")
        self.assertEqual(str(NOT(PBEL(NOT(DES(PITN(pred)))))), "[BEL, alice][DES, bob]<ITN, cindy>(!secret)")