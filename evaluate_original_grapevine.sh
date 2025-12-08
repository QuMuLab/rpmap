#!/bin/bash

for ((i=1; i<=10; i++)); do
    echo "Running: python3 evaluate_original_grapevine.py $i"
    python3 evaluate_original_grapevine.py "$i" solve
    echo "Running the planner..."
    plan_out=$(lama-first --search-time-limit 30m bdi_extension/original_grapevine/pdkb-domain.pddl bdi_extension/original_grapevine/pdkb-problem.pddl --translate-options --invariant-generation-max-time 10)
    last_line="$(printf "%s\n" "$plan_out" | tail -n 1)"
    printf "%s\n" "$last_line" > time_output.txt
    printf "%s\n" "$plan_out" > "bdi_extension/original_grapevine/output_$i.txt"
    mv sas_plan bdi_extension/original_grapevine/plan_$i.txt
    python3 evaluate.py original_grapevine "$i" write-plan
done
