(define (domain grapevine)
	(:requirements :typing)
	(:agents alice bob cindy derek evelyn)
	(:types
	    agent loc
	)
	(:predicates
		(at_bob_l2)
		(secret_derek)
		(at_evelyn_l3)
		(at_derek_l2)
		(at_derek_l3)
		(at_cindy_l2)
		(secret_cindy)
		(connected_l2_l2)
		(connected_l3_l3)
		(at_alice_l2)
		(at_bob_l1)
		(connected_l1_l3)
		(at_alice_l3)
		(connected_l1_l2)
		(at_alice_l1)
		(secret_bob)
		(connected_l3_l1)
		(connected_l2_l3)
		(connected_l1_l1)
		(at_derek_l1)
		(connected_l2_l1)
		(at_evelyn_l2)
		(at_evelyn_l1)
		(secret_evelyn)
		(at_cindy_l1)
		(secret_alice)
		(connected_l3_l2)
		(at_bob_l3)
		(at_cindy_l3)
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
	 (:action move_evelyn_l1_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(connected_l1_l1)
		)
	    :effect (and
			(at_evelyn_l1)
			(not (at_evelyn_l1))
		)
	)
	 (:action move_evelyn_l1_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(connected_l1_l2)
		)
	    :effect (and
			(at_evelyn_l2)
			(not (at_evelyn_l1))
		)
	)
	 (:action move_evelyn_l1_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(connected_l1_l3)
		)
	    :effect (and
			(at_evelyn_l3)
			(not (at_evelyn_l1))
		)
	)
	 (:action move_evelyn_l2_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(connected_l2_l1)
		)
	    :effect (and
			(at_evelyn_l1)
			(not (at_evelyn_l2))
		)
	)
	 (:action move_evelyn_l2_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(connected_l2_l2)
		)
	    :effect (and
			(at_evelyn_l2)
			(not (at_evelyn_l2))
		)
	)
	 (:action move_evelyn_l2_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(connected_l2_l3)
		)
	    :effect (and
			(at_evelyn_l3)
			(not (at_evelyn_l2))
		)
	)
	 (:action move_evelyn_l3_l1
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(connected_l3_l1)
		)
	    :effect (and
			(at_evelyn_l1)
			(not (at_evelyn_l3))
		)
	)
	 (:action move_evelyn_l3_l2
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(connected_l3_l2)
		)
	    :effect (and
			(at_evelyn_l2)
			(not (at_evelyn_l3))
		)
	)
	 (:action move_evelyn_l3_l3
	    :derive-condition always
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(connected_l3_l3)
		)
	    :effect (and
			(at_evelyn_l3)
			(not (at_evelyn_l3))
		)
	)
	 (:action share_alice_alice_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(Balice_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_alice))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l1)) (Bcindy_secret_alice))
			(when (and (at_derek_l1)) (Bderek_secret_alice))
			(when (and (at_alice_l1)) (Balice_secret_alice))
		)
	)
	 (:action share_alice_alice_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(Balice_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_alice))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l2)) (Bcindy_secret_alice))
			(when (and (at_derek_l2)) (Bderek_secret_alice))
			(when (and (at_alice_l2)) (Balice_secret_alice))
		)
	)
	 (:action share_alice_alice_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(Balice_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_alice))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l3)) (Bcindy_secret_alice))
			(when (and (at_derek_l3)) (Bderek_secret_alice))
			(when (and (at_alice_l3)) (Balice_secret_alice))
		)
	)
	 (:action share_alice_bob_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(Balice_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_bob))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l1)) (Bcindy_secret_bob))
			(when (and (at_derek_l1)) (Bderek_secret_bob))
			(when (and (at_alice_l1)) (Balice_secret_bob))
		)
	)
	 (:action share_alice_bob_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(Balice_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_bob))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l2)) (Bcindy_secret_bob))
			(when (and (at_derek_l2)) (Bderek_secret_bob))
			(when (and (at_alice_l2)) (Balice_secret_bob))
		)
	)
	 (:action share_alice_bob_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(Balice_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_bob))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l3)) (Bcindy_secret_bob))
			(when (and (at_derek_l3)) (Bderek_secret_bob))
			(when (and (at_alice_l3)) (Balice_secret_bob))
		)
	)
	 (:action share_alice_cindy_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(Balice_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l1)) (Bcindy_secret_cindy))
			(when (and (at_derek_l1)) (Bderek_secret_cindy))
			(when (and (at_alice_l1)) (Balice_secret_cindy))
		)
	)
	 (:action share_alice_cindy_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(Balice_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l2)) (Bcindy_secret_cindy))
			(when (and (at_derek_l2)) (Bderek_secret_cindy))
			(when (and (at_alice_l2)) (Balice_secret_cindy))
		)
	)
	 (:action share_alice_cindy_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(Balice_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l3)) (Bcindy_secret_cindy))
			(when (and (at_derek_l3)) (Bderek_secret_cindy))
			(when (and (at_alice_l3)) (Balice_secret_cindy))
		)
	)
	 (:action share_alice_derek_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(Balice_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_derek))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l1)) (Bcindy_secret_derek))
			(when (and (at_derek_l1)) (Bderek_secret_derek))
			(when (and (at_alice_l1)) (Balice_secret_derek))
		)
	)
	 (:action share_alice_derek_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(Balice_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_derek))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l2)) (Bcindy_secret_derek))
			(when (and (at_derek_l2)) (Bderek_secret_derek))
			(when (and (at_alice_l2)) (Balice_secret_derek))
		)
	)
	 (:action share_alice_derek_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(Balice_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_derek))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l3)) (Bcindy_secret_derek))
			(when (and (at_derek_l3)) (Bderek_secret_derek))
			(when (and (at_alice_l3)) (Balice_secret_derek))
		)
	)
	 (:action share_alice_evelyn_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(Balice_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l1)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l1)) (Bderek_secret_evelyn))
			(when (and (at_alice_l1)) (Balice_secret_evelyn))
		)
	)
	 (:action share_alice_evelyn_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(Balice_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l2)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l2)) (Bderek_secret_evelyn))
			(when (and (at_alice_l2)) (Balice_secret_evelyn))
		)
	)
	 (:action share_alice_evelyn_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(Balice_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l3)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l3)) (Bderek_secret_evelyn))
			(when (and (at_alice_l3)) (Balice_secret_evelyn))
		)
	)
	 (:action share_bob_alice_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(Bbob_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_alice))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l1)) (Bcindy_secret_alice))
			(when (and (at_derek_l1)) (Bderek_secret_alice))
			(when (and (at_alice_l1)) (Balice_secret_alice))
		)
	)
	 (:action share_bob_alice_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(Bbob_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_alice))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l2)) (Bcindy_secret_alice))
			(when (and (at_derek_l2)) (Bderek_secret_alice))
			(when (and (at_alice_l2)) (Balice_secret_alice))
		)
	)
	 (:action share_bob_alice_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(Bbob_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_alice))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l3)) (Bcindy_secret_alice))
			(when (and (at_derek_l3)) (Bderek_secret_alice))
			(when (and (at_alice_l3)) (Balice_secret_alice))
		)
	)
	 (:action share_bob_bob_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(Bbob_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_bob))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l1)) (Bcindy_secret_bob))
			(when (and (at_derek_l1)) (Bderek_secret_bob))
			(when (and (at_alice_l1)) (Balice_secret_bob))
		)
	)
	 (:action share_bob_bob_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(Bbob_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_bob))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l2)) (Bcindy_secret_bob))
			(when (and (at_derek_l2)) (Bderek_secret_bob))
			(when (and (at_alice_l2)) (Balice_secret_bob))
		)
	)
	 (:action share_bob_bob_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(Bbob_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_bob))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l3)) (Bcindy_secret_bob))
			(when (and (at_derek_l3)) (Bderek_secret_bob))
			(when (and (at_alice_l3)) (Balice_secret_bob))
		)
	)
	 (:action share_bob_cindy_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(Bbob_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l1)) (Bcindy_secret_cindy))
			(when (and (at_derek_l1)) (Bderek_secret_cindy))
			(when (and (at_alice_l1)) (Balice_secret_cindy))
		)
	)
	 (:action share_bob_cindy_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(Bbob_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l2)) (Bcindy_secret_cindy))
			(when (and (at_derek_l2)) (Bderek_secret_cindy))
			(when (and (at_alice_l2)) (Balice_secret_cindy))
		)
	)
	 (:action share_bob_cindy_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(Bbob_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l3)) (Bcindy_secret_cindy))
			(when (and (at_derek_l3)) (Bderek_secret_cindy))
			(when (and (at_alice_l3)) (Balice_secret_cindy))
		)
	)
	 (:action share_bob_derek_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(Bbob_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_derek))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l1)) (Bcindy_secret_derek))
			(when (and (at_derek_l1)) (Bderek_secret_derek))
			(when (and (at_alice_l1)) (Balice_secret_derek))
		)
	)
	 (:action share_bob_derek_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(Bbob_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_derek))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l2)) (Bcindy_secret_derek))
			(when (and (at_derek_l2)) (Bderek_secret_derek))
			(when (and (at_alice_l2)) (Balice_secret_derek))
		)
	)
	 (:action share_bob_derek_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(Bbob_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_derek))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l3)) (Bcindy_secret_derek))
			(when (and (at_derek_l3)) (Bderek_secret_derek))
			(when (and (at_alice_l3)) (Balice_secret_derek))
		)
	)
	 (:action share_bob_evelyn_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(Bbob_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l1)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l1)) (Bderek_secret_evelyn))
			(when (and (at_alice_l1)) (Balice_secret_evelyn))
		)
	)
	 (:action share_bob_evelyn_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(Bbob_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l2)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l2)) (Bderek_secret_evelyn))
			(when (and (at_alice_l2)) (Balice_secret_evelyn))
		)
	)
	 (:action share_bob_evelyn_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(Bbob_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l3)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l3)) (Bderek_secret_evelyn))
			(when (and (at_alice_l3)) (Balice_secret_evelyn))
		)
	)
	 (:action share_cindy_alice_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(Bcindy_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_alice))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l1)) (Bcindy_secret_alice))
			(when (and (at_derek_l1)) (Bderek_secret_alice))
			(when (and (at_alice_l1)) (Balice_secret_alice))
		)
	)
	 (:action share_cindy_alice_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(Bcindy_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_alice))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l2)) (Bcindy_secret_alice))
			(when (and (at_derek_l2)) (Bderek_secret_alice))
			(when (and (at_alice_l2)) (Balice_secret_alice))
		)
	)
	 (:action share_cindy_alice_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(Bcindy_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_alice))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l3)) (Bcindy_secret_alice))
			(when (and (at_derek_l3)) (Bderek_secret_alice))
			(when (and (at_alice_l3)) (Balice_secret_alice))
		)
	)
	 (:action share_cindy_bob_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(Bcindy_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_bob))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l1)) (Bcindy_secret_bob))
			(when (and (at_derek_l1)) (Bderek_secret_bob))
			(when (and (at_alice_l1)) (Balice_secret_bob))
		)
	)
	 (:action share_cindy_bob_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(Bcindy_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_bob))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l2)) (Bcindy_secret_bob))
			(when (and (at_derek_l2)) (Bderek_secret_bob))
			(when (and (at_alice_l2)) (Balice_secret_bob))
		)
	)
	 (:action share_cindy_bob_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(Bcindy_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_bob))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l3)) (Bcindy_secret_bob))
			(when (and (at_derek_l3)) (Bderek_secret_bob))
			(when (and (at_alice_l3)) (Balice_secret_bob))
		)
	)
	 (:action share_cindy_cindy_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(Bcindy_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l1)) (Bcindy_secret_cindy))
			(when (and (at_derek_l1)) (Bderek_secret_cindy))
			(when (and (at_alice_l1)) (Balice_secret_cindy))
		)
	)
	 (:action share_cindy_cindy_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(Bcindy_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l2)) (Bcindy_secret_cindy))
			(when (and (at_derek_l2)) (Bderek_secret_cindy))
			(when (and (at_alice_l2)) (Balice_secret_cindy))
		)
	)
	 (:action share_cindy_cindy_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(Bcindy_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l3)) (Bcindy_secret_cindy))
			(when (and (at_derek_l3)) (Bderek_secret_cindy))
			(when (and (at_alice_l3)) (Balice_secret_cindy))
		)
	)
	 (:action share_cindy_derek_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(Bcindy_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_derek))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l1)) (Bcindy_secret_derek))
			(when (and (at_derek_l1)) (Bderek_secret_derek))
			(when (and (at_alice_l1)) (Balice_secret_derek))
		)
	)
	 (:action share_cindy_derek_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(Bcindy_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_derek))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l2)) (Bcindy_secret_derek))
			(when (and (at_derek_l2)) (Bderek_secret_derek))
			(when (and (at_alice_l2)) (Balice_secret_derek))
		)
	)
	 (:action share_cindy_derek_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(Bcindy_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_derek))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l3)) (Bcindy_secret_derek))
			(when (and (at_derek_l3)) (Bderek_secret_derek))
			(when (and (at_alice_l3)) (Balice_secret_derek))
		)
	)
	 (:action share_cindy_evelyn_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(Bcindy_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l1)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l1)) (Bderek_secret_evelyn))
			(when (and (at_alice_l1)) (Balice_secret_evelyn))
		)
	)
	 (:action share_cindy_evelyn_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(Bcindy_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l2)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l2)) (Bderek_secret_evelyn))
			(when (and (at_alice_l2)) (Balice_secret_evelyn))
		)
	)
	 (:action share_cindy_evelyn_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(Bcindy_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l3)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l3)) (Bderek_secret_evelyn))
			(when (and (at_alice_l3)) (Balice_secret_evelyn))
		)
	)
	 (:action share_derek_alice_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(Bderek_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_alice))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l1)) (Bcindy_secret_alice))
			(when (and (at_derek_l1)) (Bderek_secret_alice))
			(when (and (at_alice_l1)) (Balice_secret_alice))
		)
	)
	 (:action share_derek_alice_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(Bderek_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_alice))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l2)) (Bcindy_secret_alice))
			(when (and (at_derek_l2)) (Bderek_secret_alice))
			(when (and (at_alice_l2)) (Balice_secret_alice))
		)
	)
	 (:action share_derek_alice_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(Bderek_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_alice))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l3)) (Bcindy_secret_alice))
			(when (and (at_derek_l3)) (Bderek_secret_alice))
			(when (and (at_alice_l3)) (Balice_secret_alice))
		)
	)
	 (:action share_derek_bob_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(Bderek_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_bob))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l1)) (Bcindy_secret_bob))
			(when (and (at_derek_l1)) (Bderek_secret_bob))
			(when (and (at_alice_l1)) (Balice_secret_bob))
		)
	)
	 (:action share_derek_bob_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(Bderek_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_bob))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l2)) (Bcindy_secret_bob))
			(when (and (at_derek_l2)) (Bderek_secret_bob))
			(when (and (at_alice_l2)) (Balice_secret_bob))
		)
	)
	 (:action share_derek_bob_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(Bderek_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_bob))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l3)) (Bcindy_secret_bob))
			(when (and (at_derek_l3)) (Bderek_secret_bob))
			(when (and (at_alice_l3)) (Balice_secret_bob))
		)
	)
	 (:action share_derek_cindy_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(Bderek_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l1)) (Bcindy_secret_cindy))
			(when (and (at_derek_l1)) (Bderek_secret_cindy))
			(when (and (at_alice_l1)) (Balice_secret_cindy))
		)
	)
	 (:action share_derek_cindy_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(Bderek_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l2)) (Bcindy_secret_cindy))
			(when (and (at_derek_l2)) (Bderek_secret_cindy))
			(when (and (at_alice_l2)) (Balice_secret_cindy))
		)
	)
	 (:action share_derek_cindy_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(Bderek_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l3)) (Bcindy_secret_cindy))
			(when (and (at_derek_l3)) (Bderek_secret_cindy))
			(when (and (at_alice_l3)) (Balice_secret_cindy))
		)
	)
	 (:action share_derek_derek_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(Bderek_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_derek))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l1)) (Bcindy_secret_derek))
			(when (and (at_derek_l1)) (Bderek_secret_derek))
			(when (and (at_alice_l1)) (Balice_secret_derek))
		)
	)
	 (:action share_derek_derek_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(Bderek_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_derek))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l2)) (Bcindy_secret_derek))
			(when (and (at_derek_l2)) (Bderek_secret_derek))
			(when (and (at_alice_l2)) (Balice_secret_derek))
		)
	)
	 (:action share_derek_derek_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(Bderek_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_derek))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l3)) (Bcindy_secret_derek))
			(when (and (at_derek_l3)) (Bderek_secret_derek))
			(when (and (at_alice_l3)) (Balice_secret_derek))
		)
	)
	 (:action share_derek_evelyn_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(Bderek_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l1)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l1)) (Bderek_secret_evelyn))
			(when (and (at_alice_l1)) (Balice_secret_evelyn))
		)
	)
	 (:action share_derek_evelyn_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(Bderek_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l2)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l2)) (Bderek_secret_evelyn))
			(when (and (at_alice_l2)) (Balice_secret_evelyn))
		)
	)
	 (:action share_derek_evelyn_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_derek_l3)
			(Bderek_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l3)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l3)) (Bderek_secret_evelyn))
			(when (and (at_alice_l3)) (Balice_secret_evelyn))
		)
	)
	 (:action share_evelyn_alice_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(Bevelyn_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_alice))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l1)) (Bcindy_secret_alice))
			(when (and (at_derek_l1)) (Bderek_secret_alice))
			(when (and (at_alice_l1)) (Balice_secret_alice))
		)
	)
	 (:action share_evelyn_alice_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(Bevelyn_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_alice))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l2)) (Bcindy_secret_alice))
			(when (and (at_derek_l2)) (Bderek_secret_alice))
			(when (and (at_alice_l2)) (Balice_secret_alice))
		)
	)
	 (:action share_evelyn_alice_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(Bevelyn_secret_alice)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_alice))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_alice))
			(when (and (at_cindy_l3)) (Bcindy_secret_alice))
			(when (and (at_derek_l3)) (Bderek_secret_alice))
			(when (and (at_alice_l3)) (Balice_secret_alice))
		)
	)
	 (:action share_evelyn_bob_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(Bevelyn_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_bob))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l1)) (Bcindy_secret_bob))
			(when (and (at_derek_l1)) (Bderek_secret_bob))
			(when (and (at_alice_l1)) (Balice_secret_bob))
		)
	)
	 (:action share_evelyn_bob_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(Bevelyn_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_bob))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l2)) (Bcindy_secret_bob))
			(when (and (at_derek_l2)) (Bderek_secret_bob))
			(when (and (at_alice_l2)) (Balice_secret_bob))
		)
	)
	 (:action share_evelyn_bob_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(Bevelyn_secret_bob)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_bob))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_bob))
			(when (and (at_cindy_l3)) (Bcindy_secret_bob))
			(when (and (at_derek_l3)) (Bderek_secret_bob))
			(when (and (at_alice_l3)) (Balice_secret_bob))
		)
	)
	 (:action share_evelyn_cindy_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(Bevelyn_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l1)) (Bcindy_secret_cindy))
			(when (and (at_derek_l1)) (Bderek_secret_cindy))
			(when (and (at_alice_l1)) (Balice_secret_cindy))
		)
	)
	 (:action share_evelyn_cindy_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(Bevelyn_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l2)) (Bcindy_secret_cindy))
			(when (and (at_derek_l2)) (Bderek_secret_cindy))
			(when (and (at_alice_l2)) (Balice_secret_cindy))
		)
	)
	 (:action share_evelyn_cindy_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(Bevelyn_secret_cindy)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_cindy))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_cindy))
			(when (and (at_cindy_l3)) (Bcindy_secret_cindy))
			(when (and (at_derek_l3)) (Bderek_secret_cindy))
			(when (and (at_alice_l3)) (Balice_secret_cindy))
		)
	)
	 (:action share_evelyn_derek_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(Bevelyn_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_derek))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l1)) (Bcindy_secret_derek))
			(when (and (at_derek_l1)) (Bderek_secret_derek))
			(when (and (at_alice_l1)) (Balice_secret_derek))
		)
	)
	 (:action share_evelyn_derek_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(Bevelyn_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_derek))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l2)) (Bcindy_secret_derek))
			(when (and (at_derek_l2)) (Bderek_secret_derek))
			(when (and (at_alice_l2)) (Balice_secret_derek))
		)
	)
	 (:action share_evelyn_derek_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(Bevelyn_secret_derek)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_derek))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_derek))
			(when (and (at_cindy_l3)) (Bcindy_secret_derek))
			(when (and (at_derek_l3)) (Bderek_secret_derek))
			(when (and (at_alice_l3)) (Balice_secret_derek))
		)
	)
	 (:action share_evelyn_evelyn_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(Bevelyn_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l1)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l1)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l1)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l1)) (Bderek_secret_evelyn))
			(when (and (at_alice_l1)) (Balice_secret_evelyn))
		)
	)
	 (:action share_evelyn_evelyn_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(Bevelyn_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l2)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l2)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l2)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l2)) (Bderek_secret_evelyn))
			(when (and (at_alice_l2)) (Balice_secret_evelyn))
		)
	)
	 (:action share_evelyn_evelyn_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l3)
			(Bevelyn_secret_evelyn)
		)
	    :effect (and
			(when (and (at_bob_l3)) (Bbob_secret_evelyn))
			(when (and (at_evelyn_l3)) (Bevelyn_secret_evelyn))
			(when (and (at_cindy_l3)) (Bcindy_secret_evelyn))
			(when (and (at_derek_l3)) (Bderek_secret_evelyn))
			(when (and (at_alice_l3)) (Balice_secret_evelyn))
		)
	)
)