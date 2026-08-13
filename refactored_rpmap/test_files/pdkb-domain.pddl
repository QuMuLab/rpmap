(define (domain grapevine)
	(:requirements :disjunctive-preconditions :typing)
	(:agents alice bob)
	(:types
	    agent loc
	)
	(:predicates
		(move_bob_l2_l2)
		(connected_l1_l2)
		(connected_l1_l1)
		(at_alice_l2)
		(move_alice_l1_l2)
		(at_alice_l1)
		(connected_l2_l2)
		(move_alice_l1_l1)
		(at_bob_l2)
		(move_alice_l2_l1)
		(connected_l2_l1)
		(secret_bob)
		(move_bob_l1_l2)
		(move_alice_l2_l2)
		(at_bob_l1)
		(move_bob_l1_l1)
		(secret_alice)
		(move_bob_l2_l1)
	)
	(:action move_alice_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(connected_l1_l1)
			(at_alice_l1)
		)
	    :effect (and
			(not_at_alice_l1)
			(at_alice_l1)
		)
	)
	 (:action move_alice_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(connected_l1_l2)
			(at_alice_l1)
		)
	    :effect (and
			(not_at_alice_l1)
			(at_alice_l2)
			(ITN_alice_not_move_alice_l1_l2)
			(ITN_bob_not_move_alice_l1_l2)
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
			(not_at_alice_l2)
			(at_alice_l1)
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
			(not_at_alice_l2)
		)
	)
	 (:action move_bob_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(connected_l1_l1)
			(at_bob_l1)
		)
	    :effect (and
			(not_at_bob_l1)
			(at_bob_l1)
		)
	)
	 (:action move_bob_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(connected_l1_l2)
			(at_bob_l1)
		)
	    :effect (and
			(not_at_bob_l1)
			(at_bob_l2)
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
			(not_at_bob_l2)
			(at_bob_l1)
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
			(not_at_bob_l2)
		)
	)
)