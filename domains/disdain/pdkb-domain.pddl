(define (domain presidents)
	(:requirements :typing)
	(:agents alice bob)
	(:types
	    agent loc policy
	)
	(:predicates
		(vote_alice_bob)
		(listen_alice_bob)
		(candidate_alice)
		(candidate_bob)
		(listen_bob_alice)
		(connected_l2_l2)
		(benefit_environment_bob)
		(political-policy_alice_environment)
		(listen_bob_bob)
		(at_alice_l2)
		(benefit_environment_alice)
		(vote_alice_alice)
		(connected_l1_l1)
		(political-policy_bob_environment)
		(at_bob_l2)
		(connected_l2_l1)
		(at_alice_l1)
		(at_bob_l1)
		(connected_l1_l2)
		(vote_bob_alice)
		(listen_alice_alice)
		(vote_bob_bob)
	)
	(:action adopt-desire-for-policy_alice_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_alice)
		)
	    :effect (and
			(DESalice_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_bob)
		)
	    :effect (and
			(DESalice_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_alice)
		)
	    :effect (and
			(DESbob_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_bob)
		)
	    :effect (and
			(DESbob_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_alice)
		)
	    :effect (and
			(DISalice_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_bob)
		)
	    :effect (and
			(DISalice_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_alice)
		)
	    :effect (and
			(DISbob_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_bob)
		)
	    :effect (and
			(DISbob_political-policy_bob_environment)
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
	 (:action speak-for-policy_alice_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_alice_environment))
			(when (and (PDESalice_not_listen_alice_alice)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_alice_environment))
			(when (and (PDESalice_not_listen_alice_alice)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_bob_environment))
			(when (and (PDESalice_not_listen_alice_alice)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_bob_environment))
			(when (and (PDESalice_not_listen_alice_alice)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_alice_environment))
			(when (and (PDESbob_not_listen_bob_alice)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_alice_environment))
			(when (and (PDESbob_not_listen_bob_alice)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_bob_environment))
			(when (and (PDESbob_not_listen_bob_alice)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_bob_environment))
			(when (and (PDESbob_not_listen_bob_alice)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_alice_environment))
			(when (and (PDESalice_not_listen_alice_bob)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_alice_environment))
			(when (and (PDESalice_not_listen_alice_bob)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_bob_environment))
			(when (and (PDESalice_not_listen_alice_bob)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_bob_environment))
			(when (and (PDESalice_not_listen_alice_bob)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_alice_environment))
			(when (and (PDESbob_not_listen_bob_bob)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_alice_environment))
			(when (and (PDESbob_not_listen_bob_bob)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_bob_environment))
			(when (and (PDESbob_not_listen_bob_bob)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_bob_environment))
			(when (and (PDESbob_not_listen_bob_bob)) (DESbob_not_political-policy_bob_environment))
		)
	)
)