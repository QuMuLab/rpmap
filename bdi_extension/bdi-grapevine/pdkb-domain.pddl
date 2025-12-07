(define (domain grapevine)
	(:requirements :typing)
	(:types
	    agent loc
	)
	(:predicates
		(connected_l1_l2)
		(Ba_PBb_not_secret_b)
		(Da_PBb_not_secret_b)
		(Ia_PBb_not_secret_b)
		(Ba_PDb_not_secret_b)
		(Da_PDb_not_secret_b)
		(Ia_PDb_not_secret_b)
		(Ba_PIb_not_secret_b)
		(Da_PIb_not_secret_b)
		(Ia_PIb_not_secret_b)
		(PBb_Ba_secret_b)
		(PDb_Ba_secret_b)
		(PIb_Ba_secret_b)
		(PBb_Da_secret_b)
		(PDb_Da_secret_b)
		(PIb_Da_secret_b)
		(PBb_Ia_secret_b)
		(PDb_Ia_secret_b)
		(PIb_Ia_secret_b)
		(PDb_PBb_not_secret_a)
		(PIb_PBb_not_secret_a)
		(PBb_PDb_not_secret_a)
		(PIb_PDb_not_secret_a)
		(PBb_PIb_not_secret_a)
		(Ba_secret_b)
		(Da_secret_b)
		(Ia_secret_b)
		(PDb_PIb_not_secret_a)
		(Da_Ba_secret_a)
		(Ia_Ba_secret_a)
		(Ba_Da_secret_a)
		(Ba_not_secret_b)
		(Da_not_secret_b)
		(Ia_not_secret_b)
		(Ia_Da_secret_a)
		(Bb_not_secret_a)
		(Db_not_secret_a)
		(Ib_not_secret_a)
		(PDa_PBa_secret_b)
		(PIa_PBa_secret_b)
		(PBa_PDa_secret_b)
		(PIa_PDa_secret_b)
		(PBa_PIa_secret_b)
		(Ib_PDa_secret_b)
		(Bb_PIa_secret_b)
		(Bb_PBa_secret_b)
		(Db_PBa_secret_b)
		(Ib_PBa_secret_b)
		(Bb_PDa_secret_b)
		(Db_PDa_secret_b)
		(Db_PIa_secret_b)
		(Ib_PIa_secret_b)
		(Bb_Ba_secret_b)
		(Db_Ba_secret_b)
		(Ib_Ba_secret_b)
		(Bb_Da_secret_b)
		(Db_Da_secret_b)
		(not_at_b_l2)
		(Ib_Da_secret_b)
		(Bb_Ia_secret_b)
		(Db_Ia_secret_b)
		(Ib_Ia_secret_b)
		(PIa_Db_secret_b)
		(PBa_Ib_secret_b)
		(Da_Ia_secret_a)
		(PBa_PBb_secret_b)
		(PDa_PBb_secret_b)
		(PIa_PBb_secret_b)
		(PBa_PDb_secret_b)
		(PDa_PDb_secret_b)
		(PIa_PDb_secret_b)
		(PBa_PIb_secret_b)
		(PDa_PIb_secret_b)
		(PIa_PIb_secret_b)
		(PBa_Bb_not_secret_b)
		(PDa_Bb_not_secret_b)
		(PIa_Bb_not_secret_b)
		(PBa_Db_not_secret_b)
		(PDa_Db_not_secret_b)
		(PIa_Db_not_secret_b)
		(PBa_Ib_not_secret_b)
		(PDa_Ib_not_secret_b)
		(PIa_Ib_not_secret_b)
		(PDa_Ba_secret_b)
		(Bb_Ba_not_secret_a)
		(Db_Ba_not_secret_a)
		(Ib_Ba_not_secret_a)
		(Bb_Da_not_secret_a)
		(Db_Da_not_secret_a)
		(Ib_Da_not_secret_a)
		(Bb_Ia_not_secret_a)
		(Db_Ia_not_secret_a)
		(Ib_Ia_not_secret_a)
		(Ba_PBb_secret_b)
		(Da_PBb_secret_b)
		(Ia_PBb_secret_b)
		(Ba_PDb_secret_b)
		(Da_PDb_secret_b)
		(Ia_PDb_secret_b)
		(Ba_PIb_secret_b)
		(Da_PIb_secret_b)
		(Ia_PIb_secret_b)
		(PIb_Da_not_secret_a)
		(PBb_Ia_not_secret_a)
		(PDb_Ia_not_secret_a)
		(PIb_Ia_not_secret_a)
		(PBb_Ba_not_secret_a)
		(PDb_Ba_not_secret_a)
		(PIb_Ba_not_secret_a)
		(PBb_Da_not_secret_a)
		(PDb_Da_not_secret_a)
		(PDa_PIa_secret_b)
		(not_connected_l1_l1)
		(Ba_Bb_secret_b)
		(Da_Bb_secret_b)
		(Ia_Bb_secret_b)
		(Ba_Db_secret_b)
		(Da_Db_secret_b)
		(Ia_Db_secret_b)
		(Ba_Ib_secret_b)
		(Da_Ib_secret_b)
		(Ia_Ib_secret_b)
		(not_connected_l1_l2)
		(PDa_PBa_not_secret_b)
		(PIa_PBa_not_secret_b)
		(PBa_PDa_not_secret_b)
		(PIa_PDa_not_secret_b)
		(PBa_PIa_not_secret_b)
		(PDa_PIa_not_secret_b)
		(PIa_Ba_secret_b)
		(Bb_secret_a)
		(Db_secret_a)
		(Ib_secret_a)
		(PBa_Da_secret_b)
		(PIa_Da_secret_b)
		(PBa_Ia_secret_b)
		(PDa_Ia_secret_b)
		(PBa_secret_b)
		(PDa_secret_b)
		(PIa_secret_b)
		(Db_PBa_secret_a)
		(Ib_PBa_secret_a)
		(Bb_PDa_secret_a)
		(Db_PDa_secret_a)
		(Ib_PDa_secret_a)
		(Bb_PIa_secret_a)
		(Db_PIa_secret_a)
		(Ib_PIa_secret_a)
		(Bb_PBa_secret_a)
		(Da_Ba_not_secret_b)
		(Db_PBb_not_secret_b)
		(Ib_PBb_not_secret_b)
		(Bb_PDb_not_secret_b)
		(Ib_PDb_not_secret_b)
		(Bb_PIb_not_secret_b)
		(Db_PIb_not_secret_b)
		(PBb_PBa_not_secret_a)
		(PDb_PBa_not_secret_a)
		(PIb_PBa_not_secret_a)
		(PBb_PDa_not_secret_a)
		(PDb_PDa_not_secret_a)
		(PIb_PDa_not_secret_a)
		(PBb_PIa_not_secret_a)
		(PDb_PIa_not_secret_a)
		(PIb_PIa_not_secret_a)
		(at_b_l2)
		(connected_l2_l1)
		(PBa_PBb_not_secret_b)
		(PDa_PBb_not_secret_b)
		(PIb_Ia_secret_a)
		(PDb_Ba_secret_a)
		(PIb_Ba_secret_a)
		(PBb_Da_secret_a)
		(PDb_Da_secret_a)
		(PIb_Da_secret_a)
		(PBb_Ia_secret_a)
		(PDb_Ia_secret_a)
		(PBb_Ba_secret_a)
		(PBb_PBa_secret_a)
		(PDb_PBa_secret_a)
		(Bb_Ba_secret_a)
		(Db_Ba_secret_a)
		(Db_Bb_secret_a)
		(Ib_Bb_secret_a)
		(Bb_Db_secret_a)
		(Ib_Db_secret_a)
		(Ib_Ba_secret_a)
		(Bb_Da_secret_a)
		(Db_Da_secret_a)
		(Ib_Da_secret_a)
		(Bb_Ib_secret_a)
		(Db_Ib_secret_a)
		(PBa_Bb_not_secret_a)
		(PDa_Bb_not_secret_a)
		(PIa_Bb_not_secret_a)
		(PBa_Db_not_secret_a)
		(PDa_Db_not_secret_a)
		(PIa_Db_not_secret_a)
		(PBa_Ib_not_secret_a)
		(PDa_Ib_not_secret_a)
		(PIa_Ib_not_secret_a)
		(Da_PBa_not_secret_b)
		(Ia_PBa_not_secret_b)
		(PBa_not_secret_a)
		(PBb_not_secret_b)
		(PDb_not_secret_b)
		(PIb_not_secret_b)
		(PDa_not_secret_a)
		(Db_PBb_secret_a)
		(Ib_PBb_secret_a)
		(Bb_PDb_secret_a)
		(Ib_PDb_secret_a)
		(Bb_PIb_secret_a)
		(Db_PIb_secret_a)
		(PDa_Ba_not_secret_b)
		(PIa_Ba_not_secret_b)
		(PBa_Da_not_secret_b)
		(PIa_Da_not_secret_b)
		(Ia_Ba_secret_b)
		(Ba_Da_secret_b)
		(Ia_Da_secret_b)
		(Ba_Ia_secret_b)
		(Da_Ia_secret_b)
		(not_secret_b)
		(PDb_Bb_not_secret_b)
		(PIb_Bb_not_secret_b)
		(PBb_Db_not_secret_b)
		(PIb_Db_not_secret_b)
		(PBb_Ib_not_secret_b)
		(PDb_Ib_not_secret_b)
		(Da_Bb_not_secret_b)
		(Ia_Bb_not_secret_b)
		(Ba_Db_not_secret_b)
		(Da_Db_not_secret_b)
		(Ia_Db_not_secret_b)
		(Ba_Ib_not_secret_b)
		(Ba_PIb_secret_a)
		(Da_PIb_secret_a)
		(Ia_PIb_secret_a)
		(Db_PDa_not_secret_a)
		(Ib_PDa_not_secret_a)
		(Bb_PBa_not_secret_a)
		(Db_PBa_not_secret_a)
		(Ib_PBa_not_secret_a)
		(Bb_PDa_not_secret_a)
		(Bb_PIa_not_secret_a)
		(Db_PIa_not_secret_a)
		(Ib_PIa_not_secret_a)
		(PBb_secret_a)
		(PDb_secret_a)
		(PIb_secret_a)
		(Ba_PIb_not_secret_a)
		(Da_PIb_not_secret_a)
		(Ia_PIb_not_secret_a)
		(Db_Bb_not_secret_b)
		(Ib_Bb_not_secret_b)
		(Bb_Db_not_secret_b)
		(Ib_Db_not_secret_b)
		(Bb_Ib_not_secret_b)
		(Db_Ib_not_secret_b)
		(PBa_Bb_secret_b)
		(PDa_Bb_secret_b)
		(PIa_Bb_secret_b)
		(PBa_Db_secret_b)
		(PDa_Db_secret_b)
		(PIb_PBa_secret_a)
		(PBb_PDa_secret_a)
		(PDb_PDa_secret_a)
		(PIb_PDa_secret_a)
		(PBb_PIa_secret_a)
		(PDb_PIa_secret_a)
		(PIb_PIa_secret_a)
		(Ba_Bb_not_secret_a)
		(Da_Bb_not_secret_a)
		(Ia_Bb_not_secret_a)
		(Ba_Db_not_secret_a)
		(Da_Db_not_secret_a)
		(Ia_Db_not_secret_a)
		(Ba_Ib_not_secret_a)
		(Da_Ib_not_secret_a)
		(Ia_Ib_not_secret_a)
		(not_connected_l2_l1)
		(PDa_Ib_secret_b)
		(PIa_Ib_secret_b)
		(secret_b)
		(Da_Ba_secret_b)
		(PBa_PBb_not_secret_a)
		(PDa_PBb_not_secret_a)
		(PIa_PBb_not_secret_a)
		(PBa_PDb_not_secret_a)
		(PDa_PDb_not_secret_a)
		(PIa_PDb_not_secret_a)
		(PBa_PIb_not_secret_a)
		(PDa_PIb_not_secret_a)
		(PIa_PIb_not_secret_a)
		(Da_PBa_secret_b)
		(Ia_PBa_secret_b)
		(Ba_PDa_secret_b)
		(Ia_PDa_secret_b)
		(Bb_not_secret_b)
		(Db_not_secret_b)
		(Ib_not_secret_b)
		(Ba_PIa_secret_b)
		(Da_PIa_secret_b)
		(PBa_not_secret_b)
		(PDa_not_secret_b)
		(PIa_not_secret_b)
		(PDb_Ia_not_secret_b)
		(PIb_Ia_not_secret_b)
		(PBb_Ba_not_secret_b)
		(PDb_Ba_not_secret_b)
		(PIb_Ba_not_secret_b)
		(PBb_Da_not_secret_b)
		(PDb_Da_not_secret_b)
		(PIb_Da_not_secret_b)
		(PBb_Ia_not_secret_b)
		(at_a_l2)
		(PDb_Bb_secret_a)
		(PIb_Bb_secret_a)
		(PBb_Db_secret_a)
		(PIb_Db_secret_a)
		(PBb_Ib_secret_a)
		(PDb_Ib_secret_a)
		(PDa_Ba_not_secret_a)
		(PIa_Ba_not_secret_a)
		(PBa_Da_not_secret_a)
		(PIa_Da_not_secret_a)
		(PBa_Ia_not_secret_a)
		(PDa_Ia_not_secret_a)
		(at_a_l1)
		(PDb_PBb_not_secret_b)
		(PIb_PBb_not_secret_b)
		(PBb_PDb_not_secret_b)
		(PIb_PDb_not_secret_b)
		(PBb_PIb_not_secret_b)
		(PDb_PIb_not_secret_b)
		(Da_Ba_not_secret_a)
		(Ia_Ba_not_secret_a)
		(Ba_Da_not_secret_a)
		(Ia_Da_not_secret_a)
		(Ba_Ia_not_secret_a)
		(Da_Ia_not_secret_a)
		(Ba_PBb_not_secret_a)
		(not_at_a_l1)
		(Da_PBb_not_secret_a)
		(Ba_secret_a)
		(Da_secret_a)
		(Ia_secret_a)
		(Ia_PBb_not_secret_a)
		(Ba_PDb_not_secret_a)
		(Da_PDb_not_secret_a)
		(Ia_PDb_not_secret_a)
		(Ba_Ia_secret_a)
		(Bb_secret_b)
		(Db_secret_b)
		(Ib_secret_b)
		(Ba_not_secret_a)
		(Da_not_secret_a)
		(Ia_not_secret_a)
		(PDa_PBa_secret_a)
		(PIa_PBa_secret_a)
		(PBa_PDa_secret_a)
		(PIa_PDa_secret_a)
		(PBa_PIa_secret_a)
		(PDa_PIa_secret_a)
		(PIa_PBb_not_secret_b)
		(PBa_PDb_not_secret_b)
		(PDa_PDb_not_secret_b)
		(PIa_PDb_not_secret_b)
		(PBa_PIb_not_secret_b)
		(PDa_PIb_not_secret_b)
		(PIa_PIb_not_secret_b)
		(PBb_PIa_secret_b)
		(PDb_PIa_secret_b)
		(PIb_PIa_secret_b)
		(PBb_PBa_secret_b)
		(PDb_PBa_secret_b)
		(PIb_PBa_secret_b)
		(PBb_PDa_secret_b)
		(PDb_PDa_secret_b)
		(PIb_PDa_secret_b)
		(not_at_a_l2)
		(PBa_PBb_secret_a)
		(PDa_PBb_secret_a)
		(PIa_PBb_secret_a)
		(PBa_PDb_secret_a)
		(PDa_PDb_secret_a)
		(PIa_PDb_secret_a)
		(PBa_PIb_secret_a)
		(PDa_PIb_secret_a)
		(PIa_PIb_secret_a)
		(Ba_Bb_secret_a)
		(Da_Bb_secret_a)
		(Ia_Bb_secret_a)
		(Ba_Db_secret_a)
		(Da_Db_secret_a)
		(Ia_Db_secret_a)
		(Ba_Ib_secret_a)
		(Da_Ib_secret_a)
		(Ia_Ib_secret_a)
		(at_b_l1)
		(PDa_Ba_secret_a)
		(PIa_Ba_secret_a)
		(PBa_Da_secret_a)
		(PIa_Da_secret_a)
		(PBa_Ia_secret_a)
		(PDa_Ia_secret_a)
		(Ia_Ba_not_secret_b)
		(Ba_Da_not_secret_b)
		(Ia_Da_not_secret_b)
		(Ba_Ia_not_secret_b)
		(Da_Ia_not_secret_b)
		(PDa_PBa_not_secret_a)
		(PIa_PBa_not_secret_a)
		(PBa_PDa_not_secret_a)
		(PIa_PDa_not_secret_a)
		(PBa_PIa_not_secret_a)
		(PDa_PIa_not_secret_a)
		(PDb_PBb_secret_b)
		(PIb_PBb_secret_b)
		(PBb_PDb_secret_b)
		(PIb_PDb_secret_b)
		(PBb_PIb_secret_b)
		(PDb_PIb_secret_b)
		(Db_Bb_secret_b)
		(Ib_Bb_secret_b)
		(Bb_Db_secret_b)
		(Ib_Db_secret_b)
		(Bb_Ib_secret_b)
		(Db_Ib_secret_b)
		(Da_PBa_secret_a)
		(Ia_PBa_secret_a)
		(Ba_PDa_secret_a)
		(Ia_PDa_secret_a)
		(Ba_PIa_secret_a)
		(Da_PIa_secret_a)
		(Db_PBb_secret_b)
		(Ib_PBb_secret_b)
		(Bb_PDb_secret_b)
		(Ib_PDb_secret_b)
		(Bb_PIb_secret_b)
		(Db_PIb_secret_b)
		(Ba_PDa_not_secret_b)
		(Ia_PDa_not_secret_b)
		(Ba_PIa_not_secret_b)
		(Da_PIa_not_secret_b)
		(PBb_PBa_not_secret_b)
		(PDb_PBa_not_secret_b)
		(PIb_PBa_not_secret_b)
		(PBb_PDa_not_secret_b)
		(PDb_PDa_not_secret_b)
		(PIb_PDa_not_secret_b)
		(PBb_PIa_not_secret_b)
		(PDb_PIa_not_secret_b)
		(PIb_PIa_not_secret_b)
		(Ba_PBb_secret_a)
		(Da_PBb_secret_a)
		(Ia_PBb_secret_a)
		(Ba_PDb_secret_a)
		(Da_PDb_secret_a)
		(Ia_PDb_secret_a)
		(secret_a)
		(Db_PBb_not_secret_a)
		(Ib_PBb_not_secret_a)
		(Bb_PDb_not_secret_a)
		(Ib_PDb_not_secret_a)
		(Bb_PIb_not_secret_a)
		(Db_PIb_not_secret_a)
		(Bb_PBa_not_secret_b)
		(Db_PBa_not_secret_b)
		(Ib_PBa_not_secret_b)
		(Bb_PDa_not_secret_b)
		(Db_PDa_not_secret_b)
		(Ib_PDa_not_secret_b)
		(Bb_PIa_not_secret_b)
		(Db_PIa_not_secret_b)
		(Ib_PIa_not_secret_b)
		(connected_l2_l2)
		(PBa_secret_a)
		(PDa_secret_a)
		(PIa_secret_a)
		(Da_PBa_not_secret_a)
		(Ia_PBa_not_secret_a)
		(Ba_PDa_not_secret_a)
		(Ia_PDa_not_secret_a)
		(Ba_PIa_not_secret_a)
		(Da_PIa_not_secret_a)
		(Bb_Ia_secret_a)
		(Db_Ia_secret_a)
		(Ib_Ia_secret_a)
		(not_at_b_l1)
		(PBa_Ia_not_secret_b)
		(PDa_Ia_not_secret_b)
		(PDb_Bb_not_secret_a)
		(PIb_Bb_not_secret_a)
		(PBb_Db_not_secret_a)
		(PIb_Db_not_secret_a)
		(PBb_Ib_not_secret_a)
		(PDb_Ib_not_secret_a)
		(PIb_secret_b)
		(PBb_secret_b)
		(PDb_secret_b)
		(PBb_not_secret_a)
		(PDb_not_secret_a)
		(PIb_not_secret_a)
		(Da_Ib_not_secret_b)
		(Ia_Ib_not_secret_b)
		(PDb_PBb_secret_a)
		(PIb_PBb_secret_a)
		(PBb_PDb_secret_a)
		(PIb_PDb_secret_a)
		(PBb_PIb_secret_a)
		(PDb_PIb_secret_a)
		(Ba_Bb_not_secret_b)
		(Bb_Ba_not_secret_b)
		(Db_Ba_not_secret_b)
		(Ib_Ba_not_secret_b)
		(Bb_Da_not_secret_b)
		(Db_Da_not_secret_b)
		(Ib_Da_not_secret_b)
		(Bb_Ia_not_secret_b)
		(Db_Ia_not_secret_b)
		(Ib_Ia_not_secret_b)
		(not_secret_a)
		(PBa_Bb_secret_a)
		(PDa_Bb_secret_a)
		(PIa_Bb_secret_a)
		(PBa_Db_secret_a)
		(PDa_Db_secret_a)
		(PIa_Db_secret_a)
		(PBa_Ib_secret_a)
		(PDa_Ib_secret_a)
		(PIa_Ib_secret_a)
		(connected_l1_l1)
		(not_connected_l2_l2)
		(Db_Bb_not_secret_a)
		(Ib_Bb_not_secret_a)
		(Bb_Db_not_secret_a)
		(Ib_Db_not_secret_a)
		(Bb_Ib_not_secret_a)
		(Db_Ib_not_secret_a)
		(PDb_Bb_secret_b)
		(PIb_Bb_secret_b)
		(PBb_Db_secret_b)
		(PIb_Db_secret_b)
		(PBb_Ib_secret_b)
		(PDb_Ib_secret_b)
		(PIa_not_secret_a)
	)
	(:action move_a_l1_l1
	    :parameters ()
	    :precondition (and
			(at_a_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(not_at_a_l1); mutual-awareness-neg__belief
			(not (not_at_a_l1)); negation-removal
			(at_a_l1)
			(not (at_a_l1))
		)
	)
	 (:action move_a_l1_l2
	    :parameters ()
	    :precondition (and
			(at_a_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_a_l2)
			(not_at_a_l1); mutual-awareness-neg__belief
			(not (not_at_a_l2)); negation-removal
			(not (at_a_l1))
		)
	)
	 (:action move_a_l2_l1
	    :parameters ()
	    :precondition (and
			(at_a_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(not_at_a_l2); mutual-awareness-neg__belief
			(not (at_a_l2))
			(at_a_l1)
			(not (not_at_a_l1)); negation-removal
		)
	)
	 (:action move_a_l2_l2
	    :parameters ()
	    :precondition (and
			(at_a_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(not_at_a_l2); mutual-awareness-neg__belief
			(at_a_l2)
			(not (at_a_l2))
			(not (not_at_a_l2)); negation-removal
		)
	)
	 (:action move_b_l1_l1
	    :parameters ()
	    :precondition (and
			(at_b_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(at_b_l1)
			(not (at_b_l1))
			(not_at_b_l1); mutual-awareness-neg__belief
			(not (not_at_b_l1)); negation-removal
		)
	)
	 (:action move_b_l1_l2
	    :parameters ()
	    :precondition (and
			(at_b_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_b_l2)
			(not (at_b_l1))
			(not_at_b_l1); mutual-awareness-neg__belief
			(not (not_at_b_l2)); negation-removal
		)
	)
	 (:action move_b_l2_l1
	    :parameters ()
	    :precondition (and
			(at_b_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(at_b_l1)
			(not (at_b_l2))
			(not (not_at_b_l1)); negation-removal
			(not_at_b_l2); mutual-awareness-neg__belief
		)
	)
	 (:action move_b_l2_l2
	    :parameters ()
	    :precondition (and
			(at_b_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(at_b_l2)
			(not (not_at_b_l2)); negation-removal
			(not (at_b_l2))
			(not_at_b_l2); mutual-awareness-neg__belief
		)
	)
	 (:action share_a_a_l1
	    :parameters ()
	    :precondition (and
			(at_a_l1)
			(Ba_secret_a)
		)
	    :effect (and
			(when (and (at_a_l1) (at_b_l1)) (PBa_Bb_secret_a)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_Ba_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_PBb_not_secret_a))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_Ba_not_secret_a))); negation-removal
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_PBb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_Bb_not_secret_a))); uncertain-firing
			(when (and (at_b_l1)) (not (PBb_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (PBb_Ba_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (PBa_PBb_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (Ba_PBb_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_Ba_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (Bb_Ba_secret_a)); mutual-awareness-pos__belief
			(when (and (not (not_at_b_l1))) (not (Bb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1))) (not (PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1))) (not (Ba_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_PBa_not_secret_a))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (PBb_PBa_secret_a)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l1)) (Ba_secret_a))
			(when (and (at_a_l1)) (PBa_secret_a)); kd45closure__belief
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_Bb_not_secret_a))); negation-removal
			(when (and (at_b_l1)) (Bb_secret_a))
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_PBa_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_PBa_not_secret_a))); negation-removal
			(when (and (at_a_l1)) (not (PBa_not_secret_a))); negation-removal
			(when (and (at_a_l1)) (not (Ba_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (Bb_PBa_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_Bb_not_secret_a))); negation-removal
			(when (and (at_b_l1)) (PBb_secret_a)); kd45closure__belief
			(when (and (not (not_at_b_l1))) (not (PBb_not_secret_a))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (Ba_Bb_secret_a)); mutual-awareness-pos__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_Ba_not_secret_a))); uncertain-firing
			(when (and (at_b_l1)) (not (Bb_not_secret_a))); negation-removal
		)
	)
	 (:action share_a_a_l2
	    :parameters ()
	    :precondition (and
			(at_a_l2)
			(Ba_secret_a)
		)
	    :effect (and
			(when (and (not (not_at_a_l2))) (not (Ba_not_secret_a))); uncertain-firing
			(when (and (at_b_l2)) (not (PBb_not_secret_a))); negation-removal
			(when (and (not (not_at_a_l2))) (not (PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_b_l2))) (not (PBb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (PBb_Ba_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l2) (at_b_l2)) (Ba_PBb_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_Ba_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (PBa_PBb_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l2)) (PBa_secret_a)); kd45closure__belief
			(when (and (at_a_l2)) (Ba_secret_a))
			(when (and (at_a_l2) (at_b_l2)) (Bb_Ba_secret_a)); mutual-awareness-pos__belief
			(when (and (at_b_l2)) (Bb_secret_a))
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (PBb_PBa_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l2)) (not (PBa_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_Bb_not_secret_a))); negation-removal
			(when (and (at_a_l2)) (not (Ba_not_secret_a))); negation-removal
			(when (and (at_b_l2)) (PBb_secret_a)); kd45closure__belief
			(when (and (at_a_l2) (at_b_l2)) (Bb_PBa_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_PBa_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_PBa_not_secret_a))); negation-removal
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_Ba_not_secret_a))); uncertain-firing
			(when (and (at_b_l2)) (not (Bb_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_Bb_not_secret_a))); negation-removal
			(when (and (not (not_at_b_l2))) (not (Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (Ba_Bb_secret_a)); mutual-awareness-pos__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_Ba_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_PBb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (PBa_Bb_secret_a)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_PBb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_Ba_not_secret_a))); negation-removal
		)
	)
	 (:action share_a_b_l1
	    :parameters ()
	    :precondition (and
			(at_a_l1)
			(Ba_secret_b)
		)
	    :effect (and
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_PBb_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_Ba_not_secret_b))); negation-removal
			(when (and (not (not_at_b_l1))) (not (Bb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_Ba_not_secret_b))); negation-removal
			(when (and (at_a_l1)) (Ba_secret_b))
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_PBa_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_PBb_not_secret_b))); negation-removal
			(when (and (not (not_at_a_l1))) (not (PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1))) (not (Ba_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_PBa_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (PBb_Ba_secret_b)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_PBb_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (PBa_PBb_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l1)) (PBa_secret_b)); kd45closure__belief
			(when (and (at_a_l1) (at_b_l1)) (Ba_PBb_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_Bb_not_secret_b))); negation-removal
			(when (and (at_b_l1)) (Bb_secret_b))
			(when (and (at_b_l1)) (not (PBb_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l1)) (not (PBa_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (PBb_PBa_secret_b)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (Bb_PBa_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l1)) (not (Ba_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_Bb_not_secret_b))); negation-removal
			(when (and (at_b_l1)) (PBb_secret_b)); kd45closure__belief
			(when (and (at_a_l1) (at_b_l1)) (Bb_Ba_secret_b)); mutual-awareness-pos__belief
			(when (and (at_b_l1)) (not (Bb_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (Ba_Bb_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (PBa_Bb_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_Ba_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_Ba_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_PBb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_b_l1))) (not (PBb_not_secret_b))); uncertain-firing
		)
	)
	 (:action share_a_b_l2
	    :parameters ()
	    :precondition (and
			(at_a_l2)
			(Ba_secret_b)
		)
	    :effect (and
			(when (and (at_a_l2) (at_b_l2)) (PBb_Ba_secret_b)); mutual-awareness-neg__belief
			(when (and (at_b_l2)) (Bb_secret_b))
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_PBb_not_secret_b))); negation-removal
			(when (and (at_b_l2)) (not (PBb_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (Ba_PBb_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (PBa_PBb_secret_b)); mutual-awareness-neg__belief
			(when (and (at_a_l2)) (not (PBa_not_secret_b))); negation-removal
			(when (and (not (not_at_b_l2))) (not (PBb_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_Bb_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l2)) (not (Ba_not_secret_b))); negation-removal
			(when (and (at_b_l2)) (PBb_secret_b)); kd45closure__belief
			(when (and (at_b_l2)) (not (Bb_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (Bb_PBa_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (Bb_Ba_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (PBb_PBa_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_b_l2))) (not (Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_Bb_not_secret_b))); negation-removal
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_Ba_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (Ba_Bb_secret_b)); mutual-awareness-pos__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_PBb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_Ba_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (PBa_Bb_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_PBb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_Bb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2))) (not (PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2))) (not (Ba_not_secret_b))); uncertain-firing
			(when (and (at_a_l2)) (Ba_secret_b))
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_Ba_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_Ba_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_PBb_not_secret_b))); negation-removal
			(when (and (at_a_l2)) (PBa_secret_b)); kd45closure__belief
		)
	)
	 (:action share_b_a_l1
	    :parameters ()
	    :precondition (and
			(at_b_l1)
			(Bb_secret_a)
		)
	    :effect (and
			(when (and (at_a_l1) (at_b_l1)) (PBa_Bb_secret_a)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_Ba_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_PBb_not_secret_a))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_Ba_not_secret_a))); negation-removal
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_PBb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_Bb_not_secret_a))); uncertain-firing
			(when (and (at_b_l1)) (not (PBb_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (PBb_Ba_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (PBa_PBb_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (Ba_PBb_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_Ba_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (Bb_Ba_secret_a)); mutual-awareness-pos__belief
			(when (and (not (not_at_b_l1))) (not (Bb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1))) (not (PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1))) (not (Ba_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_PBa_not_secret_a))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (PBb_PBa_secret_a)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l1)) (Ba_secret_a))
			(when (and (at_a_l1)) (PBa_secret_a)); kd45closure__belief
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_Bb_not_secret_a))); negation-removal
			(when (and (at_b_l1)) (Bb_secret_a))
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_PBa_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_PBa_not_secret_a))); negation-removal
			(when (and (at_a_l1)) (not (PBa_not_secret_a))); negation-removal
			(when (and (at_a_l1)) (not (Ba_not_secret_a))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (Bb_PBa_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_Bb_not_secret_a))); negation-removal
			(when (and (at_b_l1)) (PBb_secret_a)); kd45closure__belief
			(when (and (not (not_at_b_l1))) (not (PBb_not_secret_a))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (Ba_Bb_secret_a)); mutual-awareness-pos__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_Ba_not_secret_a))); uncertain-firing
			(when (and (at_b_l1)) (not (Bb_not_secret_a))); negation-removal
		)
	)
	 (:action share_b_a_l2
	    :parameters ()
	    :precondition (and
			(at_b_l2)
			(Bb_secret_a)
		)
	    :effect (and
			(when (and (not (not_at_a_l2))) (not (Ba_not_secret_a))); uncertain-firing
			(when (and (at_b_l2)) (not (PBb_not_secret_a))); negation-removal
			(when (and (not (not_at_a_l2))) (not (PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_PBa_not_secret_a))); uncertain-firing
			(when (and (not (not_at_b_l2))) (not (PBb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (PBb_Ba_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l2) (at_b_l2)) (Ba_PBb_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_Ba_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (PBa_PBb_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l2)) (PBa_secret_a)); kd45closure__belief
			(when (and (at_a_l2)) (Ba_secret_a))
			(when (and (at_a_l2) (at_b_l2)) (Bb_Ba_secret_a)); mutual-awareness-pos__belief
			(when (and (at_b_l2)) (Bb_secret_a))
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_PBb_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (PBb_PBa_secret_a)); mutual-awareness-neg__belief
			(when (and (at_a_l2)) (not (PBa_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_Bb_not_secret_a))); negation-removal
			(when (and (at_a_l2)) (not (Ba_not_secret_a))); negation-removal
			(when (and (at_b_l2)) (PBb_secret_a)); kd45closure__belief
			(when (and (at_a_l2) (at_b_l2)) (Bb_PBa_secret_a)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_PBa_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_PBa_not_secret_a))); negation-removal
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_Ba_not_secret_a))); uncertain-firing
			(when (and (at_b_l2)) (not (Bb_not_secret_a))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_Bb_not_secret_a))); negation-removal
			(when (and (not (not_at_b_l2))) (not (Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (Ba_Bb_secret_a)); mutual-awareness-pos__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_Ba_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_PBb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (PBa_Bb_secret_a)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_PBb_not_secret_a))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_Bb_not_secret_a))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_Ba_not_secret_a))); negation-removal
		)
	)
	 (:action share_b_b_l1
	    :parameters ()
	    :precondition (and
			(at_b_l1)
			(Bb_secret_b)
		)
	    :effect (and
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_PBb_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_Ba_not_secret_b))); negation-removal
			(when (and (not (not_at_b_l1))) (not (Bb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_Ba_not_secret_b))); negation-removal
			(when (and (at_a_l1)) (Ba_secret_b))
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_PBa_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_PBb_not_secret_b))); negation-removal
			(when (and (not (not_at_a_l1))) (not (PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1))) (not (Ba_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_PBa_not_secret_b))); uncertain-firing
			(when (and (at_a_l1) (at_b_l1)) (PBb_Ba_secret_b)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_PBb_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (PBa_PBb_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBa_Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l1)) (PBa_secret_b)); kd45closure__belief
			(when (and (at_a_l1) (at_b_l1)) (Ba_PBb_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (not (Ba_Bb_not_secret_b))); negation-removal
			(when (and (at_b_l1)) (Bb_secret_b))
			(when (and (at_b_l1)) (not (PBb_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (PBb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (Bb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l1)) (not (PBa_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (PBb_PBa_secret_b)); mutual-awareness-neg__belief
			(when (and (at_a_l1) (at_b_l1)) (Bb_PBa_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l1)) (not (Ba_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (not (PBa_Bb_not_secret_b))); negation-removal
			(when (and (at_b_l1)) (PBb_secret_b)); kd45closure__belief
			(when (and (at_a_l1) (at_b_l1)) (Bb_Ba_secret_b)); mutual-awareness-pos__belief
			(when (and (at_b_l1)) (not (Bb_not_secret_b))); negation-removal
			(when (and (at_a_l1) (at_b_l1)) (Ba_Bb_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l1) (at_b_l1)) (PBa_Bb_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Bb_Ba_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (PBb_Ba_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l1)) (not (not_at_b_l1))) (not (Ba_PBb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_b_l1))) (not (PBb_not_secret_b))); uncertain-firing
		)
	)
	 (:action share_b_b_l2
	    :parameters ()
	    :precondition (and
			(at_b_l2)
			(Bb_secret_b)
		)
	    :effect (and
			(when (and (at_a_l2) (at_b_l2)) (PBb_Ba_secret_b)); mutual-awareness-neg__belief
			(when (and (at_b_l2)) (Bb_secret_b))
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_PBb_not_secret_b))); negation-removal
			(when (and (at_b_l2)) (not (PBb_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (Ba_PBb_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (PBa_PBb_secret_b)); mutual-awareness-neg__belief
			(when (and (at_a_l2)) (not (PBa_not_secret_b))); negation-removal
			(when (and (not (not_at_b_l2))) (not (PBb_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_Bb_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l2)) (not (Ba_not_secret_b))); negation-removal
			(when (and (at_b_l2)) (PBb_secret_b)); kd45closure__belief
			(when (and (at_b_l2)) (not (Bb_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (Bb_PBa_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_PBa_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (Bb_Ba_secret_b)); mutual-awareness-pos__belief
			(when (and (at_a_l2) (at_b_l2)) (PBb_PBa_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_b_l2))) (not (Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (PBa_Bb_not_secret_b))); negation-removal
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_Ba_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (Ba_Bb_secret_b)); mutual-awareness-pos__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_PBb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_Ba_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (PBa_Bb_secret_b)); mutual-awareness-neg__belief
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_PBb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Ba_Bb_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2))) (not (PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBb_PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (Bb_PBa_not_secret_b))); uncertain-firing
			(when (and (not (not_at_a_l2))) (not (Ba_not_secret_b))); uncertain-firing
			(when (and (at_a_l2)) (Ba_secret_b))
			(when (and (not (not_at_a_l2)) (not (not_at_b_l2))) (not (PBa_Bb_not_secret_b))); uncertain-firing
			(when (and (at_a_l2) (at_b_l2)) (not (PBb_Ba_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Bb_Ba_not_secret_b))); negation-removal
			(when (and (at_a_l2) (at_b_l2)) (not (Ba_PBb_not_secret_b))); negation-removal
			(when (and (at_a_l2)) (PBa_secret_b)); kd45closure__belief
		)
	)
)