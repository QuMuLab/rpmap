(define (domain skills)
	(:requirements :disjunctive-preconditions :typing :universal-preconditions)
	(:agents alice bob cindy derek)
	(:types
	    agent loc skill
	)
	(:predicates
		(at_derek_l2)
		(connected_l1_l2)
		(learn-skill_derek_guitar)
		(connected_l3_l3)
		(beginner_derek_guitar)
		(intermediate_cindy_guitar)
		(connected_l2_l1)
		(learn-skill_alice_guitar)
		(at_alice_l3)
		(at_alice_l2)
		(intermediate_alice_guitar)
		(at_cindy_l1)
		(connected_l1_l1)
		(at_derek_l1)
		(at_cindy_l2)
		(connected_l2_l2)
		(beginner_alice_guitar)
		(natural_cindy_guitar)
		(intermediate_derek_guitar)
		(at_cindy_l3)
		(connected_l3_l1)
		(connected_l1_l3)
		(at_alice_l1)
		(at_bob_l3)
		(learn-skill_bob_guitar)
		(connected_l2_l3)
		(expert_alice_guitar)
		(expert_cindy_guitar)
		(connected_l3_l2)
		(interesting_guitar)
		(at_bob_l2)
		(natural_derek_guitar)
		(natural_alice_guitar)
		(beginner_bob_guitar)
		(natural_bob_guitar)
		(learn-skill_cindy_guitar)
		(intermediate_bob_guitar)
		(beginner_cindy_guitar)
		(expert_derek_guitar)
		(at_bob_l1)
		(at_derek_l3)
		(expert_bob_guitar)
	)
	(:action adopt-love-for-skill_alice_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(DESalice_learn-skill_alice_guitar)
			(beginner_alice_guitar)
			(natural_alice_guitar)
		)
	    :effect (and
			(LOValice_learn-skill_alice_guitar)
			(intermediate_alice_guitar)
		)
	)
	 (:action adopt-love-for-skill_bob_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(DESbob_learn-skill_bob_guitar)
			(beginner_bob_guitar)
			(natural_bob_guitar)
		)
	    :effect (and
			(LOVbob_learn-skill_bob_guitar)
			(intermediate_bob_guitar)
		)
	)
	 (:action adopt-love-for-skill_cindy_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(DEScindy_learn-skill_cindy_guitar)
			(beginner_cindy_guitar)
			(natural_cindy_guitar)
		)
	    :effect (and
			(LOVcindy_learn-skill_cindy_guitar)
			(intermediate_cindy_guitar)
		)
	)
	 (:action adopt-love-for-skill_derek_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(DESderek_learn-skill_derek_guitar)
			(beginner_derek_guitar)
			(natural_derek_guitar)
		)
	    :effect (and
			(LOVderek_learn-skill_derek_guitar)
			(intermediate_derek_guitar)
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
			(DESalice_LOVderek_learn-skill_derek_guitar)
			(DESalice_BELderek_interesting_guitar)
			(DESalice_LOVcindy_learn-skill_cindy_guitar)
			(DESalice_BELcindy_interesting_guitar)
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
			(DESbob_LOVderek_learn-skill_derek_guitar)
			(DESbob_BELderek_interesting_guitar)
			(DESbob_LOVcindy_learn-skill_cindy_guitar)
			(DESbob_BELcindy_interesting_guitar)
			(DESbob_LOVbob_learn-skill_bob_guitar)
			(DESbob_BELbob_interesting_guitar)
		)
	)
	 (:action become-expert_cindy_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(LOVcindy_learn-skill_cindy_guitar)
			(intermediate_cindy_guitar)
		)
	    :effect (and
			(expert_cindy_guitar)
			(DEScindy_LOValice_learn-skill_alice_guitar)
			(DEScindy_BELalice_interesting_guitar)
			(DEScindy_LOVderek_learn-skill_derek_guitar)
			(DEScindy_BELderek_interesting_guitar)
			(DEScindy_LOVcindy_learn-skill_cindy_guitar)
			(DEScindy_BELcindy_interesting_guitar)
			(DEScindy_LOVbob_learn-skill_bob_guitar)
			(DEScindy_BELbob_interesting_guitar)
		)
	)
	 (:action become-expert_derek_guitar
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(LOVderek_learn-skill_derek_guitar)
			(intermediate_derek_guitar)
		)
	    :effect (and
			(expert_derek_guitar)
			(DESderek_LOValice_learn-skill_alice_guitar)
			(DESderek_BELalice_interesting_guitar)
			(DESderek_LOVderek_learn-skill_derek_guitar)
			(DESderek_BELderek_interesting_guitar)
			(DESderek_LOVcindy_learn-skill_cindy_guitar)
			(DESderek_BELcindy_interesting_guitar)
			(DESderek_LOVbob_learn-skill_bob_guitar)
			(DESderek_BELbob_interesting_guitar)
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
	 (:action move_cindy_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(at_cindy_l1)
			(not (at_cindy_l1))
		)
	)
	 (:action move_cindy_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_cindy_l2)
			(not (at_cindy_l1))
		)
	)
	 (:action move_cindy_l1_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(connected_l1_l3)
		)
	    :effect (and
			(at_cindy_l3)
			(not (at_cindy_l1))
		)
	)
	 (:action move_cindy_l2_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(at_cindy_l1)
			(not (at_cindy_l2))
		)
	)
	 (:action move_cindy_l2_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(at_cindy_l2)
			(not (at_cindy_l2))
		)
	)
	 (:action move_cindy_l2_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(connected_l2_l3)
		)
	    :effect (and
			(at_cindy_l3)
			(not (at_cindy_l2))
		)
	)
	 (:action move_cindy_l3_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(connected_l3_l1)
		)
	    :effect (and
			(at_cindy_l1)
			(not (at_cindy_l3))
		)
	)
	 (:action move_cindy_l3_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(connected_l3_l2)
		)
	    :effect (and
			(at_cindy_l2)
			(not (at_cindy_l3))
		)
	)
	 (:action move_cindy_l3_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(connected_l3_l3)
		)
	    :effect (and
			(at_cindy_l3)
			(not (at_cindy_l3))
		)
	)
	 (:action move_derek_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(at_derek_l1)
			(not (at_derek_l1))
		)
	)
	 (:action move_derek_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_derek_l2)
			(not (at_derek_l1))
		)
	)
	 (:action move_derek_l1_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(connected_l1_l3)
		)
	    :effect (and
			(at_derek_l3)
			(not (at_derek_l1))
		)
	)
	 (:action move_derek_l2_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(at_derek_l1)
			(not (at_derek_l2))
		)
	)
	 (:action move_derek_l2_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(at_derek_l2)
			(not (at_derek_l2))
		)
	)
	 (:action move_derek_l2_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(connected_l2_l3)
		)
	    :effect (and
			(at_derek_l3)
			(not (at_derek_l2))
		)
	)
	 (:action move_derek_l3_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(connected_l3_l1)
		)
	    :effect (and
			(at_derek_l1)
			(not (at_derek_l3))
		)
	)
	 (:action move_derek_l3_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(connected_l3_l2)
		)
	    :effect (and
			(at_derek_l2)
			(not (at_derek_l3))
		)
	)
	 (:action move_derek_l3_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(connected_l3_l3)
		)
	    :effect (and
			(at_derek_l3)
			(not (at_derek_l3))
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
	 (:action perform-skill_alice_cindy_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_alice_cindy_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_alice_cindy_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_alice_derek_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l1)
			(at_derek_l1)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_alice_derek_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l2)
			(at_derek_l2)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_alice_derek_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_alice_guitar)
			(at_alice_l3)
			(at_derek_l3)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
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
	 (:action perform-skill_bob_cindy_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_bob_cindy_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_bob_cindy_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_bob_derek_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l1)
			(at_derek_l1)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_bob_derek_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l2)
			(at_derek_l2)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_bob_derek_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_bob_guitar)
			(at_bob_l3)
			(at_derek_l3)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_cindy_alice_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_cindy_alice_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_cindy_alice_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_cindy_bob_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_cindy_bob_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_cindy_bob_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_cindy_cindy_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l1)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_cindy_cindy_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l2)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_cindy_cindy_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l3)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_cindy_derek_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l1)
			(at_derek_l1)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_cindy_derek_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l2)
			(at_derek_l2)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_cindy_derek_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_cindy_guitar)
			(at_cindy_l3)
			(at_derek_l3)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_derek_alice_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l1)
			(at_alice_l1)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_derek_alice_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l2)
			(at_alice_l2)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_derek_alice_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l3)
			(at_alice_l3)
		)
	    :effect (and
			(BELalice_interesting_guitar)
			(DESalice_learn-skill_alice_guitar)
		)
	)
	 (:action perform-skill_derek_bob_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l1)
			(at_bob_l1)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_derek_bob_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l2)
			(at_bob_l2)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_derek_bob_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l3)
			(at_bob_l3)
		)
	    :effect (and
			(BELbob_interesting_guitar)
			(DESbob_learn-skill_bob_guitar)
		)
	)
	 (:action perform-skill_derek_cindy_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_derek_cindy_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_derek_cindy_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(BELcindy_interesting_guitar)
			(DEScindy_learn-skill_cindy_guitar)
		)
	)
	 (:action perform-skill_derek_derek_guitar_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l1)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_derek_derek_guitar_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l2)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
	 (:action perform-skill_derek_derek_guitar_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(expert_derek_guitar)
			(at_derek_l3)
		)
	    :effect (and
			(BELderek_interesting_guitar)
			(DESderek_learn-skill_derek_guitar)
		)
	)
)