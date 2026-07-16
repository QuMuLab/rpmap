(define (domain presidents)
	(:requirements :disjunctive-preconditions :typing :universal-preconditions)
	(:agents alice bob cindy derek evelyn)
	(:types
	    agent loc policy
	)
	(:predicates
		(vote_evelyn_bob)
		(single-issue-voter_bob_education)
		(at_bob_l1)
		(political-policy_bob_education)
		(vote_bob_derek)
		(at_cindy_l2)
		(single-issue-voter_cindy_education)
		(connected_l2_l1)
		(listen_cindy_evelyn)
		(listen_alice_evelyn)
		(political-policy_alice_environment)
		(at_cindy_l1)
		(candidate_derek)
		(vote_evelyn_alice)
		(benefit_environment_cindy)
		(listen_alice_cindy)
		(vote_evelyn_cindy)
		(benefit_education_cindy)
		(at_bob_l2)
		(benefit_environment_alice)
		(vote_bob_bob)
		(political-policy_derek_environment)
		(political-policy_cindy_education)
		(vote_derek_derek)
		(vote_cindy_alice)
		(single-issue-voter_evelyn_environment)
		(candidate_evelyn)
		(at_evelyn_l2)
		(vote_derek_alice)
		(vote_cindy_bob)
		(listen_evelyn_bob)
		(vote_evelyn_evelyn)
		(listen_bob_derek)
		(president_cindy)
		(single-issue-voter_derek_environment)
		(candidate_cindy)
		(single-issue-voter_bob_environment)
		(vote_evelyn_derek)
		(listen_derek_evelyn)
		(listen_derek_cindy)
		(vote_alice_cindy)
		(listen_cindy_derek)
		(political-policy_cindy_environment)
		(candidate_alice)
		(listen_bob_evelyn)
		(president_bob)
		(vote_bob_evelyn)
		(listen_derek_derek)
		(benefit_environment_derek)
		(at_derek_l1)
		(listen_derek_alice)
		(listen_alice_bob)
		(vote_bob_cindy)
		(at_alice_l2)
		(vote_alice_bob)
		(benefit_education_bob)
		(vote_cindy_evelyn)
		(listen_evelyn_evelyn)
		(political-policy_alice_education)
		(single-issue-voter_cindy_environment)
		(single-issue-voter_derek_education)
		(vote_derek_bob)
		(vote_derek_evelyn)
		(benefit_education_derek)
		(vote_alice_alice)
		(benefit_environment_bob)
		(political-policy_evelyn_environment)
		(listen_alice_derek)
		(connected_l2_l2)
		(vote_alice_derek)
		(president_evelyn)
		(listen_bob_alice)
		(benefit_education_alice)
		(listen_evelyn_derek)
		(listen_bob_cindy)
		(vote_derek_cindy)
		(vote_cindy_cindy)
		(president_alice)
		(political-policy_bob_environment)
		(benefit_education_evelyn)
		(vote_cindy_derek)
		(connected_l1_l1)
		(listen_evelyn_cindy)
		(connected_l1_l2)
		(single-issue-voter_evelyn_education)
		(listen_derek_bob)
		(at_derek_l2)
		(vote_alice_evelyn)
		(political-policy_derek_education)
		(president_derek)
		(political-policy_evelyn_education)
		(benefit_environment_evelyn)
		(at_evelyn_l1)
		(listen_cindy_alice)
		(listen_evelyn_alice)
		(single-issue-voter_alice_education)
		(listen_bob_bob)
		(listen_alice_alice)
		(listen_cindy_cindy)
		(single-issue-voter_alice_environment)
		(at_alice_l1)
		(candidate_bob)
		(listen_cindy_bob)
		(vote_bob_alice)
	)
	(:action adopt-desire-for-policy_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_alice)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_alice)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_alice)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_alice)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_bob)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_bob)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_bob)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_bob)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_cindy)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_cindy)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_cindy)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_cindy)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_derek)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_derek)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_derek)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_derek)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_evelyn)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_alice)
			(candidate_evelyn)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_evelyn)
			(at_alice_l1)
		)
	    :effect (and
			(DESalice_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_alice)
			(candidate_evelyn)
			(at_alice_l2)
		)
	    :effect (and
			(DESalice_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_alice)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_alice)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_alice)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_alice)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_bob)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_bob)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_bob)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_bob)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_cindy)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_cindy)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_cindy)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_cindy)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_derek)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_derek)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_derek)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_derek)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_evelyn)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_bob)
			(candidate_evelyn)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_evelyn)
			(at_bob_l1)
		)
	    :effect (and
			(DESbob_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_bob)
			(candidate_evelyn)
			(at_bob_l2)
		)
	    :effect (and
			(DESbob_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_alice)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_alice)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_alice)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_alice)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_bob)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_bob)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_bob)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_bob)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_cindy)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_cindy)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_cindy)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_cindy)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_derek)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_derek)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_derek)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_derek)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_evelyn)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_cindy)
			(candidate_evelyn)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_evelyn)
			(at_cindy_l1)
		)
	    :effect (and
			(DEScindy_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_cindy)
			(candidate_evelyn)
			(at_cindy_l2)
		)
	    :effect (and
			(DEScindy_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_alice)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_alice)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_alice)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_alice)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_bob)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_bob)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_bob)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_bob)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_cindy)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_cindy)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_cindy)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_cindy)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_derek)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_derek)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_derek)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_derek)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_evelyn)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_derek)
			(candidate_evelyn)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_evelyn)
			(at_derek_l1)
		)
	    :effect (and
			(DESderek_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_derek)
			(candidate_evelyn)
			(at_derek_l2)
		)
	    :effect (and
			(DESderek_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_alice)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_alice)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_alice_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_alice)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_alice)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_alice_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_bob)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_bob)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_bob_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_bob)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_bob)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_bob_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_cindy)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_cindy)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_cindy_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_cindy)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_cindy)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_cindy_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_derek)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_derek)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_derek_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_derek)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_derek)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_derek_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_evelyn)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_education_evelyn)
			(candidate_evelyn)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_evelyn_education)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_evelyn)
			(at_evelyn_l1)
		)
	    :effect (and
			(DESevelyn_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-desire-for-policy_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(benefit_environment_evelyn)
			(candidate_evelyn)
			(at_evelyn_l2)
		)
	    :effect (and
			(DESevelyn_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_alice)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_alice)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_alice)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_alice)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_bob)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_bob)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_bob)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_bob)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_cindy)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_cindy)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_cindy)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_cindy)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_derek)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_derek)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_derek)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_derek)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_evelyn)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_alice))
			(candidate_evelyn)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_evelyn)
			(at_alice_l1)
		)
	    :effect (and
			(DISalice_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_alice))
			(candidate_evelyn)
			(at_alice_l2)
		)
	    :effect (and
			(DISalice_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_alice)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_alice)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_alice)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_alice)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_bob)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_bob)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_bob)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_bob)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_cindy)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_cindy)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_cindy)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_cindy)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_derek)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_derek)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_derek)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_derek)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_evelyn)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_bob))
			(candidate_evelyn)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_evelyn)
			(at_bob_l1)
		)
	    :effect (and
			(DISbob_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_bob))
			(candidate_evelyn)
			(at_bob_l2)
		)
	    :effect (and
			(DISbob_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_alice)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_alice)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_alice)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_alice)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_bob)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_bob)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_bob)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_bob)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_cindy)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_cindy)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_cindy)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_cindy)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_derek)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_derek)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_derek)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_derek)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_evelyn)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_cindy))
			(candidate_evelyn)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_evelyn)
			(at_cindy_l1)
		)
	    :effect (and
			(DIScindy_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_cindy))
			(candidate_evelyn)
			(at_cindy_l2)
		)
	    :effect (and
			(DIScindy_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_alice)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_alice)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_alice)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_alice)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_bob)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_bob)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_bob)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_bob)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_cindy)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_cindy)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_cindy)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_cindy)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_derek)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_derek)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_derek)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_derek)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_evelyn)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_derek))
			(candidate_evelyn)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_evelyn)
			(at_derek_l1)
		)
	    :effect (and
			(DISderek_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_derek))
			(candidate_evelyn)
			(at_derek_l2)
		)
	    :effect (and
			(DISderek_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_alice)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_alice)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_alice_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_alice)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_alice)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_alice_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_bob)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_bob)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_bob_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_bob)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_bob)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_bob_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_cindy)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_cindy)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_cindy_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_cindy)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_cindy)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_cindy_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_derek)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_derek)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_derek_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_derek)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_derek)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_derek_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_evelyn)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_education_evelyn))
			(candidate_evelyn)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_evelyn_education)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_evelyn)
			(at_evelyn_l1)
		)
	    :effect (and
			(DISevelyn_political-policy_evelyn_environment)
		)
	)
	 (:action adopt-disdain-for-policy_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(not (benefit_environment_evelyn))
			(candidate_evelyn)
			(at_evelyn_l2)
		)
	    :effect (and
			(DISevelyn_political-policy_evelyn_environment)
		)
	)
	 (:action desire-single-issue-vote_alice_alice_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_alice_education)
			(political-policy_alice_education)
		)
	    :effect (and
			(DESalice_vote_alice_alice)
		)
	)
	 (:action desire-single-issue-vote_alice_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_alice_environment)
			(political-policy_alice_environment)
		)
	    :effect (and
			(DESalice_vote_alice_alice)
		)
	)
	 (:action desire-single-issue-vote_alice_bob_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_alice_education)
			(political-policy_bob_education)
		)
	    :effect (and
			(DESalice_vote_alice_bob)
		)
	)
	 (:action desire-single-issue-vote_alice_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_alice_environment)
			(political-policy_bob_environment)
		)
	    :effect (and
			(DESalice_vote_alice_bob)
		)
	)
	 (:action desire-single-issue-vote_alice_cindy_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_alice_education)
			(political-policy_cindy_education)
		)
	    :effect (and
			(DESalice_vote_alice_cindy)
		)
	)
	 (:action desire-single-issue-vote_alice_cindy_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_alice_environment)
			(political-policy_cindy_environment)
		)
	    :effect (and
			(DESalice_vote_alice_cindy)
		)
	)
	 (:action desire-single-issue-vote_alice_derek_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_alice_education)
			(political-policy_derek_education)
		)
	    :effect (and
			(DESalice_vote_alice_derek)
		)
	)
	 (:action desire-single-issue-vote_alice_derek_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_alice_environment)
			(political-policy_derek_environment)
		)
	    :effect (and
			(DESalice_vote_alice_derek)
		)
	)
	 (:action desire-single-issue-vote_alice_evelyn_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_alice_education)
			(political-policy_evelyn_education)
		)
	    :effect (and
			(DESalice_vote_alice_evelyn)
		)
	)
	 (:action desire-single-issue-vote_alice_evelyn_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_alice_environment)
			(political-policy_evelyn_environment)
		)
	    :effect (and
			(DESalice_vote_alice_evelyn)
		)
	)
	 (:action desire-single-issue-vote_bob_alice_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_bob_education)
			(political-policy_alice_education)
		)
	    :effect (and
			(DESbob_vote_bob_alice)
		)
	)
	 (:action desire-single-issue-vote_bob_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_bob_environment)
			(political-policy_alice_environment)
		)
	    :effect (and
			(DESbob_vote_bob_alice)
		)
	)
	 (:action desire-single-issue-vote_bob_bob_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_bob_education)
			(political-policy_bob_education)
		)
	    :effect (and
			(DESbob_vote_bob_bob)
		)
	)
	 (:action desire-single-issue-vote_bob_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_bob_environment)
			(political-policy_bob_environment)
		)
	    :effect (and
			(DESbob_vote_bob_bob)
		)
	)
	 (:action desire-single-issue-vote_bob_cindy_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_bob_education)
			(political-policy_cindy_education)
		)
	    :effect (and
			(DESbob_vote_bob_cindy)
		)
	)
	 (:action desire-single-issue-vote_bob_cindy_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_bob_environment)
			(political-policy_cindy_environment)
		)
	    :effect (and
			(DESbob_vote_bob_cindy)
		)
	)
	 (:action desire-single-issue-vote_bob_derek_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_bob_education)
			(political-policy_derek_education)
		)
	    :effect (and
			(DESbob_vote_bob_derek)
		)
	)
	 (:action desire-single-issue-vote_bob_derek_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_bob_environment)
			(political-policy_derek_environment)
		)
	    :effect (and
			(DESbob_vote_bob_derek)
		)
	)
	 (:action desire-single-issue-vote_bob_evelyn_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_bob_education)
			(political-policy_evelyn_education)
		)
	    :effect (and
			(DESbob_vote_bob_evelyn)
		)
	)
	 (:action desire-single-issue-vote_bob_evelyn_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_bob_environment)
			(political-policy_evelyn_environment)
		)
	    :effect (and
			(DESbob_vote_bob_evelyn)
		)
	)
	 (:action desire-single-issue-vote_cindy_alice_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_cindy_education)
			(political-policy_alice_education)
		)
	    :effect (and
			(DEScindy_vote_cindy_alice)
		)
	)
	 (:action desire-single-issue-vote_cindy_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_cindy_environment)
			(political-policy_alice_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_alice)
		)
	)
	 (:action desire-single-issue-vote_cindy_bob_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_cindy_education)
			(political-policy_bob_education)
		)
	    :effect (and
			(DEScindy_vote_cindy_bob)
		)
	)
	 (:action desire-single-issue-vote_cindy_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_cindy_environment)
			(political-policy_bob_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_bob)
		)
	)
	 (:action desire-single-issue-vote_cindy_cindy_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_cindy_education)
			(political-policy_cindy_education)
		)
	    :effect (and
			(DEScindy_vote_cindy_cindy)
		)
	)
	 (:action desire-single-issue-vote_cindy_cindy_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_cindy_environment)
			(political-policy_cindy_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_cindy)
		)
	)
	 (:action desire-single-issue-vote_cindy_derek_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_cindy_education)
			(political-policy_derek_education)
		)
	    :effect (and
			(DEScindy_vote_cindy_derek)
		)
	)
	 (:action desire-single-issue-vote_cindy_derek_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_cindy_environment)
			(political-policy_derek_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_derek)
		)
	)
	 (:action desire-single-issue-vote_cindy_evelyn_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_cindy_education)
			(political-policy_evelyn_education)
		)
	    :effect (and
			(DEScindy_vote_cindy_evelyn)
		)
	)
	 (:action desire-single-issue-vote_cindy_evelyn_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_cindy_environment)
			(political-policy_evelyn_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_evelyn)
		)
	)
	 (:action desire-single-issue-vote_derek_alice_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_derek_education)
			(political-policy_alice_education)
		)
	    :effect (and
			(DESderek_vote_derek_alice)
		)
	)
	 (:action desire-single-issue-vote_derek_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_derek_environment)
			(political-policy_alice_environment)
		)
	    :effect (and
			(DESderek_vote_derek_alice)
		)
	)
	 (:action desire-single-issue-vote_derek_bob_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_derek_education)
			(political-policy_bob_education)
		)
	    :effect (and
			(DESderek_vote_derek_bob)
		)
	)
	 (:action desire-single-issue-vote_derek_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_derek_environment)
			(political-policy_bob_environment)
		)
	    :effect (and
			(DESderek_vote_derek_bob)
		)
	)
	 (:action desire-single-issue-vote_derek_cindy_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_derek_education)
			(political-policy_cindy_education)
		)
	    :effect (and
			(DESderek_vote_derek_cindy)
		)
	)
	 (:action desire-single-issue-vote_derek_cindy_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_derek_environment)
			(political-policy_cindy_environment)
		)
	    :effect (and
			(DESderek_vote_derek_cindy)
		)
	)
	 (:action desire-single-issue-vote_derek_derek_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_derek_education)
			(political-policy_derek_education)
		)
	    :effect (and
			(DESderek_vote_derek_derek)
		)
	)
	 (:action desire-single-issue-vote_derek_derek_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_derek_environment)
			(political-policy_derek_environment)
		)
	    :effect (and
			(DESderek_vote_derek_derek)
		)
	)
	 (:action desire-single-issue-vote_derek_evelyn_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_derek_education)
			(political-policy_evelyn_education)
		)
	    :effect (and
			(DESderek_vote_derek_evelyn)
		)
	)
	 (:action desire-single-issue-vote_derek_evelyn_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_derek_environment)
			(political-policy_evelyn_environment)
		)
	    :effect (and
			(DESderek_vote_derek_evelyn)
		)
	)
	 (:action desire-single-issue-vote_evelyn_alice_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_evelyn_education)
			(political-policy_alice_education)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_alice)
		)
	)
	 (:action desire-single-issue-vote_evelyn_alice_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(single-issue-voter_evelyn_environment)
			(political-policy_alice_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_alice)
		)
	)
	 (:action desire-single-issue-vote_evelyn_bob_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_evelyn_education)
			(political-policy_bob_education)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_bob)
		)
	)
	 (:action desire-single-issue-vote_evelyn_bob_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(single-issue-voter_evelyn_environment)
			(political-policy_bob_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_bob)
		)
	)
	 (:action desire-single-issue-vote_evelyn_cindy_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_evelyn_education)
			(political-policy_cindy_education)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_cindy)
		)
	)
	 (:action desire-single-issue-vote_evelyn_cindy_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(single-issue-voter_evelyn_environment)
			(political-policy_cindy_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_cindy)
		)
	)
	 (:action desire-single-issue-vote_evelyn_derek_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_evelyn_education)
			(political-policy_derek_education)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_derek)
		)
	)
	 (:action desire-single-issue-vote_evelyn_derek_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(single-issue-voter_evelyn_environment)
			(political-policy_derek_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_derek)
		)
	)
	 (:action desire-single-issue-vote_evelyn_evelyn_education
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_evelyn_education)
			(political-policy_evelyn_education)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_evelyn)
		)
	)
	 (:action desire-single-issue-vote_evelyn_evelyn_environment
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(single-issue-voter_evelyn_environment)
			(political-policy_evelyn_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_evelyn)
		)
	)
	 (:action desire-vote_alice_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESalice_political-policy_alice_education)
			(DESalice_political-policy_alice_environment)
		)
	    :effect (and
			(DESalice_vote_alice_alice)
			(when (and (not (candidate_derek))) (DESalice_DESderek_vote_derek_alice))
			(when (and (not (candidate_cindy))) (DESalice_DEScindy_vote_cindy_alice))
			(when (and (not (candidate_bob))) (DESalice_DESbob_vote_bob_alice))
			(when (and (not (candidate_evelyn))) (DESalice_DESevelyn_vote_evelyn_alice))
			(when (and (not (candidate_alice))) (DESalice_DESalice_vote_alice_alice))
		)
	)
	 (:action desire-vote_alice_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESalice_political-policy_bob_education)
			(DESalice_political-policy_bob_environment)
		)
	    :effect (and
			(DESalice_vote_alice_bob)
			(when (and (not (candidate_derek))) (DESalice_DESderek_vote_derek_bob))
			(when (and (not (candidate_cindy))) (DESalice_DEScindy_vote_cindy_bob))
			(when (and (not (candidate_bob))) (DESalice_DESbob_vote_bob_bob))
			(when (and (not (candidate_evelyn))) (DESalice_DESevelyn_vote_evelyn_bob))
			(when (and (not (candidate_alice))) (DESalice_DESalice_vote_alice_bob))
		)
	)
	 (:action desire-vote_alice_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESalice_political-policy_cindy_education)
			(DESalice_political-policy_cindy_environment)
		)
	    :effect (and
			(DESalice_vote_alice_cindy)
			(when (and (not (candidate_derek))) (DESalice_DESderek_vote_derek_cindy))
			(when (and (not (candidate_cindy))) (DESalice_DEScindy_vote_cindy_cindy))
			(when (and (not (candidate_bob))) (DESalice_DESbob_vote_bob_cindy))
			(when (and (not (candidate_evelyn))) (DESalice_DESevelyn_vote_evelyn_cindy))
			(when (and (not (candidate_alice))) (DESalice_DESalice_vote_alice_cindy))
		)
	)
	 (:action desire-vote_alice_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESalice_political-policy_derek_education)
			(DESalice_political-policy_derek_environment)
		)
	    :effect (and
			(DESalice_vote_alice_derek)
			(when (and (not (candidate_derek))) (DESalice_DESderek_vote_derek_derek))
			(when (and (not (candidate_cindy))) (DESalice_DEScindy_vote_cindy_derek))
			(when (and (not (candidate_bob))) (DESalice_DESbob_vote_bob_derek))
			(when (and (not (candidate_evelyn))) (DESalice_DESevelyn_vote_evelyn_derek))
			(when (and (not (candidate_alice))) (DESalice_DESalice_vote_alice_derek))
		)
	)
	 (:action desire-vote_alice_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESalice_political-policy_evelyn_education)
			(DESalice_political-policy_evelyn_environment)
		)
	    :effect (and
			(DESalice_vote_alice_evelyn)
			(when (and (not (candidate_derek))) (DESalice_DESderek_vote_derek_evelyn))
			(when (and (not (candidate_cindy))) (DESalice_DEScindy_vote_cindy_evelyn))
			(when (and (not (candidate_bob))) (DESalice_DESbob_vote_bob_evelyn))
			(when (and (not (candidate_evelyn))) (DESalice_DESevelyn_vote_evelyn_evelyn))
			(when (and (not (candidate_alice))) (DESalice_DESalice_vote_alice_evelyn))
		)
	)
	 (:action desire-vote_bob_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESbob_political-policy_alice_education)
			(DESbob_political-policy_alice_environment)
		)
	    :effect (and
			(DESbob_vote_bob_alice)
			(when (and (not (candidate_derek))) (DESbob_DESderek_vote_derek_alice))
			(when (and (not (candidate_cindy))) (DESbob_DEScindy_vote_cindy_alice))
			(when (and (not (candidate_bob))) (DESbob_DESbob_vote_bob_alice))
			(when (and (not (candidate_evelyn))) (DESbob_DESevelyn_vote_evelyn_alice))
			(when (and (not (candidate_alice))) (DESbob_DESalice_vote_alice_alice))
		)
	)
	 (:action desire-vote_bob_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESbob_political-policy_bob_education)
			(DESbob_political-policy_bob_environment)
		)
	    :effect (and
			(DESbob_vote_bob_bob)
			(when (and (not (candidate_derek))) (DESbob_DESderek_vote_derek_bob))
			(when (and (not (candidate_cindy))) (DESbob_DEScindy_vote_cindy_bob))
			(when (and (not (candidate_bob))) (DESbob_DESbob_vote_bob_bob))
			(when (and (not (candidate_evelyn))) (DESbob_DESevelyn_vote_evelyn_bob))
			(when (and (not (candidate_alice))) (DESbob_DESalice_vote_alice_bob))
		)
	)
	 (:action desire-vote_bob_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESbob_political-policy_cindy_education)
			(DESbob_political-policy_cindy_environment)
		)
	    :effect (and
			(DESbob_vote_bob_cindy)
			(when (and (not (candidate_derek))) (DESbob_DESderek_vote_derek_cindy))
			(when (and (not (candidate_cindy))) (DESbob_DEScindy_vote_cindy_cindy))
			(when (and (not (candidate_bob))) (DESbob_DESbob_vote_bob_cindy))
			(when (and (not (candidate_evelyn))) (DESbob_DESevelyn_vote_evelyn_cindy))
			(when (and (not (candidate_alice))) (DESbob_DESalice_vote_alice_cindy))
		)
	)
	 (:action desire-vote_bob_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESbob_political-policy_derek_education)
			(DESbob_political-policy_derek_environment)
		)
	    :effect (and
			(DESbob_vote_bob_derek)
			(when (and (not (candidate_derek))) (DESbob_DESderek_vote_derek_derek))
			(when (and (not (candidate_cindy))) (DESbob_DEScindy_vote_cindy_derek))
			(when (and (not (candidate_bob))) (DESbob_DESbob_vote_bob_derek))
			(when (and (not (candidate_evelyn))) (DESbob_DESevelyn_vote_evelyn_derek))
			(when (and (not (candidate_alice))) (DESbob_DESalice_vote_alice_derek))
		)
	)
	 (:action desire-vote_bob_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESbob_political-policy_evelyn_education)
			(DESbob_political-policy_evelyn_environment)
		)
	    :effect (and
			(DESbob_vote_bob_evelyn)
			(when (and (not (candidate_derek))) (DESbob_DESderek_vote_derek_evelyn))
			(when (and (not (candidate_cindy))) (DESbob_DEScindy_vote_cindy_evelyn))
			(when (and (not (candidate_bob))) (DESbob_DESbob_vote_bob_evelyn))
			(when (and (not (candidate_evelyn))) (DESbob_DESevelyn_vote_evelyn_evelyn))
			(when (and (not (candidate_alice))) (DESbob_DESalice_vote_alice_evelyn))
		)
	)
	 (:action desire-vote_cindy_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DEScindy_political-policy_alice_education)
			(DEScindy_political-policy_alice_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_alice)
			(when (and (not (candidate_derek))) (DEScindy_DESderek_vote_derek_alice))
			(when (and (not (candidate_cindy))) (DEScindy_DEScindy_vote_cindy_alice))
			(when (and (not (candidate_bob))) (DEScindy_DESbob_vote_bob_alice))
			(when (and (not (candidate_evelyn))) (DEScindy_DESevelyn_vote_evelyn_alice))
			(when (and (not (candidate_alice))) (DEScindy_DESalice_vote_alice_alice))
		)
	)
	 (:action desire-vote_cindy_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DEScindy_political-policy_bob_education)
			(DEScindy_political-policy_bob_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_bob)
			(when (and (not (candidate_derek))) (DEScindy_DESderek_vote_derek_bob))
			(when (and (not (candidate_cindy))) (DEScindy_DEScindy_vote_cindy_bob))
			(when (and (not (candidate_bob))) (DEScindy_DESbob_vote_bob_bob))
			(when (and (not (candidate_evelyn))) (DEScindy_DESevelyn_vote_evelyn_bob))
			(when (and (not (candidate_alice))) (DEScindy_DESalice_vote_alice_bob))
		)
	)
	 (:action desire-vote_cindy_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DEScindy_political-policy_cindy_education)
			(DEScindy_political-policy_cindy_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_cindy)
			(when (and (not (candidate_derek))) (DEScindy_DESderek_vote_derek_cindy))
			(when (and (not (candidate_cindy))) (DEScindy_DEScindy_vote_cindy_cindy))
			(when (and (not (candidate_bob))) (DEScindy_DESbob_vote_bob_cindy))
			(when (and (not (candidate_evelyn))) (DEScindy_DESevelyn_vote_evelyn_cindy))
			(when (and (not (candidate_alice))) (DEScindy_DESalice_vote_alice_cindy))
		)
	)
	 (:action desire-vote_cindy_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DEScindy_political-policy_derek_education)
			(DEScindy_political-policy_derek_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_derek)
			(when (and (not (candidate_derek))) (DEScindy_DESderek_vote_derek_derek))
			(when (and (not (candidate_cindy))) (DEScindy_DEScindy_vote_cindy_derek))
			(when (and (not (candidate_bob))) (DEScindy_DESbob_vote_bob_derek))
			(when (and (not (candidate_evelyn))) (DEScindy_DESevelyn_vote_evelyn_derek))
			(when (and (not (candidate_alice))) (DEScindy_DESalice_vote_alice_derek))
		)
	)
	 (:action desire-vote_cindy_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DEScindy_political-policy_evelyn_education)
			(DEScindy_political-policy_evelyn_environment)
		)
	    :effect (and
			(DEScindy_vote_cindy_evelyn)
			(when (and (not (candidate_derek))) (DEScindy_DESderek_vote_derek_evelyn))
			(when (and (not (candidate_cindy))) (DEScindy_DEScindy_vote_cindy_evelyn))
			(when (and (not (candidate_bob))) (DEScindy_DESbob_vote_bob_evelyn))
			(when (and (not (candidate_evelyn))) (DEScindy_DESevelyn_vote_evelyn_evelyn))
			(when (and (not (candidate_alice))) (DEScindy_DESalice_vote_alice_evelyn))
		)
	)
	 (:action desire-vote_derek_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESderek_political-policy_alice_education)
			(DESderek_political-policy_alice_environment)
		)
	    :effect (and
			(DESderek_vote_derek_alice)
			(when (and (not (candidate_derek))) (DESderek_DESderek_vote_derek_alice))
			(when (and (not (candidate_cindy))) (DESderek_DEScindy_vote_cindy_alice))
			(when (and (not (candidate_bob))) (DESderek_DESbob_vote_bob_alice))
			(when (and (not (candidate_evelyn))) (DESderek_DESevelyn_vote_evelyn_alice))
			(when (and (not (candidate_alice))) (DESderek_DESalice_vote_alice_alice))
		)
	)
	 (:action desire-vote_derek_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESderek_political-policy_bob_education)
			(DESderek_political-policy_bob_environment)
		)
	    :effect (and
			(DESderek_vote_derek_bob)
			(when (and (not (candidate_derek))) (DESderek_DESderek_vote_derek_bob))
			(when (and (not (candidate_cindy))) (DESderek_DEScindy_vote_cindy_bob))
			(when (and (not (candidate_bob))) (DESderek_DESbob_vote_bob_bob))
			(when (and (not (candidate_evelyn))) (DESderek_DESevelyn_vote_evelyn_bob))
			(when (and (not (candidate_alice))) (DESderek_DESalice_vote_alice_bob))
		)
	)
	 (:action desire-vote_derek_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESderek_political-policy_cindy_education)
			(DESderek_political-policy_cindy_environment)
		)
	    :effect (and
			(DESderek_vote_derek_cindy)
			(when (and (not (candidate_derek))) (DESderek_DESderek_vote_derek_cindy))
			(when (and (not (candidate_cindy))) (DESderek_DEScindy_vote_cindy_cindy))
			(when (and (not (candidate_bob))) (DESderek_DESbob_vote_bob_cindy))
			(when (and (not (candidate_evelyn))) (DESderek_DESevelyn_vote_evelyn_cindy))
			(when (and (not (candidate_alice))) (DESderek_DESalice_vote_alice_cindy))
		)
	)
	 (:action desire-vote_derek_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESderek_political-policy_derek_education)
			(DESderek_political-policy_derek_environment)
		)
	    :effect (and
			(DESderek_vote_derek_derek)
			(when (and (not (candidate_derek))) (DESderek_DESderek_vote_derek_derek))
			(when (and (not (candidate_cindy))) (DESderek_DEScindy_vote_cindy_derek))
			(when (and (not (candidate_bob))) (DESderek_DESbob_vote_bob_derek))
			(when (and (not (candidate_evelyn))) (DESderek_DESevelyn_vote_evelyn_derek))
			(when (and (not (candidate_alice))) (DESderek_DESalice_vote_alice_derek))
		)
	)
	 (:action desire-vote_derek_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESderek_political-policy_evelyn_education)
			(DESderek_political-policy_evelyn_environment)
		)
	    :effect (and
			(DESderek_vote_derek_evelyn)
			(when (and (not (candidate_derek))) (DESderek_DESderek_vote_derek_evelyn))
			(when (and (not (candidate_cindy))) (DESderek_DEScindy_vote_cindy_evelyn))
			(when (and (not (candidate_bob))) (DESderek_DESbob_vote_bob_evelyn))
			(when (and (not (candidate_evelyn))) (DESderek_DESevelyn_vote_evelyn_evelyn))
			(when (and (not (candidate_alice))) (DESderek_DESalice_vote_alice_evelyn))
		)
	)
	 (:action desire-vote_evelyn_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESevelyn_political-policy_alice_education)
			(DESevelyn_political-policy_alice_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_alice)
			(when (and (not (candidate_derek))) (DESevelyn_DESderek_vote_derek_alice))
			(when (and (not (candidate_cindy))) (DESevelyn_DEScindy_vote_cindy_alice))
			(when (and (not (candidate_bob))) (DESevelyn_DESbob_vote_bob_alice))
			(when (and (not (candidate_evelyn))) (DESevelyn_DESevelyn_vote_evelyn_alice))
			(when (and (not (candidate_alice))) (DESevelyn_DESalice_vote_alice_alice))
		)
	)
	 (:action desire-vote_evelyn_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESevelyn_political-policy_bob_education)
			(DESevelyn_political-policy_bob_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_bob)
			(when (and (not (candidate_derek))) (DESevelyn_DESderek_vote_derek_bob))
			(when (and (not (candidate_cindy))) (DESevelyn_DEScindy_vote_cindy_bob))
			(when (and (not (candidate_bob))) (DESevelyn_DESbob_vote_bob_bob))
			(when (and (not (candidate_evelyn))) (DESevelyn_DESevelyn_vote_evelyn_bob))
			(when (and (not (candidate_alice))) (DESevelyn_DESalice_vote_alice_bob))
		)
	)
	 (:action desire-vote_evelyn_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESevelyn_political-policy_cindy_education)
			(DESevelyn_political-policy_cindy_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_cindy)
			(when (and (not (candidate_derek))) (DESevelyn_DESderek_vote_derek_cindy))
			(when (and (not (candidate_cindy))) (DESevelyn_DEScindy_vote_cindy_cindy))
			(when (and (not (candidate_bob))) (DESevelyn_DESbob_vote_bob_cindy))
			(when (and (not (candidate_evelyn))) (DESevelyn_DESevelyn_vote_evelyn_cindy))
			(when (and (not (candidate_alice))) (DESevelyn_DESalice_vote_alice_cindy))
		)
	)
	 (:action desire-vote_evelyn_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESevelyn_political-policy_derek_education)
			(DESevelyn_political-policy_derek_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_derek)
			(when (and (not (candidate_derek))) (DESevelyn_DESderek_vote_derek_derek))
			(when (and (not (candidate_cindy))) (DESevelyn_DEScindy_vote_cindy_derek))
			(when (and (not (candidate_bob))) (DESevelyn_DESbob_vote_bob_derek))
			(when (and (not (candidate_evelyn))) (DESevelyn_DESevelyn_vote_evelyn_derek))
			(when (and (not (candidate_alice))) (DESevelyn_DESalice_vote_alice_derek))
		)
	)
	 (:action desire-vote_evelyn_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESevelyn_political-policy_evelyn_education)
			(DESevelyn_political-policy_evelyn_environment)
		)
	    :effect (and
			(DESevelyn_vote_evelyn_evelyn)
			(when (and (not (candidate_derek))) (DESevelyn_DESderek_vote_derek_evelyn))
			(when (and (not (candidate_cindy))) (DESevelyn_DEScindy_vote_cindy_evelyn))
			(when (and (not (candidate_bob))) (DESevelyn_DESbob_vote_bob_evelyn))
			(when (and (not (candidate_evelyn))) (DESevelyn_DESevelyn_vote_evelyn_evelyn))
			(when (and (not (candidate_alice))) (DESevelyn_DESalice_vote_alice_evelyn))
		)
	)
	 (:action get-elected_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(vote_derek_alice)
			(vote_cindy_alice)
			(vote_bob_alice)
			(vote_evelyn_alice)
			(vote_alice_alice)
		)
	    :effect (and
			(president_alice)
		)
	)
	 (:action get-elected_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(vote_derek_bob)
			(vote_cindy_bob)
			(vote_bob_bob)
			(vote_evelyn_bob)
			(vote_alice_bob)
		)
	    :effect (and
			(president_bob)
		)
	)
	 (:action get-elected_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(vote_derek_cindy)
			(vote_cindy_cindy)
			(vote_bob_cindy)
			(vote_evelyn_cindy)
			(vote_alice_cindy)
		)
	    :effect (and
			(president_cindy)
		)
	)
	 (:action get-elected_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(vote_derek_derek)
			(vote_cindy_derek)
			(vote_bob_derek)
			(vote_evelyn_derek)
			(vote_alice_derek)
		)
	    :effect (and
			(president_derek)
		)
	)
	 (:action get-elected_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(vote_derek_evelyn)
			(vote_cindy_evelyn)
			(vote_bob_evelyn)
			(vote_evelyn_evelyn)
			(vote_alice_evelyn)
		)
	    :effect (and
			(president_evelyn)
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
	 (:action speak-against-policy_alice_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_alice_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_alice_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_bob_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_bob_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_cindy_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_derek_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_derek_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DISalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DISalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DISalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DISbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DISbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DISbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DIScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DIScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DIScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DISderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DISderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DISderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-against-policy_evelyn_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DISevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DISevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DISevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_alice_education))
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
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_alice_environment))
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
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_bob_education))
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
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_bob_environment))
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
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(DESalice_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(DESalice_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_alice)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_alice)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_alice_education))
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
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_alice_environment))
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
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_bob_education))
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
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_bob_environment))
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
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_bob_l1)
			(DESalice_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_bob_l2)
			(DESalice_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_alice)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_alice)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_cindy_l1)
			(DESalice_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_cindy_l2)
			(DESalice_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_alice)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_alice)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_derek_l1)
			(DESalice_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_derek_l2)
			(DESalice_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_alice)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_alice)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_alice_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(at_evelyn_l1)
			(DESalice_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_alice_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(at_evelyn_l2)
			(DESalice_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_alice)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_alice)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_alice_education))
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
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_alice_environment))
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
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_bob_education))
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
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_bob_environment))
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
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_alice_l1)
			(DESbob_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_alice_l2)
			(DESbob_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_bob)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_bob)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_alice_education))
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
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_alice_environment))
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
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_bob_education))
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
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_bob_environment))
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
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(DESbob_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(DESbob_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_bob)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_bob)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_cindy_l1)
			(DESbob_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_cindy_l2)
			(DESbob_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_bob)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_bob)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_derek_l1)
			(DESbob_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_derek_l2)
			(DESbob_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_bob)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_bob)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_bob_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(at_evelyn_l1)
			(DESbob_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_bob_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(at_evelyn_l2)
			(DESbob_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_bob)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_bob)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_alice_l1)
			(DEScindy_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_alice_l2)
			(DEScindy_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_cindy)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_cindy)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_bob_l1)
			(DEScindy_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_bob_l2)
			(DEScindy_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_cindy)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_cindy)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(DEScindy_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(DEScindy_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_cindy)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_cindy)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_derek_l1)
			(DEScindy_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_derek_l2)
			(DEScindy_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_cindy)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_cindy)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(at_evelyn_l1)
			(DEScindy_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_cindy_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(at_evelyn_l2)
			(DEScindy_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_cindy)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_cindy)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_alice_l1)
			(DESderek_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_alice_l2)
			(DESderek_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_derek)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_derek)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_bob_l1)
			(DESderek_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_bob_l2)
			(DESderek_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_derek)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_derek)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_cindy_l1)
			(DESderek_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_cindy_l2)
			(DESderek_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_derek)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_derek)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(DESderek_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(DESderek_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_derek)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_derek)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_derek_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_derek_l1)
			(at_evelyn_l1)
			(DESderek_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_derek_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_derek_l2)
			(at_evelyn_l2)
			(DESderek_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_derek)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_derek)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_alice_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_alice_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_bob_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_bob_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_cindy_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_cindy_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_derek_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_derek_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_evelyn_education))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_alice_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_alice_l1)
			(DESevelyn_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_alice_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_alice_l2)
			(DESevelyn_DESalice_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESalice_listen_alice_evelyn)) (DESalice_political-policy_evelyn_environment))
			(when (and (DESalice_not_listen_alice_evelyn)) (DESalice_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_alice_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_alice_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_bob_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_bob_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_cindy_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_cindy_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_derek_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_derek_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_evelyn_education))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_bob_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_bob_l1)
			(DESevelyn_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_bob_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_bob_l2)
			(DESevelyn_DESbob_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESbob_listen_bob_evelyn)) (DESbob_political-policy_evelyn_environment))
			(when (and (DESbob_not_listen_bob_evelyn)) (DESbob_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_alice_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_alice_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_bob_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_bob_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_cindy_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_cindy_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_derek_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_derek_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_evelyn_education))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_cindy_l1)
			(DESevelyn_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_cindy_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_cindy_l2)
			(DESevelyn_DEScindy_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DEScindy_listen_cindy_evelyn)) (DEScindy_political-policy_evelyn_environment))
			(when (and (DEScindy_not_listen_cindy_evelyn)) (DEScindy_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_alice_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_alice_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_bob_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_bob_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_cindy_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_cindy_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_derek_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_derek_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_evelyn_education))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_derek_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(at_derek_l1)
			(DESevelyn_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_derek_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(at_derek_l2)
			(DESevelyn_DESderek_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESderek_listen_derek_evelyn)) (DESderek_political-policy_evelyn_environment))
			(when (and (DESderek_not_listen_derek_evelyn)) (DESderek_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_alice_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_alice_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_alice_education)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_alice_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_alice_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_alice_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_alice_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_alice_environment)
			(candidate_alice)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_alice_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_alice_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_bob_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_bob_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_bob_education)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_bob_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_bob_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_bob_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_bob_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_bob_environment)
			(candidate_bob)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_bob_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_bob_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_cindy_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_cindy_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_cindy_education)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_cindy_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_cindy_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_cindy_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_cindy_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_cindy_environment)
			(candidate_cindy)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_cindy_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_cindy_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_derek_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_derek_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_derek_education)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_derek_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_derek_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_derek_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_derek_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_derek_environment)
			(candidate_derek)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_derek_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_derek_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_evelyn_education_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_evelyn_education_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_evelyn_education)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_evelyn_education))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_evelyn_education))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_evelyn_environment_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l1)
			(DESevelyn_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action speak-for-policy_evelyn_evelyn_evelyn_environment_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(at_evelyn_l2)
			(DESevelyn_DESevelyn_political-policy_evelyn_environment)
			(candidate_evelyn)
		)
	    :effect (and
			(when (and (DESevelyn_listen_evelyn_evelyn)) (DESevelyn_political-policy_evelyn_environment))
			(when (and (DESevelyn_not_listen_evelyn_evelyn)) (DESevelyn_not_political-policy_evelyn_environment))
		)
	)
	 (:action vote_alice_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESalice_vote_alice_alice)
		)
	    :effect (and
			(vote_alice_alice)
		)
	)
	 (:action vote_alice_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESalice_vote_alice_bob)
		)
	    :effect (and
			(vote_alice_bob)
		)
	)
	 (:action vote_alice_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESalice_vote_alice_cindy)
		)
	    :effect (and
			(vote_alice_cindy)
		)
	)
	 (:action vote_alice_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESalice_vote_alice_derek)
		)
	    :effect (and
			(vote_alice_derek)
		)
	)
	 (:action vote_alice_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESalice_vote_alice_evelyn)
		)
	    :effect (and
			(vote_alice_evelyn)
		)
	)
	 (:action vote_bob_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESbob_vote_bob_alice)
		)
	    :effect (and
			(vote_bob_alice)
		)
	)
	 (:action vote_bob_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESbob_vote_bob_bob)
		)
	    :effect (and
			(vote_bob_bob)
		)
	)
	 (:action vote_bob_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESbob_vote_bob_cindy)
		)
	    :effect (and
			(vote_bob_cindy)
		)
	)
	 (:action vote_bob_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESbob_vote_bob_derek)
		)
	    :effect (and
			(vote_bob_derek)
		)
	)
	 (:action vote_bob_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESbob_vote_bob_evelyn)
		)
	    :effect (and
			(vote_bob_evelyn)
		)
	)
	 (:action vote_cindy_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DEScindy_vote_cindy_alice)
		)
	    :effect (and
			(vote_cindy_alice)
		)
	)
	 (:action vote_cindy_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DEScindy_vote_cindy_bob)
		)
	    :effect (and
			(vote_cindy_bob)
		)
	)
	 (:action vote_cindy_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DEScindy_vote_cindy_cindy)
		)
	    :effect (and
			(vote_cindy_cindy)
		)
	)
	 (:action vote_cindy_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DEScindy_vote_cindy_derek)
		)
	    :effect (and
			(vote_cindy_derek)
		)
	)
	 (:action vote_cindy_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DEScindy_vote_cindy_evelyn)
		)
	    :effect (and
			(vote_cindy_evelyn)
		)
	)
	 (:action vote_derek_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESderek_vote_derek_alice)
		)
	    :effect (and
			(vote_derek_alice)
		)
	)
	 (:action vote_derek_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESderek_vote_derek_bob)
		)
	    :effect (and
			(vote_derek_bob)
		)
	)
	 (:action vote_derek_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESderek_vote_derek_cindy)
		)
	    :effect (and
			(vote_derek_cindy)
		)
	)
	 (:action vote_derek_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESderek_vote_derek_derek)
		)
	    :effect (and
			(vote_derek_derek)
		)
	)
	 (:action vote_derek_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESderek_vote_derek_evelyn)
		)
	    :effect (and
			(vote_derek_evelyn)
		)
	)
	 (:action vote_evelyn_alice
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_alice)
			(DESevelyn_vote_evelyn_alice)
		)
	    :effect (and
			(vote_evelyn_alice)
		)
	)
	 (:action vote_evelyn_bob
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_bob)
			(DESevelyn_vote_evelyn_bob)
		)
	    :effect (and
			(vote_evelyn_bob)
		)
	)
	 (:action vote_evelyn_cindy
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_cindy)
			(DESevelyn_vote_evelyn_cindy)
		)
	    :effect (and
			(vote_evelyn_cindy)
		)
	)
	 (:action vote_evelyn_derek
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_derek)
			(DESevelyn_vote_evelyn_derek)
		)
	    :effect (and
			(vote_evelyn_derek)
		)
	)
	 (:action vote_evelyn_evelyn
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(candidate_evelyn)
			(DESevelyn_vote_evelyn_evelyn)
		)
	    :effect (and
			(vote_evelyn_evelyn)
		)
	)
)