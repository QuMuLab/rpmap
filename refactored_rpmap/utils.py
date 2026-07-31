import os


def run_command(cmd, output_file, MEMLIMIT, TIMELIMIT):
    os.system("ulimit -m %s; timeout %s %s > %s 2> %s" % \
        (MEMLIMIT, TIMELIMIT, cmd, output_file, output_file))


def parse_output_ipc(file_name):
    class Plan():
        def __init__(self, actions=None):
            self.actions = actions or []

        def add_actions(self, new_actions):
            self.actions.extend(new_actions)

        def write_to_file(self, file_name):
            # Write the script to a file
            f = open(file_name, 'w')

            step = 0
            for action in self.actions:
                line = str(step) + ': (' + action.operator + ' ' + ' '.join(action.arguments) + ") [1]\n"
                f.write(line)
                step += 1

            f.close()

        def get_action_sequence(self):
            return [item.operator for item in self.actions]

    class Action():
        def __init__(self, line):
            self.operator = line.split(' ')[0]
            self.arguments = line.split(' ')[1:]

        def compact_rep(self):
            toReturn = self.operator
            for arg in self.arguments:
                toReturn += "\\n" + str(arg)
            return toReturn

        def __str__(self):
            return "(" + ' '.join([self.operator] + self.arguments) + ")"

        def __repr__(self):
            return self.__str__()

    # Get the plan
    with open(file_name, 'r') as f:
        action_list = [line.strip() for line in f.readlines()]

    actions = [Action(line[1:-1].strip(' ').lower()) for line in action_list]

    return Plan(actions)
