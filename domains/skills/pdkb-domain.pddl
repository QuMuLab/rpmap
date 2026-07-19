(define (domain skills)
	(:requirements :disjunctive-preconditions :typing :universal-preconditions)
	(:agents alice bob)
	(:types
	    agent loc skill
	)
	(:predicates
		(connected_l2_l2)
		(at_bob_l2)
		(connected_l3_l2)
		(beginner_alice_guitar)
		(beginner_bob_guitar)
		(natural_alice_guitar)
		(at_bob_l3)
		(at_alice_l1)
		(at_alice_l2)
		(learn-skill_bob_guitar)
		(connected_l1_l2)
		(connected_l3_l1)
		(intermediate_alice_guitar)
		(natural_bob_guitar)
		(expert_bob_guitar)
		(connected_l1_l1)
		(connected_l3_l3)
		(at_bob_l1)
		(connected_l2_l3)
		(interesting_guitar)
		(expert_alice_guitar)
		(connected_l2_l1)
		(intermediate_bob_guitar)
		(at_alice_l3)
		(learn-skill_alice_guitar)
		(connected_l1_l3)
	)
	(:action adopt-love-for-skill_alice_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(DESalice_learn-skill_alice_guitar)
			(beginner_alice_guitar)
			(natural_alice_guitar)
			(at_alice_l1)
		)
	    :effect (and
			(LOValice_learn-skill_alice_guitar)
			(intermediate_alice_guitar)
		)
	)
	 (:action adopt-love-for-skill_alice_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(DESalice_learn-skill_alice_guitar)
			(beginner_alice_guitar)
			(natural_alice_guitar)
			(at_alice_l2)
		)
	    :effect (and
			(LOValice_learn-skill_alice_guitar)
			(intermediate_alice_guitar)
		)
	)
	 (:action adopt-love-for-skill_alice_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(DESalice_learn-skill_alice_guitar)
			(beginner_alice_guitar)
			(natural_alice_guitar)
			(at_alice_l3)
		)
	    :effect (and
			(LOValice_learn-skill_alice_guitar)
			(intermediate_alice_guitar)
		)
	)
	 (:action adopt-love-for-skill_bob_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(DESbob_learn-skill_bob_guitar)
			(beginner_bob_guitar)
			(natural_bob_guitar)
			(at_bob_l1)
		)
	    :effect (and
			(LOVbob_learn-skill_bob_guitar)
			(intermediate_bob_guitar)
		)
	)
	 (:action adopt-love-for-skill_bob_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(DESbob_learn-skill_bob_guitar)
			(beginner_bob_guitar)
			(natural_bob_guitar)
			(at_bob_l2)
		)
	    :effect (and
			(LOVbob_learn-skill_bob_guitar)
			(intermediate_bob_guitar)
		)
	)
	 (:action adopt-love-for-skill_bob_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(DESbob_learn-skill_bob_guitar)
			(beginner_bob_guitar)
			(natural_bob_guitar)
			(at_bob_l3)
		)
	    :effect (and
			(LOVbob_learn-skill_bob_guitar)
			(intermediate_bob_guitar)
		)
	)
	 (:action become-expert_alice_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(LOValice_learn-skill_alice_guitar)
			(intermediate_alice_guitar)
		)
	    :effect (and
			(expert_alice_guitar)
			(DESalice_LOValice_learn-skill_alice_guitar)
			(DESalice_BELalice_interesting_guitar)
			(DESalice_LOVbob_learn-skill_bob_guitar)
			(DESalice_BELbob_interesting_guitar)
		)
	)
	 (:action become-expert_bob_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(LOVbob_learn-skill_bob_guitar)
			(intermediate_bob_guitar)
		)
	    :effect (and
			(expert_bob_guitar)
			(DESbob_LOValice_learn-skill_alice_guitar)
			(DESbob_BELalice_interesting_guitar)
			(DESbob_LOVbob_learn-skill_bob_guitar)
			(DESbob_BELbob_interesting_guitar)
		)
	)
	 (:action move_alice_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(at_alice_l1)
			(not (at_alice_l1))
		)
	)
	 (:action move_alice_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_alice_l2)
			(not (at_alice_l1))
		)
	)
	 (:action move_alice_l1_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(connected_l1_l3)
		)
	    :effect (and
			(at_alice_l3)
			(not (at_alice_l1))
		)
	)
	 (:action move_alice_l2_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(at_alice_l1)
			(not (at_alice_l2))
		)
	)
	 (:action move_alice_l2_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(at_alice_l2)
			(not (at_alice_l2))
		)
	)
	 (:action move_alice_l2_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(connected_l2_l3)
		)
	    :effect (and
			(at_alice_l3)
			(not (at_alice_l2))
		)
	)
	 (:action move_alice_l3_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(connected_l3_l1)
		)
	    :effect (and
			(at_alice_l1)
			(not (at_alice_l3))
		)
	)
	 (:action move_alice_l3_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(connected_l3_l2)
		)
	    :effect (and
			(at_alice_l2)
			(not (at_alice_l3))
		)
	)
	 (:action move_alice_l3_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(connected_l3_l3)
		)
	    :effect (and
			(at_alice_l3)
			(not (at_alice_l3))
		)
	)
	 (:action move_bob_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(at_bob_l1)
			(not (at_bob_l1))
		)
	)
	 (:action move_bob_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_bob_l2)
			(not (at_bob_l1))
		)
	)
	 (:action move_bob_l1_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(connected_l1_l3)
		)
	    :effect (and
			(at_bob_l3)
			(not (at_bob_l1))
		)
	)
	 (:action move_bob_l2_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(at_bob_l1)
			(not (at_bob_l2))
		)
	)
	 (:action move_bob_l2_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(at_bob_l2)
			(not (at_bob_l2))
		)
	)
	 (:action move_bob_l2_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(connected_l2_l3)
		)
	    :effect (and
			(at_bob_l3)
			(not (at_bob_l2))
		)
	)
	 (:action move_bob_l3_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(connected_l3_l1)
		)
	    :effect (and
			(at_bob_l1)
			(not (at_bob_l3))
		)
	)
	 (:action move_bob_l3_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(connected_l3_l2)
		)
	    :effect (and
			(at_bob_l2)
			(not (at_bob_l3))
		)
	)
	 (:action move_bob_l3_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(connected_l3_l3)
		)
	    :effect (and
			(at_bob_l3)
			(not (at_bob_l3))
		)
	)
	 (:action perform-skill_alice_alice_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l1)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_alice_alice_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l2)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_alice_alice_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l3)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_alice_bob_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_alice_bob_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_alice_bob_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_bob_alice_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_bob_alice_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_bob_alice_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_bob_bob_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l1)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_bob_bob_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l2)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_bob_bob_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l3)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
)