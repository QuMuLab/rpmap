(define (domain grapevine)
	(:requirements :typing)
	(:agents alice bob)
	(:types
	    agent loc
	)
	(:predicates
		(secret_alice)
		(connected_l2_l1)
		(at_alice_l2)
		(connected_l1_l2)
		(secret_bob)
		(connected_l2_l2)
		(connected_l1_l1)
		(at_alice_l1)
		(move_alice_l1_l2)
		(at_bob_l2)
		(at_bob_l1)
	)
	(:action move_alice_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(connected_l1_l1)
			(at_alice_l1)
		)
	    :effect (and
			(not (at_alice_l1))
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
			(at_alice_l2)
			(not (at_alice_l1))
			[ITN, bob](not_move_alice_l1_l2)
			[ITN, alice](not_move_alice_l1_l2)
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
			(not (at_alice_l2))
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
			(not (at_alice_l2))
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
			(at_bob_l1)
			(not (at_bob_l1))
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
			(not (at_bob_l1))
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
)