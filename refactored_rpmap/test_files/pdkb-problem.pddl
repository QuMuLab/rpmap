(define (problem depth_2_agents_2)
	(:domain grapevine)
	(:requirements :disjunctive-preconditions :typing)
	(:objects l1 l2 - loc)
	(:init 
		(BEL_alice_DES_alice_secret_alice)
		(BEL_bob_DES_bob_secret_bob)
	)
	(:goal 
		(not (connected_l1_l2))
		(ITN_bob_move_alice_l1_l2)
		(ITN_alice_move_alice_l1_l2)
	)
)