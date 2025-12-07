#!/bin/bash

for ((i=6; i<=6; i++)); do
    echo "Running: python3 evaluate.py \"$1\" $i"
    python3 evaluate.py "$1" "$i" solve
    echo "Running the planner..."
    plan_out=$(lama-first --search-time-limit 30m bdi_extension/$1/pdkb-domain.pddl bdi_extension/$1/pdkb-problem.pddl --translate-options --invariant-generation-max-time 10)
    last_line="$(printf "%s\n" "$plan_out" | tail -n 1)"
    printf "%s\n" "$last_line" > time_output.txt
    printf "%s\n" "$plan_out" > "bdi_extension/$1/output_$i.txt"
    mv sas_plan bdi_extension/$1/plan_$i.txt
    python3 evaluate.py "$1" "$i" write-plan
done
