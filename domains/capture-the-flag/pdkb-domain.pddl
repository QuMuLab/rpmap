(define (domain capture_the_flag)
	(:requirements :typing)
	(:agents alice bob cindy)
	(:types
	    agent loc
	)
	(:predicates
		(connected_l2_l1)
		(hiding-at_alice_l3)
		(at_bob_l1)
		(defender_cindy)
		(at_bob_l3)
		(hiding-spot-at_l1)
		(hiding-at_cindy_l1)
		(at_bob_l2)
		(connected_l3_l3)
		(at_cindy_l1)
		(hiding-at_alice_l1)
		(flag-at_l2)
		(connected_l2_l2)
		(caught_bob)
		(holding-flag_bob)
		(scout_cindy)
		(connected_l1_l3)
		(capturer_bob)
		(connected_l2_l3)
		(hiding-spot-at_l3)
		(hiding-spot-at_l2)
		(scout_alice)
		(connected_l1_l1)
		(at_alice_l1)
		(capture-win)
		(at_cindy_l2)
		(home-base_l1)
		(hiding-at_cindy_l3)
		(hiding-at_alice_l2)
		(at_alice_l3)
		(home-base_l2)
		(hiding-at_cindy_l2)
		(hiding-at_bob_l2)
		(defender_bob)
		(flag-at_l1)
		(at_cindy_l3)
		(capturer_alice)
		(caught_cindy)
		(hiding-at_bob_l1)
		(capturer_cindy)
		(scout_bob)
		(connected_l3_l2)
		(defender_alice)
		(hiding-at_bob_l3)
		(connected_l1_l2)
		(connected_l3_l1)
		(at_alice_l2)
		(flag-at_l3)
		(caught_alice)
		(home-base_l3)
		(holding-flag_alice)
		(holding-flag_cindy)
	)
	(:action capture-win_alice_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(holding-flag_alice)
			(at_alice_l1)
			(not (caught_alice))
			(home-base_l1)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_alice_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(holding-flag_alice)
			(at_alice_l2)
			(not (caught_alice))
			(home-base_l2)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_alice_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(holding-flag_alice)
			(at_alice_l3)
			(not (caught_alice))
			(home-base_l3)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_bob_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(holding-flag_bob)
			(at_bob_l1)
			(not (caught_bob))
			(home-base_l1)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_bob_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(holding-flag_bob)
			(at_bob_l2)
			(not (caught_bob))
			(home-base_l2)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_bob_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(holding-flag_bob)
			(at_bob_l3)
			(not (caught_bob))
			(home-base_l3)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_cindy_l1
	    :derive-condition (at$agent$l1)
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(holding-flag_cindy)
			(at_cindy_l1)
			(not (caught_cindy))
			(home-base_l1)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_cindy_l2
	    :derive-condition (at$agent$l2)
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(holding-flag_cindy)
			(at_cindy_l2)
			(not (caught_cindy))
			(home-base_l2)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action capture-win_cindy_l3
	    :derive-condition (at$agent$l3)
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(holding-flag_cindy)
			(at_cindy_l3)
			(not (caught_cindy))
			(home-base_l3)
		)
	    :effect (and
			(capture-win)
		)
	)
	 (:action find-flag_alice_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(flag-at_l1)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action find-flag_alice_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(flag-at_l2)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action find-flag_alice_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(flag-at_l3)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action find-flag_bob_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(flag-at_l1)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action find-flag_bob_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(flag-at_l2)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action find-flag_bob_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(flag-at_l3)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action find-flag_cindy_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(flag-at_l1)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action find-flag_cindy_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(flag-at_l2)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action find-flag_cindy_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(flag-at_l3)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action find-hiding-spot_alice_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(hiding-spot-at_l1)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action find-hiding-spot_alice_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(hiding-spot-at_l2)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action find-hiding-spot_alice_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(hiding-spot-at_l3)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action find-hiding-spot_bob_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(hiding-spot-at_l1)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action find-hiding-spot_bob_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(hiding-spot-at_l2)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action find-hiding-spot_bob_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(hiding-spot-at_l3)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action find-hiding-spot_cindy_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(hiding-spot-at_l1)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action find-hiding-spot_cindy_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(hiding-spot-at_l2)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action find-hiding-spot_cindy_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(hiding-spot-at_l3)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action grab-flag_alice_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(flag-at_l1)
			(at_alice_l1)
			(not (caught_alice))
			(Balice_flag-at_l1)
		)
	    :effect (and
			(not_flag-at_l1)
			(holding-flag_alice)
		)
	)
	 (:action grab-flag_alice_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(flag-at_l2)
			(at_alice_l2)
			(not (caught_alice))
			(Balice_flag-at_l2)
		)
	    :effect (and
			(not_flag-at_l2)
			(holding-flag_alice)
		)
	)
	 (:action grab-flag_alice_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(flag-at_l3)
			(at_alice_l3)
			(not (caught_alice))
			(Balice_flag-at_l3)
		)
	    :effect (and
			(not_flag-at_l3)
			(holding-flag_alice)
		)
	)
	 (:action grab-flag_bob_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(flag-at_l1)
			(at_bob_l1)
			(not (caught_bob))
			(Bbob_flag-at_l1)
		)
	    :effect (and
			(not_flag-at_l1)
			(holding-flag_bob)
		)
	)
	 (:action grab-flag_bob_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(flag-at_l2)
			(at_bob_l2)
			(not (caught_bob))
			(Bbob_flag-at_l2)
		)
	    :effect (and
			(not_flag-at_l2)
			(holding-flag_bob)
		)
	)
	 (:action grab-flag_bob_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(flag-at_l3)
			(at_bob_l3)
			(not (caught_bob))
			(Bbob_flag-at_l3)
		)
	    :effect (and
			(not_flag-at_l3)
			(holding-flag_bob)
		)
	)
	 (:action grab-flag_cindy_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(flag-at_l1)
			(at_cindy_l1)
			(not (caught_cindy))
			(Bcindy_flag-at_l1)
		)
	    :effect (and
			(not_flag-at_l1)
			(holding-flag_cindy)
		)
	)
	 (:action grab-flag_cindy_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(flag-at_l2)
			(at_cindy_l2)
			(not (caught_cindy))
			(Bcindy_flag-at_l2)
		)
	    :effect (and
			(not_flag-at_l2)
			(holding-flag_cindy)
		)
	)
	 (:action grab-flag_cindy_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(flag-at_l3)
			(at_cindy_l3)
			(not (caught_cindy))
			(Bcindy_flag-at_l3)
		)
	    :effect (and
			(not_flag-at_l3)
			(holding-flag_cindy)
		)
	)
	 (:action hide_alice_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l1)
			(connected_l1_l1)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l1)
			(at_alice_l2)
			(connected_l1_l2)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l1)
			(at_alice_l3)
			(connected_l1_l3)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l2)
			(at_alice_l1)
			(connected_l2_l1)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l2)
			(connected_l2_l2)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l2)
			(at_alice_l3)
			(connected_l2_l3)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l3)
			(at_alice_l1)
			(connected_l3_l1)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l3)
			(at_alice_l2)
			(connected_l3_l2)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_alice)
			(not (caught_alice))
			(at_alice_l3)
			(connected_l3_l3)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l1)
			(at_bob_l1)
			(connected_l1_l1)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l1)
			(at_bob_l2)
			(connected_l1_l2)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l1)
			(at_bob_l3)
			(connected_l1_l3)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l2)
			(at_bob_l1)
			(connected_l2_l1)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l2)
			(at_bob_l2)
			(connected_l2_l2)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l2)
			(at_bob_l3)
			(connected_l2_l3)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l3)
			(at_bob_l1)
			(connected_l3_l1)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l3)
			(at_bob_l2)
			(connected_l3_l2)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_bob)
			(not (caught_alice))
			(at_alice_l3)
			(at_bob_l3)
			(connected_l3_l3)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l1)
			(at_cindy_l1)
			(connected_l1_l1)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l1)
			(at_cindy_l2)
			(connected_l1_l2)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l1)
			(at_cindy_l3)
			(connected_l1_l3)
			(Balice_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_alice_l1)
		)
	)
	 (:action hide_alice_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l2)
			(at_cindy_l1)
			(connected_l2_l1)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l2)
			(at_cindy_l2)
			(connected_l2_l2)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l2)
			(at_cindy_l3)
			(connected_l2_l3)
			(Balice_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_alice_l2)
		)
	)
	 (:action hide_alice_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l3)
			(at_cindy_l1)
			(connected_l3_l1)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l3)
			(at_cindy_l2)
			(connected_l3_l2)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_alice_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_alice)
			(defender_cindy)
			(not (caught_alice))
			(at_alice_l3)
			(at_cindy_l3)
			(connected_l3_l3)
			(Balice_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_alice_l3)
		)
	)
	 (:action hide_bob_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l1)
			(at_alice_l1)
			(connected_l1_l1)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l1)
			(at_alice_l2)
			(connected_l1_l2)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l1)
			(at_alice_l3)
			(connected_l1_l3)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l2)
			(at_alice_l1)
			(connected_l2_l1)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l2)
			(at_alice_l2)
			(connected_l2_l2)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l2)
			(at_alice_l3)
			(connected_l2_l3)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l3)
			(at_alice_l1)
			(connected_l3_l1)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l3)
			(at_alice_l2)
			(connected_l3_l2)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_alice)
			(not (caught_bob))
			(at_bob_l3)
			(at_alice_l3)
			(connected_l3_l3)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l1)
			(connected_l1_l1)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l1)
			(at_bob_l2)
			(connected_l1_l2)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l1)
			(at_bob_l3)
			(connected_l1_l3)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l2)
			(at_bob_l1)
			(connected_l2_l1)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l2)
			(connected_l2_l2)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l2)
			(at_bob_l3)
			(connected_l2_l3)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l3)
			(at_bob_l1)
			(connected_l3_l1)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l3)
			(at_bob_l2)
			(connected_l3_l2)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_bob)
			(not (caught_bob))
			(at_bob_l3)
			(connected_l3_l3)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l1)
			(at_cindy_l1)
			(connected_l1_l1)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l1)
			(at_cindy_l2)
			(connected_l1_l2)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l1)
			(at_cindy_l3)
			(connected_l1_l3)
			(Bbob_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_bob_l1)
		)
	)
	 (:action hide_bob_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l2)
			(at_cindy_l1)
			(connected_l2_l1)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l2)
			(at_cindy_l2)
			(connected_l2_l2)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l2)
			(at_cindy_l3)
			(connected_l2_l3)
			(Bbob_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_bob_l2)
		)
	)
	 (:action hide_bob_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l3)
			(at_cindy_l1)
			(connected_l3_l1)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l3)
			(at_cindy_l2)
			(connected_l3_l2)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_bob_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_bob)
			(defender_cindy)
			(not (caught_bob))
			(at_bob_l3)
			(at_cindy_l3)
			(connected_l3_l3)
			(Bbob_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_bob_l3)
		)
	)
	 (:action hide_cindy_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_alice_l1)
			(connected_l1_l1)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_alice_l2)
			(connected_l1_l2)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_alice_l3)
			(connected_l1_l3)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_alice_l1)
			(connected_l2_l1)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_alice_l2)
			(connected_l2_l2)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_alice_l3)
			(connected_l2_l3)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_alice_l1)
			(connected_l3_l1)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_alice_l2)
			(connected_l3_l2)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_alice)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_alice_l3)
			(connected_l3_l3)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_bob_l1)
			(connected_l1_l1)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_bob_l2)
			(connected_l1_l2)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_bob_l3)
			(connected_l1_l3)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_bob_l1)
			(connected_l2_l1)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_bob_l2)
			(connected_l2_l2)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_bob_l3)
			(connected_l2_l3)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_bob_l1)
			(connected_l3_l1)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_bob_l2)
			(connected_l3_l2)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_bob)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_bob_l3)
			(connected_l3_l3)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l1)
			(connected_l1_l1)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_cindy_l2)
			(connected_l1_l2)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l1)
			(at_cindy_l3)
			(connected_l1_l3)
			(Bcindy_hiding-spot-at_l1)
		)
	    :effect (and
			(hiding-at_cindy_l1)
		)
	)
	 (:action hide_cindy_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_cindy_l1)
			(connected_l2_l1)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l2)
			(connected_l2_l2)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l2)
			(at_cindy_l3)
			(connected_l2_l3)
			(Bcindy_hiding-spot-at_l2)
		)
	    :effect (and
			(hiding-at_cindy_l2)
		)
	)
	 (:action hide_cindy_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_cindy_l1)
			(connected_l3_l1)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l3)
			(at_cindy_l2)
			(connected_l3_l2)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action hide_cindy_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(capturer_cindy)
			(defender_cindy)
			(not (caught_cindy))
			(at_cindy_l3)
			(connected_l3_l3)
			(Bcindy_hiding-spot-at_l3)
		)
	    :effect (and
			(hiding-at_cindy_l3)
		)
	)
	 (:action move_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(connected_l1_l1)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l1)
			(not (at_alice_l1))
			(when (and (hiding-at_alice_l1)) (not (hiding-at_alice_l1)))
		)
	)
	 (:action move_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(connected_l1_l2)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l2)
			(not (at_alice_l1))
			(when (and (hiding-at_alice_l1)) (not (hiding-at_alice_l1)))
		)
	)
	 (:action move_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l1)
			(connected_l1_l3)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l3)
			(not (at_alice_l1))
			(when (and (hiding-at_alice_l1)) (not (hiding-at_alice_l1)))
		)
	)
	 (:action move_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(connected_l2_l1)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l1)
			(not (at_alice_l2))
			(when (and (hiding-at_alice_l2)) (not (hiding-at_alice_l2)))
		)
	)
	 (:action move_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(connected_l2_l2)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l2)
			(not (at_alice_l2))
			(when (and (hiding-at_alice_l2)) (not (hiding-at_alice_l2)))
		)
	)
	 (:action move_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l2)
			(connected_l2_l3)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l3)
			(not (at_alice_l2))
			(when (and (hiding-at_alice_l2)) (not (hiding-at_alice_l2)))
		)
	)
	 (:action move_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(connected_l3_l1)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l1)
			(not (at_alice_l3))
			(when (and (hiding-at_alice_l3)) (not (hiding-at_alice_l3)))
		)
	)
	 (:action move_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(connected_l3_l2)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l2)
			(not (at_alice_l3))
			(when (and (hiding-at_alice_l3)) (not (hiding-at_alice_l3)))
		)
	)
	 (:action move_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_alice_l3)
			(connected_l3_l3)
			(not (caught_alice))
		)
	    :effect (and
			(at_alice_l3)
			(not (at_alice_l3))
			(when (and (hiding-at_alice_l3)) (not (hiding-at_alice_l3)))
		)
	)
	 (:action move_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(connected_l1_l1)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l1)
			(not (at_bob_l1))
			(when (and (hiding-at_bob_l1)) (not (hiding-at_bob_l1)))
		)
	)
	 (:action move_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(connected_l1_l2)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l2)
			(not (at_bob_l1))
			(when (and (hiding-at_bob_l1)) (not (hiding-at_bob_l1)))
		)
	)
	 (:action move_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l1)
			(connected_l1_l3)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l3)
			(not (at_bob_l1))
			(when (and (hiding-at_bob_l1)) (not (hiding-at_bob_l1)))
		)
	)
	 (:action move_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(connected_l2_l1)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l1)
			(not (at_bob_l2))
			(when (and (hiding-at_bob_l2)) (not (hiding-at_bob_l2)))
		)
	)
	 (:action move_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(connected_l2_l2)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l2)
			(not (at_bob_l2))
			(when (and (hiding-at_bob_l2)) (not (hiding-at_bob_l2)))
		)
	)
	 (:action move_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l2)
			(connected_l2_l3)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l3)
			(not (at_bob_l2))
			(when (and (hiding-at_bob_l2)) (not (hiding-at_bob_l2)))
		)
	)
	 (:action move_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(connected_l3_l1)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l1)
			(not (at_bob_l3))
			(when (and (hiding-at_bob_l3)) (not (hiding-at_bob_l3)))
		)
	)
	 (:action move_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(connected_l3_l2)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l2)
			(not (at_bob_l3))
			(when (and (hiding-at_bob_l3)) (not (hiding-at_bob_l3)))
		)
	)
	 (:action move_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_bob_l3)
			(connected_l3_l3)
			(not (caught_bob))
		)
	    :effect (and
			(at_bob_l3)
			(not (at_bob_l3))
			(when (and (hiding-at_bob_l3)) (not (hiding-at_bob_l3)))
		)
	)
	 (:action move_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(connected_l1_l1)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l1)
			(not (at_cindy_l1))
			(when (and (hiding-at_cindy_l1)) (not (hiding-at_cindy_l1)))
		)
	)
	 (:action move_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(connected_l1_l2)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l2)
			(not (at_cindy_l1))
			(when (and (hiding-at_cindy_l1)) (not (hiding-at_cindy_l1)))
		)
	)
	 (:action move_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l1)
			(connected_l1_l3)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l3)
			(not (at_cindy_l1))
			(when (and (hiding-at_cindy_l1)) (not (hiding-at_cindy_l1)))
		)
	)
	 (:action move_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(connected_l2_l1)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l1)
			(not (at_cindy_l2))
			(when (and (hiding-at_cindy_l2)) (not (hiding-at_cindy_l2)))
		)
	)
	 (:action move_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(connected_l2_l2)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l2)
			(not (at_cindy_l2))
			(when (and (hiding-at_cindy_l2)) (not (hiding-at_cindy_l2)))
		)
	)
	 (:action move_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l2)
			(connected_l2_l3)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l3)
			(not (at_cindy_l2))
			(when (and (hiding-at_cindy_l2)) (not (hiding-at_cindy_l2)))
		)
	)
	 (:action move_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(connected_l3_l1)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l1)
			(not (at_cindy_l3))
			(when (and (hiding-at_cindy_l3)) (not (hiding-at_cindy_l3)))
		)
	)
	 (:action move_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(connected_l3_l2)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l2)
			(not (at_cindy_l3))
			(when (and (hiding-at_cindy_l3)) (not (hiding-at_cindy_l3)))
		)
	)
	 (:action move_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(at_cindy_l3)
			(connected_l3_l3)
			(not (caught_cindy))
		)
	    :effect (and
			(at_cindy_l3)
			(not (at_cindy_l3))
			(when (and (hiding-at_cindy_l3)) (not (hiding-at_cindy_l3)))
		)
	)
	 (:action scout-find-flag_alice_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(at_alice_l1)
			(flag-at_l1)
			(not (caught_alice))
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action scout-find-flag_alice_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(at_alice_l2)
			(flag-at_l2)
			(not (caught_alice))
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action scout-find-flag_alice_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(at_alice_l3)
			(flag-at_l3)
			(not (caught_alice))
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action scout-find-flag_bob_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(at_bob_l1)
			(flag-at_l1)
			(not (caught_bob))
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action scout-find-flag_bob_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(at_bob_l2)
			(flag-at_l2)
			(not (caught_bob))
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action scout-find-flag_bob_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(at_bob_l3)
			(flag-at_l3)
			(not (caught_bob))
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action scout-find-flag_cindy_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(at_cindy_l1)
			(flag-at_l1)
			(not (caught_cindy))
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action scout-find-flag_cindy_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(at_cindy_l2)
			(flag-at_l2)
			(not (caught_cindy))
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action scout-find-flag_cindy_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(at_cindy_l3)
			(flag-at_l3)
			(not (caught_cindy))
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l1)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l1)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l1)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l2)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l2)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l2)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l3)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l3)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_flag-at_l3)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l1)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l1)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l1)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l2)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l2)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l2)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l3)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l3)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_flag-at_l3)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l1)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l1)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l1)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_alice_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l2)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l2)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l2)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_alice_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l3)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l3)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_alice_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_flag-at_l3)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l1)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l1)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l1)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l2)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l2)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l2)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l3)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l3)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_flag-at_l3)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l1)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l1)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l1)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l2)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l2)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l2)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l3)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l3)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_flag-at_l3)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l1)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l1)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l1)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_bob_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l2)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l2)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l2)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_bob_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l3)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l3)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_bob_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_flag-at_l3)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l1)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l1)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l1)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l2)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l2)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l2)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l3)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l3)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_flag-at_l3)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l1)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l1)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l1)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l2)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l2)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l2)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l3)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l3)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_flag-at_l3)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l1)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l1)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l1)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l1)
		)
	)
	 (:action share-flag-location_cindy_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l2)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l2)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l2)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l2)
		)
	)
	 (:action share-flag-location_cindy_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l3)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l3)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-flag-location_cindy_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_flag-at_l3)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_flag-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l1)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l1)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l1)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l2)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l2)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l2)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l3)
			(not (caught_alice))
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l3)
			(not (caught_alice))
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_alice)
			(Dalice_Balice_hiding-spot-at_l3)
			(not (caught_alice))
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l1)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l1)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l1)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l2)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l2)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l2)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l3)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l3)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_bob)
			(Dalice_Bbob_hiding-spot-at_l3)
			(not (caught_alice))
			(not (caught_bob))
			(at_alice_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l1)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l1)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l1)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l2)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l2)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l2)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l3)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l3)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_alice_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_alice)
			(capturer_cindy)
			(Dalice_Bcindy_hiding-spot-at_l3)
			(not (caught_alice))
			(not (caught_cindy))
			(at_alice_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l1)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l1)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l1)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l2)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l2)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l2)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l3)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l3)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_alice)
			(Dbob_Balice_hiding-spot-at_l3)
			(not (caught_bob))
			(not (caught_alice))
			(at_bob_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l1)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l1)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l1)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l2)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l2)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l2)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l3)
			(not (caught_bob))
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l3)
			(not (caught_bob))
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_bob)
			(Dbob_Bbob_hiding-spot-at_l3)
			(not (caught_bob))
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l1)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l1)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l1)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l2)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l2)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l2)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l3)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l1)
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l3)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l2)
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_bob_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_bob)
			(capturer_cindy)
			(Dbob_Bcindy_hiding-spot-at_l3)
			(not (caught_bob))
			(not (caught_cindy))
			(at_bob_l3)
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l1)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l1)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l1)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l2)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l2)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l2)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l3)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l1)
			(at_alice_l1)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l3)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l2)
			(at_alice_l2)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_alice_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_alice)
			(Dcindy_Balice_hiding-spot-at_l3)
			(not (caught_cindy))
			(not (caught_alice))
			(at_cindy_l3)
			(at_alice_l3)
		)
	    :effect (and
			(Balice_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l1)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l1)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l1)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l2)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l2)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l2)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l3)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l1)
			(at_bob_l1)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l3)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l2)
			(at_bob_l2)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_bob_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_bob)
			(Dcindy_Bbob_hiding-spot-at_l3)
			(not (caught_cindy))
			(not (caught_bob))
			(at_cindy_l3)
			(at_bob_l3)
		)
	    :effect (and
			(Bbob_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l1_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l1)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l1_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l1)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l1_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l1)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l1)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l2_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l2)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l2_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l2)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l2_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l2)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l2)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l3_l1
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l3)
			(not (caught_cindy))
			(at_cindy_l1)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l3_l2
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l3)
			(not (caught_cindy))
			(at_cindy_l2)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
	 (:action share-hiding-spot-location_cindy_cindy_l3_l3
	    :derive-condition never
	    :parameters ()
	    :precondition (and
			(scout_cindy)
			(capturer_cindy)
			(Dcindy_Bcindy_hiding-spot-at_l3)
			(not (caught_cindy))
			(at_cindy_l3)
		)
	    :effect (and
			(Bcindy_hiding-spot-at_l3)
		)
	)
)