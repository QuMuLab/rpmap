(define (problem depth_2_agents_2)
	(:domain grapevine)
	(:requirements :disjunctive-preconditions :typing)
	(:objects l1 l2 - loc)
	(:init 
		(BEL_bob_DES_bob_secret_bob)
		(BEL_alice_DES_alice_secret_alice)
	)
	(:goal 
		(secret_alice)
	)
)