{include:blocksworld.pddl}
(define (problem blocksworld-problem)
  (:domain blocksworld)
  (:objects a b c - block)
  (:init (handempty) (ontable a) (ontable b) (ontable c)
         (clear a) (clear b) (clear c))
  (:goal (and (clear c) (ontable b) (on c a) (on a b)))
)