#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<EOF
Usage: $0 <domain> [--disable-cap | --ground | --set-cap <integer>]
       $0 -h | --help

Options:
  <str> --disable-cap        Disable the variable cap. WARNING: If you have ancillary effects that trigger an infinite loop, this can cause it to run infinitely!
  <str> --ground             Ground the domain explicitly, instead of letting the planner choose what to ground. Recommended if you insist on having ancillary effects that trigger an infinite loop, and require guaranteed soundness.
  <str> --set-cap <int>      Set the loop cap to <int>. Recommended if you have ancillary effects that trigger an infinite (or large) loop, and you care more about generating plans quickly than soundness.
  -h, --help                 Show this help and exit.

EOF
}

die() {
    echo "Error: $1" >&2
    usage >&2
    exit 1
}

if [[ $# -eq 1 && ( $1 == "-h" || $1 == "--help" ) ]]; then
    usage
    exit 0
fi

[[ $# -ge 1 ]] || die "expected a domain"
domain=$1
[[ -n $domain ]] || die "domain must not be empty"

# Extra args to forward to evaluate.py (may be empty)
extra=()

if [[ $# -ge 2 ]]; then
    case "$2" in
        --disable-cap|--ground)
            [[ $# -eq 2 ]] || die "$2 takes no extra arguments"
            extra=("$2")
            ;;
        --set-cap)
            [[ $# -eq 3 ]] || die "--set-cap requires exactly one integer"
            [[ $3 =~ ^-?[0-9]+$ ]] || die "--set-cap requires an integer, got '$3'"
            extra=("$2" "$3")
            ;;
        *)
            die "unknown option '$2'"
            ;;
    esac
fi

for ((i=1; i<=10; i++)); do
    echo -e "\nRunning: python3 evaluate.py \"$domain\" $i solve ${extra[*]:-}"
    python3 -W ignore evaluate.py "$domain" "$i" solve ${extra[@]+"${extra[@]}"}

    if [ -f "domains/$domain/pdkb-domain.pddl" ] && [ -f "domains/$domain/pdkb-problem.pddl" ]; then
        echo "Running the planner..."
        plan_out=$(lama-first --search-time-limit 30m \
            "domains/$domain/pdkb-domain.pddl" "domains/$domain/pdkb-problem.pddl" \
            --translate-options --invariant-generation-max-time 1)
        printf "%s\n" "$plan_out" > "domains/$domain/output_$i.txt"

        if [ -f "sas_plan" ]; then
            echo "Plan found!"
            last_line="$(printf "%s\n" "$plan_out" | tail -n 1)"
            printf "%s\n" "$last_line" > time_output.txt
            mv sas_plan "domains/$domain/plan_$i.txt"
            python3 evaluate.py "$domain" "$i" write-plan ${extra[@]+"${extra[@]}"}
            rm time_output.txt
        else
            echo "No plan found."
        fi
    else
        echo "Domain and/or problem could not be generated."
    fi
done