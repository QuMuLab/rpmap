# Running RP-M*P: Extending RP-MEP with Customizable Mental Modalities

## Setup
Create a virtual environment and activate it.
On Linux (or use the Mac/Windows equivalent):
`python3 -m venv .venv && source .venv/bin/activate`

Then, install the required libraries:
`pip install lark && pip install git+https://github.com/AI-Planning/pddl.git@2fba52e9a9bd9bf93031828bffcd326452f85d1c`

Example PDKBDDL domains are located under `domains.`

## Running Example Domains in RP-M*P

Use the `evaluate.py` script to run the ancillary effect algorithm on a sample domain and problem number, e.g.:

`python3 evaluate.py capture-the-flag 3 solve`

You will see that `pdkb-domain.pddl` and `pdkb-problem.pddl` files are generated in `domains/capture-the-flag`.

## Solving Example Generated Domains

RP-M*P compiles to **classical planning**, so you can use any classical planner to solve. We used `lama-first` with [planutils](https://github.com/AI-Planning/planutils).

## Solving Your Own Domains

Place your domain directory under `domains`. This directory should include your `domain.pdkbddl`, your numbered `problem_{#}.pdkbddl`s, the base ancillary effect file found in the other directories `ancillary_effects.pdkbddl`, and whichever other ancillary effect files you would like. Modify the `get_num_agents` function in the `evaluate.py` file to represent how the number of agents is distributed across your problems. Run `evaluate.py`, using your domain name and the problem number as your first two arguments and `solve` as the final argument. Finally, use your preferred classical planner to solve.

## Reproducing Paper Results
Finally, the `evaluate_domain.sh` script runs all the problem files for the sample domain. You can use these to reproduce the results in the paper. Note that this uses `lama-first` from [planutils](https://github.com/AI-Planning/planutils).

`./evaluate_domain.sh "capture-the-flag"` (do for all domains)

## Contact
If there are any issues, feel free to contact 18rldv@queensu.ca. :)
