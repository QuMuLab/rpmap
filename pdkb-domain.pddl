(define (domain graPBevine)

    (:requirements :striPBs :conditional-effects)

    (:PBredicates
        (not_at_a_l1)
        (not_at_a_l2)
        (not_at_b_l1)
        (not_at_b_l2)
        (not_connected_l1_l1)
        (not_connected_l1_l2)
        (not_connected_l2_l1)
        (not_connected_l2_l2)
        (not_secret_a)
        (not_secret_b)
        (Ba_not_secret_a)
        (Ba_not_secret_b)
        (Ba_Ba_not_secret_a)
        (Ba_Ba_not_secret_b)
        (Ba_Ba_secret_a)
        (Ba_Ba_secret_b)
        (Ba_Bb_not_secret_a)
        (Ba_Bb_not_secret_b)
        (Ba_Bb_secret_a)
        (Ba_Bb_secret_b)
        (Ba_PBa_not_secret_a)
        (Ba_PBa_not_secret_b)
        (Ba_PBa_secret_a)
        (Ba_PBa_secret_b)
        (Ba_PBb_not_secret_a)
        (Ba_PBb_not_secret_b)
        (Ba_PBb_secret_a)
        (Ba_PBb_secret_b)
        (Ba_secret_a)
        (Ba_secret_b)
        (Bb_not_secret_a)
        (Bb_not_secret_b)
        (Bb_Ba_not_secret_a)
        (Bb_Ba_not_secret_b)
        (Bb_Ba_secret_a)
        (Bb_Ba_secret_b)
        (Bb_Bb_not_secret_a)
        (Bb_Bb_not_secret_b)
        (Bb_Bb_secret_a)
        (Bb_Bb_secret_b)
        (Bb_PBa_not_secret_a)
        (Bb_PBa_not_secret_b)
        (Bb_PBa_secret_a)
        (Bb_PBa_secret_b)
        (Bb_PBb_not_secret_a)
        (Bb_PBb_not_secret_b)
        (Bb_PBb_secret_a)
        (Bb_PBb_secret_b)
        (Bb_secret_a)
        (Bb_secret_b)
        (PBa_not_secret_a)
        (PBa_not_secret_b)
        (PBa_Ba_not_secret_a)
        (PBa_Ba_not_secret_b)
        (PBa_Ba_secret_a)
        (PBa_Ba_secret_b)
        (PBa_Bb_not_secret_a)
        (PBa_Bb_not_secret_b)
        (PBa_Bb_secret_a)
        (PBa_Bb_secret_b)
        (PBa_PBa_not_secret_a)
        (PBa_PBa_not_secret_b)
        (PBa_PBa_secret_a)
        (PBa_PBa_secret_b)
        (PBa_PBb_not_secret_a)
        (PBa_PBb_not_secret_b)
        (PBa_PBb_secret_a)
        (PBa_PBb_secret_b)
        (PBa_secret_a)
        (PBa_secret_b)
        (PBb_not_secret_a)
        (PBb_not_secret_b)
        (PBb_Ba_not_secret_a)
        (PBb_Ba_not_secret_b)
        (PBb_Ba_secret_a)
        (PBb_Ba_secret_b)
        (PBb_Bb_not_secret_a)
        (PBb_Bb_not_secret_b)
        (PBb_Bb_secret_a)
        (PBb_Bb_secret_b)
        (PBb_PBa_not_secret_a)
        (PBb_PBa_not_secret_b)
        (PBb_PBa_secret_a)
        (PBb_PBa_secret_b)
        (PBb_PBb_not_secret_a)
        (PBb_PBb_not_secret_b)
        (PBb_PBb_secret_a)
        (PBb_PBb_secret_b)
        (PBb_secret_a)
        (PBb_secret_b)
        (at_a_l1)
        (at_a_l2)
        (at_b_l1)
        (at_b_l2)
        (connected_l1_l1)
        (connected_l1_l2)
        (connected_l2_l1)
        (connected_l2_l2)
        (secret_a)
        (secret_b)
    )

    (:action move_a_l1_l1
        :PBrecondition (and (at_a_l1)
                           (connected_l1_l1))
        :effect (and
                    ; #72658: <==commonly_known== 82094 (neg)
                    (not_at_a_l1)

                    ; #82094: origin
                    (at_a_l1)

                    ; #72658: <==negation-removal== 82094 (PBos)
                    (not (not_at_a_l1))

                    ; #82094: origin
                    (not (at_a_l1))))

    (:action move_a_l1_l2
        :PBrecondition (and (connected_l1_l2)
                           (at_a_l1))
        :effect (and
                    ; #52334: origin
                    (at_a_l2)

                    ; #72658: <==commonly_known== 82094 (neg)
                    (not_at_a_l1)

                    ; #21104: <==negation-removal== 52334 (PBos)
                    (not (not_at_a_l2))

                    ; #82094: origin
                    (not (at_a_l1))))

    (:action move_a_l2_l1
        :PBrecondition (and (connected_l2_l1)
                           (at_a_l2))
        :effect (and
                    ; #21104: <==commonly_known== 52334 (neg)
                    (not_at_a_l2)

                    ; #82094: origin
                    (at_a_l1)

                    ; #52334: origin
                    (not (at_a_l2))

                    ; #72658: <==negation-removal== 82094 (PBos)
                    (not (not_at_a_l1))))

    (:action move_a_l2_l2
        :PBrecondition (and (connected_l2_l2)
                           (at_a_l2))
        :effect (and
                    ; #21104: <==commonly_known== 52334 (neg)
                    (not_at_a_l2)

                    ; #52334: origin
                    (at_a_l2)

                    ; #21104: <==negation-removal== 52334 (PBos)
                    (not (not_at_a_l2))

                    ; #52334: origin
                    (not (at_a_l2))))

    (:action move_b_l1_l1
        :PBrecondition (and (at_b_l1)
                           (connected_l1_l1))
        :effect (and
                    ; #26649: origin
                    (at_b_l1)

                    ; #76114: <==commonly_known== 26649 (neg)
                    (not_at_b_l1)

                    ; #26649: origin
                    (not (at_b_l1))

                    ; #76114: <==negation-removal== 26649 (PBos)
                    (not (not_at_b_l1))))

    (:action move_b_l1_l2
        :PBrecondition (and (at_b_l1)
                           (connected_l1_l2))
        :effect (and
                    ; #14664: origin
                    (at_b_l2)

                    ; #76114: <==commonly_known== 26649 (neg)
                    (not_at_b_l1)

                    ; #26649: origin
                    (not (at_b_l1))

                    ; #35395: <==negation-removal== 14664 (PBos)
                    (not (not_at_b_l2))))

    (:action move_b_l2_l1
        :PBrecondition (and (connected_l2_l1)
                           (at_b_l2))
        :effect (and
                    ; #26649: origin
                    (at_b_l1)

                    ; #35395: <==commonly_known== 14664 (neg)
                    (not_at_b_l2)

                    ; #14664: origin
                    (not (at_b_l2))

                    ; #76114: <==negation-removal== 26649 (PBos)
                    (not (not_at_b_l1))))

    (:action move_b_l2_l2
        :PBrecondition (and (connected_l2_l2)
                           (at_b_l2))
        :effect (and
                    ; #14664: origin
                    (at_b_l2)

                    ; #35395: <==commonly_known== 14664 (neg)
                    (not_at_b_l2)

                    ; #14664: origin
                    (not (at_b_l2))

                    ; #35395: <==negation-removal== 14664 (PBos)
                    (not (not_at_b_l2))))

    (:action share_a_a_l1
        :PBrecondition (and (at_a_l1)
                           (Ba_secret_a)
                           (PBa_secret_a))
        :effect (and
                    ; #12814: origin
                    (when (and (at_a_l1))
                          (Ba_secret_a))

                    ; #16153: <==closure== 32319 (PBos)
                    (when (and (at_b_l1))
                          (PBb_secret_a))

                    ; #18259: <==closure== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Bb_PBa_secret_a))

                    ; #30896: <==commonly_known== 32319 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Ba_Bb_secret_a))

                    ; #31377: <==closure== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Ba_PBb_secret_a))

                    ; #32319: origin
                    (when (and (at_b_l1))
                          (Bb_secret_a))

                    ; #35940: <==closure== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBb_PBa_secret_a))

                    ; #41120: <==closure== 12814 (PBos)
                    (when (and (at_a_l1))
                          (PBa_secret_a))

                    ; #43328: <==commonly_known== 12814 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Bb_Ba_secret_a))

                    ; #44974: <==closure== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBb_Ba_secret_a))

                    ; #69917: <==closure== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBa_Bb_secret_a))

                    ; #88709: <==closure== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBa_PBb_secret_a))

                    ; #14618: <==negation-removal== 12814 (PBos)
                    (when (and (at_a_l1))
                          (not (PBa_not_secret_a)))

                    ; #15298: <==negation-removal== 32319 (PBos)
                    (when (and (at_b_l1))
                          (not (PBb_not_secret_a)))

                    ; #17528: <==negation-removal== 31377 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBa_Bb_not_secret_a)))

                    ; #19846: <==unclosure== 61769 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBa_Bb_not_secret_a)))

                    ; #23277: <==unclosure== 61769 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Ba_Bb_not_secret_a)))

                    ; #24519: <==negation-removal== 44974 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Bb_PBa_not_secret_a)))

                    ; #32315: <==unclosure== 61769 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Ba_PBb_not_secret_a)))

                    ; #34507: <==negation-removal== 16153 (PBos)
                    (when (and (at_b_l1))
                          (not (Bb_not_secret_a)))

                    ; #38164: <==uncertain_firing== 32319 (PBos)
                    (when (and (not (not_at_b_l1)))
                          (not (PBb_not_secret_a)))

                    ; #43797: <==negation-removal== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBb_PBa_not_secret_a)))

                    ; #46189: <==negation-removal== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBa_PBb_not_secret_a)))

                    ; #53619: <==negation-removal== 41120 (PBos)
                    (when (and (at_a_l1))
                          (not (Ba_not_secret_a)))

                    ; #54019: <==unclosure== 71430 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBb_Ba_not_secret_a)))

                    ; #58739: <==unclosure== 71430 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Bb_PBa_not_secret_a)))

                    ; #61218: <==negation-removal== 69917 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Ba_PBb_not_secret_a)))

                    ; #61769: <==uncertain_firing== 30896 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBa_PBb_not_secret_a)))

                    ; #67231: <==negation-removal== 88709 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Ba_Bb_not_secret_a)))

                    ; #68296: <==negation-removal== 35940 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Bb_Ba_not_secret_a)))

                    ; #71430: <==uncertain_firing== 43328 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBb_PBa_not_secret_a)))

                    ; #76745: <==negation-removal== 18259 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBb_Ba_not_secret_a)))

                    ; #79412: <==uncertain_firing== 12814 (PBos)
                    (when (and (not (not_at_a_l1)))
                          (not (PBa_not_secret_a)))

                    ; #80902: <==unclosure== 38164 (neg)
                    (when (and (not (not_at_b_l1)))
                          (not (Bb_not_secret_a)))

                    ; #81118: <==unclosure== 79412 (neg)
                    (when (and (not (not_at_a_l1)))
                          (not (Ba_not_secret_a)))

                    ; #85300: <==unclosure== 71430 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Bb_Ba_not_secret_a)))))

    (:action share_a_a_l2
        :PBrecondition (and (Ba_secret_a)
                           (at_a_l2)
                           (PBa_secret_a))
        :effect (and
                    ; #15459: <==closure== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_Bb_secret_a))

                    ; #17124: <==closure== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_PBb_secret_a))

                    ; #20785: <==closure== 59886 (PBos)
                    (when (and (at_b_l2))
                          (PBb_secret_a))

                    ; #24190: <==commonly_known== 59886 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_Bb_secret_a))

                    ; #24479: <==closure== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_PBa_secret_a))

                    ; #27533: origin
                    (when (and (at_a_l2))
                          (Ba_secret_a))

                    ; #44277: <==closure== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_PBb_secret_a))

                    ; #45664: <==closure== 27533 (PBos)
                    (when (and (at_a_l2))
                          (PBa_secret_a))

                    ; #59886: origin
                    (when (and (at_b_l2))
                          (Bb_secret_a))

                    ; #60108: <==commonly_known== 27533 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_Ba_secret_a))

                    ; #71699: <==closure== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_Ba_secret_a))

                    ; #73992: <==closure== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_PBa_secret_a))

                    ; #19753: <==unclosure== 23616 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_PBb_not_secret_a)))

                    ; #20972: <==unclosure== 23616 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_Bb_not_secret_a)))

                    ; #23434: <==negation-removal== 20785 (PBos)
                    (when (and (at_b_l2))
                          (not (Bb_not_secret_a)))

                    ; #23616: <==uncertain_firing== 24190 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_PBb_not_secret_a)))

                    ; #25026: <==negation-removal== 17124 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_Bb_not_secret_a)))

                    ; #33431: <==uncertain_firing== 60108 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_PBa_not_secret_a)))

                    ; #34301: <==unclosure== 33431 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_Ba_not_secret_a)))

                    ; #35571: <==negation-removal== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_PBb_not_secret_a)))

                    ; #40915: <==negation-removal== 73992 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_Ba_not_secret_a)))

                    ; #46444: <==unclosure== 33431 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_Ba_not_secret_a)))

                    ; #47279: <==negation-removal== 59886 (PBos)
                    (when (and (at_b_l2))
                          (not (PBb_not_secret_a)))

                    ; #47297: <==negation-removal== 27533 (PBos)
                    (when (and (at_a_l2))
                          (not (PBa_not_secret_a)))

                    ; #50021: <==uncertain_firing== 59886 (PBos)
                    (when (and (not (not_at_b_l2)))
                          (not (PBb_not_secret_a)))

                    ; #56170: <==negation-removal== 71699 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_PBa_not_secret_a)))

                    ; #60316: <==negation-removal== 15459 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_PBb_not_secret_a)))

                    ; #68076: <==negation-removal== 44277 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_Bb_not_secret_a)))

                    ; #69623: <==unclosure== 33431 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_PBa_not_secret_a)))

                    ; #76711: <==negation-removal== 24479 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_Ba_not_secret_a)))

                    ; #79998: <==unclosure== 50021 (neg)
                    (when (and (not (not_at_b_l2)))
                          (not (Bb_not_secret_a)))

                    ; #81492: <==negation-removal== 45664 (PBos)
                    (when (and (at_a_l2))
                          (not (Ba_not_secret_a)))

                    ; #84286: <==unclosure== 23616 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_Bb_not_secret_a)))

                    ; #85626: <==negation-removal== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_PBa_not_secret_a)))

                    ; #90480: <==unclosure== 90627 (neg)
                    (when (and (not (not_at_a_l2)))
                          (not (Ba_not_secret_a)))

                    ; #90627: <==uncertain_firing== 27533 (PBos)
                    (when (and (not (not_at_a_l2)))
                          (not (PBa_not_secret_a)))))

    (:action share_a_b_l1
        :PBrecondition (and (at_a_l1)
                           (PBa_secret_b)
                           (Ba_secret_b))
        :effect (and
                    ; #13589: <==commonly_known== 16502 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (Bb_Ba_secret_b))

                    ; #16502: origin
                    (when (and (at_a_l1))
                          (Ba_secret_b))

                    ; #32656: <==closure== 13589 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (PBb_Ba_secret_b))

                    ; #36226: <==commonly_known== 79174 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (Ba_Bb_secret_b))

                    ; #36859: <==closure== 13589 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (Bb_PBa_secret_b))

                    ; #36932: <==closure== 36226 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (Ba_PBb_secret_b))

                    ; #45565: <==closure== 16502 (PBos)
                    (when (and (at_a_l1))
                          (PBa_secret_b))

                    ; #48021: <==closure== 79174 (PBos)
                    (when (and (at_b_l1))
                          (PBb_secret_b))

                    ; #66848: <==closure== 36226 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (PBa_PBb_secret_b))

                    ; #66893: <==closure== 13589 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (PBb_PBa_secret_b))

                    ; #79174: origin
                    (when (and (at_b_l1))
                          (Bb_secret_b))

                    ; #85707: <==closure== 36226 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (PBa_Bb_secret_b))

                    ; #11138: <==negation-removal== 66893 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (Bb_Ba_not_secret_b)))

                    ; #14650: <==negation-removal== 16502 (PBos)
                    (when (and (at_a_l1))
                          (not (PBa_not_secret_b)))

                    ; #15813: <==uncertain_firing== 13589 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (PBb_PBa_not_secret_b)))

                    ; #18725: <==unclosure== 23077 (neg)
                    (when (and (not (not_at_b_l1)))
                          (not (Bb_not_secret_b)))

                    ; #21549: <==unclosure== 15813 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (PBb_Ba_not_secret_b)))

                    ; #23077: <==uncertain_firing== 79174 (PBos)
                    (when (and (not (not_at_b_l1)))
                          (not (PBb_not_secret_b)))

                    ; #29796: <==negation-removal== 85707 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (Ba_PBb_not_secret_b)))

                    ; #33135: <==negation-removal== 36859 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (PBb_Ba_not_secret_b)))

                    ; #35605: <==unclosure== 15813 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (Bb_PBa_not_secret_b)))

                    ; #45306: <==negation-removal== 36932 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (PBa_Bb_not_secret_b)))

                    ; #46214: <==negation-removal== 48021 (PBos)
                    (when (and (at_b_l1))
                          (not (Bb_not_secret_b)))

                    ; #47782: <==unclosure== 58545 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (Ba_PBb_not_secret_b)))

                    ; #48574: <==negation-removal== 36226 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (PBa_PBb_not_secret_b)))

                    ; #52964: <==uncertain_firing== 16502 (PBos)
                    (when (and (not (not_at_a_l1)))
                          (not (PBa_not_secret_b)))

                    ; #53037: <==negation-removal== 45565 (PBos)
                    (when (and (at_a_l1))
                          (not (Ba_not_secret_b)))

                    ; #53048: <==unclosure== 58545 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (Ba_Bb_not_secret_b)))

                    ; #54413: <==negation-removal== 79174 (PBos)
                    (when (and (at_b_l1))
                          (not (PBb_not_secret_b)))

                    ; #58545: <==uncertain_firing== 36226 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (PBa_PBb_not_secret_b)))

                    ; #63488: <==negation-removal== 32656 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (Bb_PBa_not_secret_b)))

                    ; #70852: <==negation-removal== 66848 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (Ba_Bb_not_secret_b)))

                    ; #75148: <==negation-removal== 13589 (PBos)
                    (when (and (at_a_l1)
                               (at_b_l1))
                          (not (PBb_PBa_not_secret_b)))

                    ; #77738: <==unclosure== 52964 (neg)
                    (when (and (not (not_at_a_l1)))
                          (not (Ba_not_secret_b)))

                    ; #83785: <==unclosure== 58545 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (PBa_Bb_not_secret_b)))

                    ; #89609: <==unclosure== 15813 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1)))
                          (not (Bb_Ba_not_secret_b)))))

    (:action share_a_b_l2
        :PBrecondition (and (PBa_secret_b)
                           (Ba_secret_b)
                           (at_a_l2))
        :effect (and
                    ; #12333: <==closure== 54825 (PBos)
                    (when (and (at_b_l2))
                          (PBb_secret_b))

                    ; #18802: <==commonly_known== 88570 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_Ba_secret_b))

                    ; #20372: <==closure== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_PBa_secret_b))

                    ; #44802: <==closure== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_PBa_secret_b))

                    ; #53588: <==commonly_known== 54825 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_Bb_secret_b))

                    ; #54825: origin
                    (when (and (at_b_l2))
                          (Bb_secret_b))

                    ; #64156: <==closure== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_PBb_secret_b))

                    ; #68798: <==closure== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_Bb_secret_b))

                    ; #81819: <==closure== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_PBb_secret_b))

                    ; #84957: <==closure== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_Ba_secret_b))

                    ; #87169: <==closure== 88570 (PBos)
                    (when (and (at_a_l2))
                          (PBa_secret_b))

                    ; #88570: origin
                    (when (and (at_a_l2))
                          (Ba_secret_b))

                    ; #10575: <==negation-removal== 84957 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_PBa_not_secret_b)))

                    ; #12680: <==negation-removal== 68798 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_PBb_not_secret_b)))

                    ; #14798: <==negation-removal== 54825 (PBos)
                    (when (and (at_b_l2))
                          (not (PBb_not_secret_b)))

                    ; #17636: <==uncertain_firing== 53588 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_PBb_not_secret_b)))

                    ; #19292: <==uncertain_firing== 54825 (PBos)
                    (when (and (not (not_at_b_l2)))
                          (not (PBb_not_secret_b)))

                    ; #19401: <==negation-removal== 64156 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_Bb_not_secret_b)))

                    ; #20341: <==unclosure== 17636 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_PBb_not_secret_b)))

                    ; #21990: <==uncertain_firing== 88570 (PBos)
                    (when (and (not (not_at_a_l2)))
                          (not (PBa_not_secret_b)))

                    ; #31918: <==negation-removal== 44802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_Ba_not_secret_b)))

                    ; #34427: <==negation-removal== 87169 (PBos)
                    (when (and (at_a_l2))
                          (not (Ba_not_secret_b)))

                    ; #36716: <==unclosure== 19292 (neg)
                    (when (and (not (not_at_b_l2)))
                          (not (Bb_not_secret_b)))

                    ; #37811: <==unclosure== 90776 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_Ba_not_secret_b)))

                    ; #39233: <==negation-removal== 81819 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_Bb_not_secret_b)))

                    ; #41261: <==unclosure== 17636 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_Bb_not_secret_b)))

                    ; #47502: <==negation-removal== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_PBb_not_secret_b)))

                    ; #56438: <==negation-removal== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_PBa_not_secret_b)))

                    ; #60572: <==negation-removal== 20372 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_Ba_not_secret_b)))

                    ; #60712: <==unclosure== 90776 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_PBa_not_secret_b)))

                    ; #77529: <==unclosure== 90776 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_Ba_not_secret_b)))

                    ; #79535: <==negation-removal== 88570 (PBos)
                    (when (and (at_a_l2))
                          (not (PBa_not_secret_b)))

                    ; #81783: <==negation-removal== 12333 (PBos)
                    (when (and (at_b_l2))
                          (not (Bb_not_secret_b)))

                    ; #82089: <==unclosure== 21990 (neg)
                    (when (and (not (not_at_a_l2)))
                          (not (Ba_not_secret_b)))

                    ; #90776: <==uncertain_firing== 18802 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_PBa_not_secret_b)))

                    ; #91449: <==unclosure== 17636 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_Bb_not_secret_b)))))

    (:action share_b_a_l1
        :PBrecondition (and (at_b_l1)
                           (Bb_secret_a)
                           (PBb_secret_a))
        :effect (and
                    ; #12814: origin
                    (when (and (at_a_l1))
                          (Ba_secret_a))

                    ; #16153: <==closure== 32319 (PBos)
                    (when (and (at_b_l1))
                          (PBb_secret_a))

                    ; #18259: <==closure== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Bb_PBa_secret_a))

                    ; #30896: <==commonly_known== 32319 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Ba_Bb_secret_a))

                    ; #31377: <==closure== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Ba_PBb_secret_a))

                    ; #32319: origin
                    (when (and (at_b_l1))
                          (Bb_secret_a))

                    ; #35940: <==closure== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBb_PBa_secret_a))

                    ; #41120: <==closure== 12814 (PBos)
                    (when (and (at_a_l1))
                          (PBa_secret_a))

                    ; #43328: <==commonly_known== 12814 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Bb_Ba_secret_a))

                    ; #44974: <==closure== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBb_Ba_secret_a))

                    ; #69917: <==closure== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBa_Bb_secret_a))

                    ; #88709: <==closure== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBa_PBb_secret_a))

                    ; #14618: <==negation-removal== 12814 (PBos)
                    (when (and (at_a_l1))
                          (not (PBa_not_secret_a)))

                    ; #15298: <==negation-removal== 32319 (PBos)
                    (when (and (at_b_l1))
                          (not (PBb_not_secret_a)))

                    ; #17528: <==negation-removal== 31377 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBa_Bb_not_secret_a)))

                    ; #19846: <==unclosure== 61769 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBa_Bb_not_secret_a)))

                    ; #23277: <==unclosure== 61769 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Ba_Bb_not_secret_a)))

                    ; #24519: <==negation-removal== 44974 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Bb_PBa_not_secret_a)))

                    ; #32315: <==unclosure== 61769 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Ba_PBb_not_secret_a)))

                    ; #34507: <==negation-removal== 16153 (PBos)
                    (when (and (at_b_l1))
                          (not (Bb_not_secret_a)))

                    ; #38164: <==uncertain_firing== 32319 (PBos)
                    (when (and (not (not_at_b_l1)))
                          (not (PBb_not_secret_a)))

                    ; #43797: <==negation-removal== 43328 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBb_PBa_not_secret_a)))

                    ; #46189: <==negation-removal== 30896 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBa_PBb_not_secret_a)))

                    ; #53619: <==negation-removal== 41120 (PBos)
                    (when (and (at_a_l1))
                          (not (Ba_not_secret_a)))

                    ; #54019: <==unclosure== 71430 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBb_Ba_not_secret_a)))

                    ; #58739: <==unclosure== 71430 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Bb_PBa_not_secret_a)))

                    ; #61218: <==negation-removal== 69917 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Ba_PBb_not_secret_a)))

                    ; #61769: <==uncertain_firing== 30896 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBa_PBb_not_secret_a)))

                    ; #67231: <==negation-removal== 88709 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Ba_Bb_not_secret_a)))

                    ; #68296: <==negation-removal== 35940 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Bb_Ba_not_secret_a)))

                    ; #71430: <==uncertain_firing== 43328 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBb_PBa_not_secret_a)))

                    ; #76745: <==negation-removal== 18259 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBb_Ba_not_secret_a)))

                    ; #79412: <==uncertain_firing== 12814 (PBos)
                    (when (and (not (not_at_a_l1)))
                          (not (PBa_not_secret_a)))

                    ; #80902: <==unclosure== 38164 (neg)
                    (when (and (not (not_at_b_l1)))
                          (not (Bb_not_secret_a)))

                    ; #81118: <==unclosure== 79412 (neg)
                    (when (and (not (not_at_a_l1)))
                          (not (Ba_not_secret_a)))

                    ; #85300: <==unclosure== 71430 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Bb_Ba_not_secret_a)))))

    (:action share_b_a_l2
        :PBrecondition (and (Bb_secret_a)
                           (at_b_l2)
                           (PBb_secret_a))
        :effect (and
                    ; #15459: <==closure== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_Bb_secret_a))

                    ; #17124: <==closure== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_PBb_secret_a))

                    ; #20785: <==closure== 59886 (PBos)
                    (when (and (at_b_l2))
                          (PBb_secret_a))

                    ; #24190: <==commonly_known== 59886 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_Bb_secret_a))

                    ; #24479: <==closure== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_PBa_secret_a))

                    ; #27533: origin
                    (when (and (at_a_l2))
                          (Ba_secret_a))

                    ; #44277: <==closure== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_PBb_secret_a))

                    ; #45664: <==closure== 27533 (PBos)
                    (when (and (at_a_l2))
                          (PBa_secret_a))

                    ; #59886: origin
                    (when (and (at_b_l2))
                          (Bb_secret_a))

                    ; #60108: <==commonly_known== 27533 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_Ba_secret_a))

                    ; #71699: <==closure== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_Ba_secret_a))

                    ; #73992: <==closure== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_PBa_secret_a))

                    ; #19753: <==unclosure== 23616 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_PBb_not_secret_a)))

                    ; #20972: <==unclosure== 23616 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_Bb_not_secret_a)))

                    ; #23434: <==negation-removal== 20785 (PBos)
                    (when (and (at_b_l2))
                          (not (Bb_not_secret_a)))

                    ; #23616: <==uncertain_firing== 24190 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_PBb_not_secret_a)))

                    ; #25026: <==negation-removal== 17124 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_Bb_not_secret_a)))

                    ; #33431: <==uncertain_firing== 60108 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_PBa_not_secret_a)))

                    ; #34301: <==unclosure== 33431 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_Ba_not_secret_a)))

                    ; #35571: <==negation-removal== 24190 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_PBb_not_secret_a)))

                    ; #40915: <==negation-removal== 73992 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_Ba_not_secret_a)))

                    ; #46444: <==unclosure== 33431 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_Ba_not_secret_a)))

                    ; #47279: <==negation-removal== 59886 (PBos)
                    (when (and (at_b_l2))
                          (not (PBb_not_secret_a)))

                    ; #47297: <==negation-removal== 27533 (PBos)
                    (when (and (at_a_l2))
                          (not (PBa_not_secret_a)))

                    ; #50021: <==uncertain_firing== 59886 (PBos)
                    (when (and (not (not_at_b_l2)))
                          (not (PBb_not_secret_a)))

                    ; #56170: <==negation-removal== 71699 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_PBa_not_secret_a)))

                    ; #60316: <==negation-removal== 15459 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_PBb_not_secret_a)))

                    ; #68076: <==negation-removal== 44277 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_Bb_not_secret_a)))

                    ; #69623: <==unclosure== 33431 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_PBa_not_secret_a)))

                    ; #76711: <==negation-removal== 24479 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_Ba_not_secret_a)))

                    ; #79998: <==unclosure== 50021 (neg)
                    (when (and (not (not_at_b_l2)))
                          (not (Bb_not_secret_a)))

                    ; #81492: <==negation-removal== 45664 (PBos)
                    (when (and (at_a_l2))
                          (not (Ba_not_secret_a)))

                    ; #84286: <==unclosure== 23616 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_Bb_not_secret_a)))

                    ; #85626: <==negation-removal== 60108 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_PBa_not_secret_a)))

                    ; #90480: <==unclosure== 90627 (neg)
                    (when (and (not (not_at_a_l2)))
                          (not (Ba_not_secret_a)))

                    ; #90627: <==uncertain_firing== 27533 (PBos)
                    (when (and (not (not_at_a_l2)))
                          (not (PBa_not_secret_a)))))

    (:action share_b_b_l1
        :PBrecondition (and (at_b_l1)
                           (Bb_secret_b)
                           (PBb_secret_b))
        :effect (and
                    ; #13589: <==commonly_known== 16502 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Bb_Ba_secret_b))

                    ; #16502: origin
                    (when (and (at_a_l1))
                          (Ba_secret_b))

                    ; #32656: <==closure== 13589 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBb_Ba_secret_b))

                    ; #36226: <==commonly_known== 79174 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Ba_Bb_secret_b))

                    ; #36859: <==closure== 13589 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Bb_PBa_secret_b))

                    ; #36932: <==closure== 36226 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (Ba_PBb_secret_b))

                    ; #45565: <==closure== 16502 (PBos)
                    (when (and (at_a_l1))
                          (PBa_secret_b))

                    ; #48021: <==closure== 79174 (PBos)
                    (when (and (at_b_l1))
                          (PBb_secret_b))

                    ; #66848: <==closure== 36226 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBa_PBb_secret_b))

                    ; #66893: <==closure== 13589 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBb_PBa_secret_b))

                    ; #79174: origin
                    (when (and (at_b_l1))
                          (Bb_secret_b))

                    ; #85707: <==closure== 36226 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (PBa_Bb_secret_b))

                    ; #11138: <==negation-removal== 66893 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Bb_Ba_not_secret_b)))

                    ; #14650: <==negation-removal== 16502 (PBos)
                    (when (and (at_a_l1))
                          (not (PBa_not_secret_b)))

                    ; #15813: <==uncertain_firing== 13589 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBb_PBa_not_secret_b)))

                    ; #18725: <==unclosure== 23077 (neg)
                    (when (and (not (not_at_b_l1)))
                          (not (Bb_not_secret_b)))

                    ; #21549: <==unclosure== 15813 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBb_Ba_not_secret_b)))

                    ; #23077: <==uncertain_firing== 79174 (PBos)
                    (when (and (not (not_at_b_l1)))
                          (not (PBb_not_secret_b)))

                    ; #29796: <==negation-removal== 85707 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Ba_PBb_not_secret_b)))

                    ; #33135: <==negation-removal== 36859 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBb_Ba_not_secret_b)))

                    ; #35605: <==unclosure== 15813 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Bb_PBa_not_secret_b)))

                    ; #45306: <==negation-removal== 36932 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBa_Bb_not_secret_b)))

                    ; #46214: <==negation-removal== 48021 (PBos)
                    (when (and (at_b_l1))
                          (not (Bb_not_secret_b)))

                    ; #47782: <==unclosure== 58545 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Ba_PBb_not_secret_b)))

                    ; #48574: <==negation-removal== 36226 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBa_PBb_not_secret_b)))

                    ; #52964: <==uncertain_firing== 16502 (PBos)
                    (when (and (not (not_at_a_l1)))
                          (not (PBa_not_secret_b)))

                    ; #53037: <==negation-removal== 45565 (PBos)
                    (when (and (at_a_l1))
                          (not (Ba_not_secret_b)))

                    ; #53048: <==unclosure== 58545 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Ba_Bb_not_secret_b)))

                    ; #54413: <==negation-removal== 79174 (PBos)
                    (when (and (at_b_l1))
                          (not (PBb_not_secret_b)))

                    ; #58545: <==uncertain_firing== 36226 (PBos)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBa_PBb_not_secret_b)))

                    ; #63488: <==negation-removal== 32656 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Bb_PBa_not_secret_b)))

                    ; #70852: <==negation-removal== 66848 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (Ba_Bb_not_secret_b)))

                    ; #75148: <==negation-removal== 13589 (PBos)
                    (when (and (at_b_l1)
                               (at_a_l1)))
                          (not (PBb_PBa_not_secret_b)))

                    ; #77738: <==unclosure== 52964 (neg)
                    (when (and (not (not_at_a_l1)))
                          (not (Ba_not_secret_b)))

                    ; #83785: <==unclosure== 58545 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (PBa_Bb_not_secret_b)))

                    ; #89609: <==unclosure== 15813 (neg)
                    (when (and (not (not_at_a_l1))
                               (not (not_at_b_l1))))
                          (not (Bb_Ba_not_secret_b)))))

    (:action share_b_b_l2
        :PBrecondition (and (Bb_secret_b)
                           (at_b_l2)
                           (PBb_secret_b))
        :effect (and
                    ; #12333: <==closure== 54825 (PBos)
                    (when (and (at_b_l2))
                          (PBb_secret_b))

                    ; #18802: <==commonly_known== 88570 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_Ba_secret_b))

                    ; #20372: <==closure== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_PBa_secret_b))

                    ; #44802: <==closure== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Bb_PBa_secret_b))

                    ; #53588: <==commonly_known== 54825 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_Bb_secret_b))

                    ; #54825: origin
                    (when (and (at_b_l2))
                          (Bb_secret_b))

                    ; #64156: <==closure== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_PBb_secret_b))

                    ; #68798: <==closure== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBa_Bb_secret_b))

                    ; #81819: <==closure== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (Ba_PBb_secret_b))

                    ; #84957: <==closure== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (PBb_Ba_secret_b))

                    ; #87169: <==closure== 88570 (PBos)
                    (when (and (at_a_l2))
                          (PBa_secret_b))

                    ; #88570: origin
                    (when (and (at_a_l2))
                          (Ba_secret_b))

                    ; #10575: <==negation-removal== 84957 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_PBa_not_secret_b)))

                    ; #12680: <==negation-removal== 68798 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_PBb_not_secret_b)))

                    ; #14798: <==negation-removal== 54825 (PBos)
                    (when (and (at_b_l2))
                          (not (PBb_not_secret_b)))

                    ; #17636: <==uncertain_firing== 53588 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_PBb_not_secret_b)))

                    ; #19292: <==uncertain_firing== 54825 (PBos)
                    (when (and (not (not_at_b_l2)))
                          (not (PBb_not_secret_b)))

                    ; #19401: <==negation-removal== 64156 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Ba_Bb_not_secret_b)))

                    ; #20341: <==unclosure== 17636 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_PBb_not_secret_b)))

                    ; #21990: <==uncertain_firing== 88570 (PBos)
                    (when (and (not (not_at_a_l2)))
                          (not (PBa_not_secret_b)))

                    ; #31918: <==negation-removal== 44802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_Ba_not_secret_b)))

                    ; #34427: <==negation-removal== 87169 (PBos)
                    (when (and (at_a_l2))
                          (not (Ba_not_secret_b)))

                    ; #36716: <==unclosure== 19292 (neg)
                    (when (and (not (not_at_b_l2)))
                          (not (Bb_not_secret_b)))

                    ; #37811: <==unclosure== 90776 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_Ba_not_secret_b)))

                    ; #39233: <==negation-removal== 81819 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_Bb_not_secret_b)))

                    ; #41261: <==unclosure== 17636 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBa_Bb_not_secret_b)))

                    ; #47502: <==negation-removal== 53588 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBa_PBb_not_secret_b)))

                    ; #56438: <==negation-removal== 18802 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (PBb_PBa_not_secret_b)))

                    ; #60572: <==negation-removal== 20372 (PBos)
                    (when (and (at_b_l2)
                               (at_a_l2)))
                          (not (Bb_Ba_not_secret_b)))

                    ; #60712: <==unclosure== 90776 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Bb_PBa_not_secret_b)))

                    ; #77529: <==unclosure== 90776 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_Ba_not_secret_b)))

                    ; #79535: <==negation-removal== 88570 (PBos)
                    (when (and (at_a_l2))
                          (not (PBa_not_secret_b)))

                    ; #81783: <==negation-removal== 12333 (PBos)
                    (when (and (at_b_l2))
                          (not (Bb_not_secret_b)))

                    ; #82089: <==unclosure== 21990 (neg)
                    (when (and (not (not_at_a_l2)))
                          (not (Ba_not_secret_b)))

                    ; #90776: <==uncertain_firing== 18802 (PBos)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (PBb_PBa_not_secret_b)))

                    ; #91449: <==unclosure== 17636 (neg)
                    (when (and (not (not_at_a_l2))
                               (not (not_at_b_l2))))
                          (not (Ba_Bb_not_secret_b)))))

)