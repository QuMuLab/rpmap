
(define (domain bdi)
	(:requirements :typing)
	(:agents )
	(:types
	    loc - object
	)
	(:predicates
		(secret ?agent)
		{AK}(connected ?l1 - loc ?l2 - loc)
		{AK}(at ?agent - agent ?l - loc)
	)
	(:action move
	    :derive-condition always
	    :parameters (?a - agent ?l1 - loc ?l2 - loc)
	    :precondition (and
			(at ?a ?l1)
			(connected ?l1 ?l2)
		)
	    :effect (and
			(at ?a ?l2)
			(not (at ?a ?l1))
		)
	)
	 (:action share
	    :derive-condition never
	    :parameters (?a1 - agent ?a2 - agent ?l - loc)
	    :precondition (and
			(at ?a1 ?l)
			(at ?a2 ?l)
			![b, ?a1](!secret ?a1)
		)
	    :effect (and
			[d, ?a2](secret ?a2)
			[i, ?a2](secret ?a2)
		)
	)
)
