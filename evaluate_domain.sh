#!/bin/bash

for ((i=10; i<=10; i++)); do
    echo "Running: python3 evaluate.py \"$1\" $i"
    python3 evaluate.py "$1" "$i" solve
    echo "Running the planner..."
    plan_out=$(lama-first --search-time-limit 30m domains/$1/pdkb-domain.pddl domains/$1/pdkb-problem.pddl --translate-options --invariant-generation-max-time 10)
    last_line="$(printf "%s\n" "$plan_out" | tail -n 1)"
    printf "%s\n" "$last_line" > time_output.txt
    printf "%s\n" "$plan_out" > "domains/$1/output_$i.txt"
    mv sas_plan domains/$1/plan_$i.txt
    python3 evaluate.py "$1" "$i" write-plan
done
