
(define (domain suspicious_witches)
    (:requirements :typing :universal-preconditions)
    (:agents alice bob cindy)
    (:types
        item loc - object
    )
    (:predicates
    	{AK}(intend-defend-earnestly ?a1 - agent ?a2 - agent ?a3 - agent)
    	{AK}(intend-accuse ?a1 - agent ?a2 - agent)
    	{AK}(desire-defend-threatened ?a1 - agent ?a2 - agent ?a3 - agent)
    	{AK}(desire-accuse-random-accused ?a1 - agent ?a2 - agent)
    	{AK}(connected ?l1 - loc ?l2 - loc)
    	{AK}(fled ?ag - agent)
    	{AK}(desire-accuse-lying-hatred ?a1 - agent ?a2 - agent)
    	{AK}(stealthy ?ag - agent)
    	{AK}(sycophant ?a1 - agent ?a2 - agent)
    	{AK}(influencer ?ag - agent)
    	{AK}(intend-accuse-random-accused ?a1 - agent ?a2 - agent)
    	{AK}(at ?ag - agent ?l - loc)
    	{AK}(cursed ?ag - agent)
    	{AK}(intend-accuse-paranoid ?a1 - agent ?a2 - agent)
    	{AK}(intend-flee ?ag - agent)
    	{AK}(hates ?a1 - agent ?a2 - agent)
    	{AK}(witch-hunting ?a1 - agent ?a2 - agent)
    	(witch ?ag - agent)
    	{AK}(collected ?i - item)
    	{AK}(desire-accuse-paranoid ?a1 - agent ?a2 - agent)
    	(civilian ?ag - agent)
    	(accused-by ?a1 - agent ?a2 - agent)
    	{AK}(item-at ?i - item ?loc - loc)
    	{AK}(desire-flee ?ag - agent)
    	{AK}(intend-accuse-lying-hatred ?a1 - agent ?a2 - agent)
    	{AK}(paranoid ?ag - agent)
    	{AK}(desire-accuse ?a1 - agent ?a2 - agent)
    	{AK}(town-exit ?l - loc)
    	{AK}(executed ?ag - agent)
    	{AK}(desire-defend-earnestly ?a1 - agent ?a2 - agent ?a3 - agent)
    	{AK}(diff ?a1 - agent ?a2 - agent)
    	{AK}(intend-defend-threatened ?a1 - agent ?a2 - agent ?a3 - agent)
    	{AK}(threatened-by ?a1 - agent ?a2 - agent)
    )
    (:action burn-the-witch-three-civ
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent ?a3 - agent ?a4 - agent ?l - loc)
        :precondition (and (diff ?a1 ?a2) (diff ?a1 ?a3) (diff ?a1 ?a4) (diff ?a2 ?a3) (diff ?a2 ?a4) (diff ?a3 ?a4) (at ?a1 ?l) (at ?a2 ?l) (at ?a3 ?l) (at ?a4 ?l) (witch-hunting ?a1 ?a4) (witch-hunting ?a2 ?a4) (witch-hunting ?a3 ?a4))
        :effect (executed ?a4)
    )
     (:action civilian-paranoid-accuse
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent ?l - loc)
        :precondition (and (intend-accuse-paranoid ?a1 ?a2) (at ?a1 ?l))
        :effect (and (accused-by ?a2 ?a1) (forall (?ag - agent) (and (when (at ?ag ?l) [?ag](accused-by ?a2 ?a1)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) !<?ag>(witch ?a1) <?ag>(witch ?a2)) [?ag](witch ?a2)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) !<?ag>(witch ?a1) <?ag>(witch ?a2)) [?ag][?a1](witch ?a2)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) <?ag>(witch ?a1) !<?ag>(witch ?a2)) [?ag](witch ?a1)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) <?ag>(witch ?a1) !<?ag>(witch ?a2)) [?ag][?a1](witch ?a2)) (when (and (at ?ag ?l) (witch ?ag) (diff ?ag ?a2)) [?ag][?a1](witch ?a2)))))
    )
     (:action civilian-whisper-accuse
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent ?a3 - agent ?l - loc)
        :precondition (and (intend-accuse ?a1 ?a3) (at ?a1 ?l) (at ?a2 ?l) (diff ?a1 ?a2) (diff ?a2 ?a3) !<?a1>(witch ?a2))
        :effect (and (accused-by ?a3 ?a1) [?a2](accused-by ?a3 ?a1) [?a1](accused-by ?a3 ?a1) (when (and (civilian ?a2) <?a2>(witch ?a3) !<?a2>(witch ?a1)) [?a2](witch ?a3)) (when (and (civilian ?a2) <?a2>(witch ?a1) !<?a2>(witch ?a3)) [?a2](witch ?a1)) (when (witch ?a2) [?a2][?a1](witch ?a3)))
    )
     (:action collect-item
       :derive-condition never 
        :parameters (?w - agent ?i - item ?l - loc)
        :precondition (and (at ?w ?l) (item-at ?i ?l) (witch ?w) (not (collected ?i)))
        :effect (and (collected ?i) (forall (?ag - agent) (and (when (and (at ?ag ?l) (civilian ?ag) <?ag>(witch ?w)) [?ag](witch ?w)) (when (and (at ?ag ?l) (civilian ?ag) !<?ag>(witch ?w)) <?ag>(witch ?w)) (when (and (at ?ag ?l) (civilian ?ag) (not (stealthy ?ag))) [?w][?ag](witch ?w)))))
    )
     (:action copy-desire-to-accuse
       :derive-condition never 
        :parameters (?syc - agent ?a2 - agent ?acsd - agent ?l - loc)
        :precondition (and (sycophant ?syc ?a2) (civilian ?syc) (at ?syc ?l) (at ?a2 ?l) (diff ?syc ?a2) (diff ?syc ?acsd) (desire-accuse ?a2 ?acsd))
        :effect (and (desire-accuse ?syc ?acsd) [?syc](witch ?acsd))
    )
     (:action copy-desire-to-accuse-accused
       :derive-condition never 
        :parameters (?syc - agent ?a2 - agent ?acsd - agent ?l - loc)
        :precondition (and (sycophant ?syc ?a2) (civilian ?syc) (at ?syc ?l) (at ?a2 ?l) (diff ?syc ?a2) (diff ?syc ?acsd) (desire-accuse-random-accused ?a2 ?acsd))
        :effect (desire-accuse-random-accused ?syc ?acsd)
    )
     (:action copy-desire-to-accuse-lying-hatred
       :derive-condition never 
        :parameters (?syc - agent ?a2 - agent ?acsd - agent ?l - loc)
        :precondition (and (sycophant ?syc ?a2) (civilian ?syc) (at ?syc ?l) (at ?a2 ?l) (diff ?syc ?a2) (diff ?syc ?acsd) (desire-accuse-lying-hatred ?a2 ?acsd))
        :effect (and (desire-accuse-lying-hatred ?syc ?acsd) !<?syc>(witch ?acsd) (hates ?syc ?acsd))
    )
     (:action copy-desire-to-accuse-paranoid
       :derive-condition never 
        :parameters (?syc - agent ?a2 - agent ?acsd - agent ?l - loc)
        :precondition (and (sycophant ?syc ?a2) (civilian ?syc) (at ?syc ?l) (at ?a2 ?l) (diff ?syc ?a2) (diff ?syc ?acsd) (desire-accuse-paranoid ?a2 ?acsd))
        :effect (and (desire-accuse-paranoid ?syc ?acsd) <?syc>(witch ?acsd) ![?syc](witch ?acsd) (paranoid ?syc))
    )
     (:action copy-desire-to-defend-earnestly
       :derive-condition never 
        :parameters (?syc - agent ?a2 - agent ?acsd - agent ?acsr - agent ?l - loc)
        :precondition (and (sycophant ?syc ?a2) (civilian ?syc) (at ?syc ?l) (at ?a2 ?l) (diff ?syc ?a2) (diff ?syc ?acsd) (diff ?syc ?acsr) [?syc](accused-by ?acsd ?acsr) (desire-defend-earnestly ?a2 ?acsd ?acsr))
        :effect (and (desire-defend-earnestly ?syc ?acsd ?acsr) !<?syc>(witch ?acsd))
    )
     (:action copy-desire-to-defend-threatened
       :derive-condition never 
        :parameters (?syc - agent ?a2 - agent ?acsd - agent ?acsr - agent ?l - loc)
        :precondition (and (sycophant ?syc ?a2) (civilian ?syc) (at ?syc ?l) (at ?a2 ?l) (diff ?syc ?a2) (diff ?syc ?acsd) (diff ?syc ?acsr) [?syc](accused-by ?acsd ?acsr) (desire-defend-threatened ?a2 ?acsd ?acsr))
        :effect (desire-defend-threatened ?syc ?acsd ?acsr)
    )
     (:action copy-desire-to-flee
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent ?l - loc)
        :precondition (and (sycophant ?a1 ?a2) (civilian ?a1) (diff ?a1 ?a2) (at ?a1 ?l) (at ?a2 ?l) (desire-flee ?a2))
        :effect (desire-flee ?a1)
    )
     (:action defend-earnestly
       :derive-condition never 
        :parameters (?defender - agent ?acsd - agent ?acsr - agent ?l - loc)
        :precondition (and (intend-defend-earnestly ?defender ?acsd ?acsr) (at ?defender ?l) (at ?acsd ?l))
        :effect (forall (?ag - agent) (and (when (at ?ag ?l) [?ag](accused-by ?acsd ?acsr)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) [?ag](witch ?acsd) <?ag>(witch ?defender)) [?ag](witch ?defender)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) !<?ag>(witch ?acsd) [?ag](witch ?defender)) ![?ag](witch ?defender)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) [?ag](witch ?defender) <?ag>(witch ?acsd)) [?ag](witch ?acsd)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) !<?ag>(witch ?defender) [?ag](witch ?acsd)) ![?ag](witch ?acsd))))
    )
     (:action defend-threatened
       :derive-condition never 
        :parameters (?defender - agent ?acsd - agent ?acsr - agent ?l - loc)
        :precondition (and (intend-defend-threatened ?defender ?acsd ?acsr) (at ?defender ?l) (at ?acsd ?l))
        :effect (forall (?ag - agent) (and (when (at ?ag ?l) [?ag](accused-by ?acsd ?acsr)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) [?ag](witch ?acsd) <?ag>(witch ?defender)) [?ag](witch ?defender)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) !<?ag>(witch ?acsd) [?ag](witch ?defender)) ![?ag](witch ?defender)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) [?ag](witch ?defender) <?ag>(witch ?acsd)) [?ag](witch ?acsd)) (when (and (civilian ?ag) (at ?ag ?l) (diff ?ag ?defender) (diff ?ag ?acsd) !<?ag>(witch ?defender) [?ag](witch ?acsd)) ![?ag](witch ?acsd))))
    )
     (:action desire-flee
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent)
        :precondition (and (civilian ?a1) (threatened-by ?a1 ?a2))
        :effect (desire-flee ?a1)
    )
     (:action desire-to-accuse
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (and (civilian ?a1) (diff ?a1 ?acsd) [?a1](witch ?acsd))
        :effect (desire-accuse ?a1 ?acsd)
    )
     (:action desire-to-accuse-accused
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent ?acsr - agent)
        :precondition (and (diff ?a1 ?acsd) (diff ?a1 ?acsr) (accused-by ?a1 ?acsr) [?a1](accused-by ?a1 ?acsr))
        :effect (desire-accuse-random-accused ?a1 ?acsd)
    )
     (:action desire-to-accuse-lying
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (and (diff ?a1 ?acsd) !<?a1>(witch ?acsd) (hates ?a1 ?acsd))
        :effect (desire-accuse-lying-hatred ?a1 ?acsd)
    )
     (:action desire-to-accuse-paranoid
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (and (civilian ?a1) (diff ?a1 ?acsd) <?a1>(witch ?acsd) ![?a1](witch ?acsd) (paranoid ?a1))
        :effect (desire-accuse-paranoid ?a1 ?acsd)
    )
     (:action desire-to-defend-earnestly
       :derive-condition never 
        :parameters (?defender - agent ?acsd - agent ?acsr - agent)
        :precondition (and !<?defender>(witch ?acsd) (accused-by ?acsd ?acsr) [?defender](accused-by ?acsd ?acsr) (diff ?defender ?acsd) (diff ?defender ?acsr) (diff ?acsd ?acsr))
        :effect (desire-defend-earnestly ?defender ?acsd ?acsr)
    )
     (:action desire-to-defend-threatened
       :derive-condition never 
        :parameters (?defender - agent ?acsd - agent ?acsr - agent)
        :precondition (and (threatened-by ?defender ?acsd) (accused-by ?acsd ?acsr) [?defender](accused-by ?acsd ?acsr) (diff ?defender ?acsd) (diff ?defender ?acsr) (diff ?acsd ?acsr))
        :effect (desire-defend-threatened ?defender ?acsd ?acsr)
    )
     (:action flee
       :derive-condition never 
        :parameters (?a1 - agent ?l - loc)
        :precondition (and (intend-flee ?a1) (at ?a1 ?l) (town-exit ?l))
        :effect (fled ?a1)
    )
     (:action hunt-witch-accused
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent)
        :precondition (and (diff ?a1 ?a2) (intend-accuse-random-accused ?a1 ?a2))
        :effect (witch-hunting ?a1 ?a2)
    )
     (:action hunt-witch-lying-hatred
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent)
        :precondition (and (diff ?a1 ?a2) !<?a1>(witch ?a2) (hates ?a1 ?a2))
        :effect (witch-hunting ?a1 ?a2)
    )
     (:action hunt-witch-paranoid
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent)
        :precondition (and (diff ?a1 ?a2) <?a1>(witch ?a2) (paranoid ?a1))
        :effect (witch-hunting ?a1 ?a2)
    )
     (:action hunt-witch-strong-belief
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent)
        :precondition (and (diff ?a1 ?a2) [?a1](witch ?a2))
        :effect (witch-hunting ?a1 ?a2)
    )
     (:action influence
       :derive-condition never 
        :parameters (?inf - agent ?l - loc)
        :precondition (and (influencer ?inf) (at ?inf ?l))
        :effect (forall (?ag - agent) (when (and (at ?ag ?l) (civilian ?ag)) (sycophant ?ag ?inf)))
    )
     (:action intend-flee
       :derive-condition never 
        :parameters (?a1 - agent)
        :precondition (desire-flee ?a1)
        :effect (intend-flee ?a1)
    )
     (:action intend-to-accuse
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (desire-accuse ?a1 ?acsd)
        :effect (intend-accuse ?a1 ?acsd)
    )
     (:action intend-to-accuse-accused
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (desire-accuse-random-accused ?a1 ?acsd)
        :effect (intend-accuse-random-accused ?a1 ?acsd)
    )
     (:action intend-to-accuse-lying
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (desire-accuse-lying-hatred ?a1 ?acsd)
        :effect (intend-accuse-lying-hatred ?a1 ?acsd)
    )
     (:action intend-to-accuse-paranoid
       :derive-condition never 
        :parameters (?a1 - agent ?acsd - agent)
        :precondition (desire-accuse-paranoid ?a1 ?acsd)
        :effect (intend-accuse-paranoid ?a1 ?acsd)
    )
     (:action intend-to-defend-earnestly
       :derive-condition never 
        :parameters (?defender - agent ?acsd - agent ?acsr - agent)
        :precondition (desire-defend-earnestly ?defender ?acsd ?acsr)
        :effect (intend-defend-earnestly ?defender ?acsd ?acsr)
    )
     (:action intend-to-defend-threatened
       :derive-condition never 
        :parameters (?defender - agent ?acsd - agent ?acsr - agent)
        :precondition (desire-defend-threatened ?defender ?acsd ?acsr)
        :effect (intend-defend-threatened ?defender ?acsd ?acsr)
    )
     (:action lie-accuse-hatred
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent ?l - loc)
        :precondition (and (intend-accuse-lying-hatred ?a1 ?a2) (at ?a1 ?l))
        :effect (and (accused-by ?a2 ?a1) (forall (?ag - agent) (and (when (at ?ag ?l) [?ag](accused-by ?a2 ?a1)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) !<?ag>(witch ?a1) <?ag>(witch ?a2)) [?ag](witch ?a2)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) !<?ag>(witch ?a1) <?ag>(witch ?a2)) [?ag][?a1](witch ?a2)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) <?ag>(witch ?a1) !<?ag>(witch ?a2)) [?ag](witch ?a1)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) <?ag>(witch ?a1) !<?ag>(witch ?a2)) [?ag][?a1](witch ?a2)) (when (and (at ?ag ?l) (witch ?ag) (diff ?ag ?a2)) [?ag][?a1](witch ?a2)))))
    )
     (:action move
       :derive-condition always 
        :parameters (?ag - agent ?l1 - loc ?l2 - loc)
        :precondition (and (at ?ag ?l1) (connected ?l1 ?l2) (not (fled ?ag)))
        :effect (and (at ?ag ?l2) (not (at ?ag ?l1)))
    )
     (:action perform-spell-three
       :derive-condition always 
        :parameters (?l - loc ?w1 - agent ?w2 - agent ?w3 - agent)
        :precondition (and (witch ?w1) (witch ?w2) (witch ?w3) (at ?w1 ?l) (at ?w2 ?l) (at ?w3 ?l) (diff ?w1 ?w2) (diff ?w2 ?w3) (diff ?w1 ?w3) (forall (?i - item) (collected ?i)))
        :effect (forall (?ag - agent) (when (civilian ?ag) (cursed ?ag)))
    )
     (:action random-accuse-accused
       :derive-condition never 
        :parameters (?a1 - agent ?a2 - agent ?l - loc)
        :precondition (and (intend-accuse-random-accused ?a1 ?a2) (at ?a1 ?l))
        :effect (and (accused-by ?a2 ?a1) (forall (?ag - agent) (and (when (at ?ag ?l) [?ag](accused-by ?a2 ?a1)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) !<?ag>(witch ?a1) <?ag>(witch ?a2)) [?ag](witch ?a2)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) !<?ag>(witch ?a1) <?ag>(witch ?a2)) [?ag][?a1](witch ?a2)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) <?ag>(witch ?a1) !<?ag>(witch ?a2)) [?ag](witch ?a1)) (when (and (at ?ag ?l) (civilian ?ag) (diff ?ag ?a1) (diff ?ag ?a2) <?ag>(witch ?a1) !<?ag>(witch ?a2)) [?ag][?a1](witch ?a2)) (when (and (at ?ag ?l) (witch ?ag) (diff ?ag ?a2)) [?ag][?a1](witch ?a2)))))
    )
     (:action witch-inform-witch-accused
       :derive-condition never 
        :parameters (?w1 - agent ?w2 - agent ?acsr - agent ?l - loc)
        :precondition (and (witch ?w1) (witch ?w2) (accused-by ?w2 ?acsr) [?w1](accused-by ?w2 ?acsr) (at ?w1 ?l) (at ?w2 ?l))
        :effect [?w2](accused-by ?w2 ?acsr)
    )
     (:action witch-inform-witch-suspicious
       :derive-condition never 
        :parameters (?w1 - agent ?w2 - agent ?c - agent ?l - loc)
        :precondition (and (witch ?w1) (witch ?w2) (civilian ?c) [?w1][?c](witch ?w2) (at ?w1 ?l) (at ?w2 ?l))
        :effect [?w2][?c](witch ?w2)
    )
     (:action witch-whisper-threat-suspicious
       :derive-condition never 
        :parameters (?c - agent ?w - agent ?l - loc)
        :precondition (and (diff ?c ?w) (civilian ?c) (witch ?w) (not (threatened-by ?c ?w)) [?w][?c](witch ?w) (at ?c ?l) (at ?w ?l))
        :effect (and (threatened-by ?c ?w) [?c](witch ?w))
    )
     (:action witch-whisper-threat-to-accuser
       :derive-condition never 
        :parameters (?c - agent ?w - agent ?l - loc)
        :precondition (and (diff ?c ?w) (civilian ?c) (witch ?w) (accused-by ?w ?c) [?w](accused-by ?w ?c) (at ?c ?l) (at ?w ?l))
        :effect (and (threatened-by ?c ?w) [?c](witch ?w))
    )
)
