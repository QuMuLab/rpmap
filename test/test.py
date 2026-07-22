from .new_anc_eff import *
import unittest

class AncillaryEffectNestingTesting(unittest.TestCase):
    def get_vars(self):
        agent1 = Agent("alice", False)
        agent2 = Agent("bob", False)
        agent3 = Agent("cindy", False)
        agent4 = Agent("derek", False)
        agent5 = Agent("evelyn", False)
        agent6 = Agent("frank", False)
        BEL = MODL(GenericMODLType.BEL, agent1)
        DES = MODL(GenericMODLType.DES, agent2)
        ITN = MODL(ActionMODLType.ITN, agent3)
        PBEL = MODL(PossibleGenericMODLType.PBEL, agent4)
        PDES = MODL(PossibleGenericMODLType.PDES, agent5)
        PITN = MODL(PossibleActionMODLType.PITN, agent6)
        NOT = NOT_MODL()
        pred = Predicate("secret")
        return BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred

    def test_basic_nesting(self):
        BEL, DES, ITN, PBEL, PDES, PITN, NOT, pred = self.get_vars()
        
        self.assertEqual(str(BEL(DES(pred))), "[BEL, alice][DES, bob](secret)")
        self.assertEqual(str(DES(BEL(pred))), "[DES, bob][BEL, alice](secret)")
        self.assertEqual(str(DES(BEL(ITN(pred)))), "[DES, bob][BEL, alice][ITN, cindy](secret)")