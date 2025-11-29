#!/bin/bash

for ((i=1, j=2; i<=4; i++, j++)); do
    echo "Running: python3 evaluate.py \"$1\" $i $j"
    python3 evaluate.py "$1" "$i" "$j"
    echo "Running the planner... $i $j"
    lama-first bdi_extension/$1/pdkb-domain.pddl bdi_extension/$1/pdkb-problem.pddl --translate-options --invariant-generation-max-time 10 > planner_output.txt 
    python3 evaluate.py
done
