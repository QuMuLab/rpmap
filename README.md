# Running RP-M*P: Extending RP-MEP with Customizable Mental Modalities

## Setup
Create a virtual environment and activate it.
On Linux (or use the Mac/Windows equivalent):
`python3 -m venv .venv && source .venv/bin/activate`

Then, install the required libraries:
`pip install lark && pip install git+https://github.com/AI-Planning/pddl.git@2fba52e9a9bd9bf93031828bffcd326452f85d1c`

Example PDKBDDL domains are located under `bdi_extension.`

## Running Example Domains in RP-M*P

Use the `evaluate` script to run the ancillary effect algorithm on a sample domain and problem number, e.g.:

`python3 evaluate.py belief-desire 3 solve`

You will see that `pdkb-domain.pddl` and `pdkb-problem.pddl` files are generated in `bdi_extension/belief-desire`.

## Solving Example Generated Domains

RP-M*P compiles to **classical planning**, so you can use any classical planner to solve. We used `lama-first` with [planutils](https://github.com/AI-Planning/planutils).

## Solving Your Own Domains

Place your domain directory under `bdi_extension`. This directory should include your `domain.pdkbddl`, your numbered `problem_{#}.pdkbddl`s, the base ancillary effect file found in the other directories `ancillary_effects.pdkbddl`, and whichever other ancillary effect files you would like. Run the `evaluate.py`, using your domain name and the problem number as your first two arguments. Finally, use your preferred classical planner to solve.

## Reproducing Paper Results
Finally, the `evaluate_domain.sh` script runs all the problem files for the sample domain. You can use these to reproduce the results in the paper. Note that this uses `lama-first` from [planutils](https://github.com/AI-Planning/planutils).

`./evaluate_domain.sh "belief-desire"`

## Contact
If there are any issues, feel free to contact 18rldv@queensu.ca. :)

# Running RP-MEP: Multi-agent Epistemic Planning With Proper Doxastic Knowledge Bases #

We recommend using RP-M*P, but if you are curious, this repository also houses the old code for solving Multi-agent Epistemic Planning (MEP) problems using Proper Doxastic Knowledge Bases (PDKB). There are a number of components that may be useful on their own, including [working directing with PDKB's](https://github.com/QuMuLab/PDKB-Planning/blob/master/pdkb/kd45.py?at=default), [augmenting the MEP formalism](https://github.com/QuMuLab/PDKB-Planning/blob/master/pdkb/problems.py?at=default), or even just creating / dealing with [KD45 kripke structures](https://github.com/QuMuLab/PDKB-Planning/blob/master/pdkb/kripke.py?at=default).

Eventually, more documentation will be added to the project, but feel free to [contact me](http://haz.ca/contact.html) if you have any questions. For a demo and more information on the project, [[click here](http://pdkb.haz.ca/)].

## Getting started ##

### Using Docker ###

```sh
docker build -t pdkbplanning:latest .
docker run -it pdkbplanning
```

You end up in a shell running in the Docker container,
which has all the required tools installed.
Then you can run the planner on an example PKDBDDL problem:

```sh
python3 -m pdkb.planner /MEP/pdkb-planning/examples/planning/grapevine/prob-paper1.pdkbddl
```

## Requirements ##
* [Graphviz](http://graphviz.org/)
* [NetworkX](http://networkx.github.io/)
* [Pygraphviz](http://networkx.lanl.gov/pygraphviz/index.html)

python3 -m pdkb.planner /MEP/pdkb-planning/examples/planning/grapevine/prob-paper1.pdkbddl
```

## Requirements ##
* [Graphviz](http://graphviz.org/)
* [NetworkX](http://networkx.github.io/)
* [Pygraphviz](http://networkx.lanl.gov/pygraphviz/index.html)
