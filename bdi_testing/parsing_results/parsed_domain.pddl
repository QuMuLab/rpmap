
(define (domain bdi)
	(:requirements :typing)
	(:agents )
	(:types
	    loc - object
	)
	(:anceff kd45closure
		:parameters (?a - agent)
		:cond1
		(
			:poscond ?pos1
			:negcond ?neg1
			:rml [b, ?a](rml)
			:type add
		)
		:cond2
		(
			:poscond ?pos2
			:negcond ?neg2
			:rml <b, ?a>(rml)
			:type add
		)
	)
	(:anceff negation-removal
		:cond1
		(
			:poscond ?pos1
			:negcond ?neg1
			:rml (rml)
			:type add
		)
		:cond2
		(
			:poscond ?pos2
			:negcond ?neg2
			:rml !(rml)
			:type del
		)
	)
	(:anceff kd45-un-closure
		:parameters (?a - agent)
		:cond1
		(
			:poscond ?pos1
			:negcond ?neg1
			:rml <b, ?a>(rml)
			:type del
		)
		:cond2
		(
			:poscond ?pos2
			:negcond ?neg2
			:rml [b, ?a](rml)
			:type del
		)
	)
	(:predicates
		(secret ?agent)
		{AK}(at ?agent - agent ?l - loc)
		{AK}(connected ?l1 - loc ?l2 - loc)
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
