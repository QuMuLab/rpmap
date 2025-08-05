
(define (domain bdi)
    (:requirements :typing)
    (:agents a b)
    (:types
        loc - object
    )
    (:predicates
    	(secret ?agent)
    )
    (:action share
       :derive-condition never
        :parameters (?a1 - agent ?a2 - agent ?l - loc)
        :precondition (and (at ?a1 ?l) (at ?a2 ?l) ![b,?a1](secret ?a1))
        :effect (and [d,?a2](secret ?a2) [i,?a2](secret ?a2))
    )
)
