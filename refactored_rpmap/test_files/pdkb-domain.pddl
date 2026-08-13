(define (domain grapevine)
	(:requirements :disjunctive-preconditions :typing)
	(:agents alice bob)
	(:types
	    agent loc
	)
	(:predicates
		(ITN_bob_not_move_alice_l1_l2)
		(connected_l2_l1)
		(ITN_alice_not_move_bob_l1_l2)
		(connected_l1_l1)
		(at_alice_l2)
		(secret_alice)
		(connected_l2_l2)
		(secret_bob)
		(at_alice_l1)
		(ITN_bob_not_move_bob_l1_l2)
		(at_bob_l1)
		(connected_l1_l2)
		(at_bob_l2)
		(ITN_alice_not_move_alice_l1_l2)
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
			(ITN_bob_not_move_alice_l1_l2)
			(ITN_alice_not_move_alice_l1_l2)
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
			(not (at_alice_l2))
			(at_alice_l2)
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
			(not (at_bob_l1))
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
			(at_bob_l2)
			(not (at_bob_l1))
			(ITN_bob_not_move_bob_l1_l2)
			(ITN_alice_not_move_bob_l1_l2)
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
			(not (at_bob_l2))
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
			(not (at_bob_l2))
		)
	)
	 (:action share_alice_alice_l1
	    :derive-condition (at_alice_l1)
	    :parameters ()
	    :precondition (and
			(BEL_alice_secret_alice)
			(at_alice_l1)
		)
	    :effect (and
			(when (and (at_bob_l1)) (and (BEL_bob_secret_alice)))
			(when (and (at_alice_l1)) (and (BEL_alice_secret_alice)))
		)
	)
	 (:action share_alice_alice_l1
	    :derive-condition (at_bob_l1)
	    :parameters ()
	    :precondition (and
			(BEL_alice_secret_alice)
			(at_alice_l1)
		)
	    :effect (and
			(when (and (at_bob_l1)) (and (BEL_bob_secret_alice)))
			(when (and (at_alice_l1)) (and (BEL_alice_secret_alice)))
		)
	)
	 (:action share_alice_alice_l2
	    :derive-condition (at_alice_l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(BEL_alice_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (and (BEL_bob_secret_alice)))
			(when (and (at_alice_l2)) (and (BEL_alice_secret_alice)))
		)
	)
	 (:action share_alice_alice_l2
	    :derive-condition (at_bob_l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(BEL_alice_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (and (BEL_bob_secret_alice)))
			(when (and (at_alice_l2)) (and (BEL_alice_secret_alice)))
		)
	)
	 (:action share_alice_bob_l1
	    :derive-condition (at_alice_l1)
	    :parameters ()
	    :precondition (and
			(BEL_alice_secret_bob)
			(at_alice_l1)
		)
	    :effect (and
			(when (and (at_bob_l1)) (and (BEL_bob_secret_bob)))
			(when (and (at_alice_l1)) (and (BEL_alice_secret_bob)))
		)
	)
	 (:action share_alice_bob_l1
	    :derive-condition (at_bob_l1)
	    :parameters ()
	    :precondition (and
			(BEL_alice_secret_bob)
			(at_alice_l1)
		)
	    :effect (and
			(when (and (at_bob_l1)) (and (BEL_bob_secret_bob)))
			(when (and (at_alice_l1)) (and (BEL_alice_secret_bob)))
		)
	)
	 (:action share_alice_bob_l2
	    :derive-condition (at_alice_l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(BEL_alice_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l2)) (and (BEL_bob_secret_bob)))
			(when (and (at_alice_l2)) (and (BEL_alice_secret_bob)))
		)
	)
	 (:action share_alice_bob_l2
	    :derive-condition (at_bob_l2)
	    :parameters ()
	    :precondition (and
			(BEL_alice_secret_bob)
			(at_alice_l2)
		)
	    :effect (and
			(when (and (at_bob_l2)) (and (BEL_bob_secret_bob)))
			(when (and (at_alice_l2)) (and (BEL_alice_secret_bob)))
		)
	)
	 (:action share_bob_alice_l1
	    :derive-condition (at_alice_l1)
	    :parameters ()
	    :precondition (and
			(BEL_bob_secret_alice)
			(at_bob_l1)
		)
	    :effect (and
			(when (and (at_alice_l1)) (and (BEL_alice_secret_alice)))
			(when (and (at_bob_l1)) (and (BEL_bob_secret_alice)))
		)
	)
	 (:action share_bob_alice_l1
	    :derive-condition (at_bob_l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(BEL_bob_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l1)) (and (BEL_bob_secret_alice)))
			(when (and (at_alice_l1)) (and (BEL_alice_secret_alice)))
		)
	)
	 (:action share_bob_alice_l2
	    :derive-condition (at_alice_l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(BEL_bob_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (and (BEL_bob_secret_alice)))
			(when (and (at_alice_l2)) (and (BEL_alice_secret_alice)))
		)
	)
	 (:action share_bob_alice_l2
	    :derive-condition (at_bob_l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(BEL_bob_secret_alice)
		)
	    :effect (and
			(when (and (at_alice_l2)) (and (BEL_alice_secret_alice)))
			(when (and (at_bob_l2)) (and (BEL_bob_secret_alice)))
		)
	)
	 (:action share_bob_bob_l1
	    :derive-condition (at_alice_l1)
	    :parameters ()
	    :precondition (and
			(BEL_bob_secret_bob)
			(at_bob_l1)
		)
	    :effect (and
			(when (and (at_alice_l1)) (and (BEL_alice_secret_bob)))
			(when (and (at_bob_l1)) (and (BEL_bob_secret_bob)))
		)
	)
	 (:action share_bob_bob_l1
	    :derive-condition (at_bob_l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(BEL_bob_secret_bob)
		)
	    :effect (and
			(when (and (at_alice_l1)) (and (BEL_alice_secret_bob)))
			(when (and (at_bob_l1)) (and (BEL_bob_secret_bob)))
		)
	)
	 (:action share_bob_bob_l2
	    :derive-condition (at_alice_l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(BEL_bob_secret_bob)
		)
	    :effect (and
			(when (and (at_alice_l2)) (and (BEL_alice_secret_bob)))
			(when (and (at_bob_l2)) (and (BEL_bob_secret_bob)))
		)
	)
	 (:action share_bob_bob_l2
	    :derive-condition (at_bob_l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(BEL_bob_secret_bob)
		)
	    :effect (and
			(when (and (at_alice_l2)) (and (BEL_alice_secret_bob)))
			(when (and (at_bob_l2)) (and (BEL_bob_secret_bob)))
		)
	)
)