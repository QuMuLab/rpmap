import pandas as pd
import matplotlib.pyplot as plt
import os

TITLE_SIZE = 30
XY_LABEL_SIZE = 25
TICK_SIZE = 23
MARKERSIZE = 15
MARKERSTYLE = "s"

def get_data():
    """Gather the run data for every csv file in the evaluation_data folder."""
    data = {}
    for file in sorted(os.listdir("evaluation_data")):
        df = pd.read_csv(os.path.join("evaluation_data", file), header=None)
        # only take columns 5-7 (number of ancillary effects, preprocessing time, and solve time)
        # store the results as a list
        all_values = df.values.tolist()
        all_values = [row[4:] for row in all_values]
        data[file.split(".csv")[0]] = all_values
    return data

def plot(data):
    """Plot the time data where the domain number (each file) is on the x-axis, and the percentage of preprocessing time of the solve time is the y-axis.
    Each domain has 10 problem files, so there are 10 points on the y-axis for each domain on the x-axis, in a scatter plot format.
    
    Plot a second line plot where the y-axis is the number of ancillary effects, and the x-axis is the problem number (1-10) for each domain.
    There are n lines in the plot (one for each domain, and each is a different color), and the legend shows which line corresponds to which domain.

    Finally, plot a third line plot where the x-axis is the time and the y-axis is the problem number.
    """
    # % of preprocessing time of solve time plot
    x_ticks = []
    x_ticks_vals = []
    _, ax = plt.subplots()
    # separate the domains with this distance on the x-axis, so that the points for each domain are not too close together
    domain_width = 0.1
    # value of the last value placed on the x-axis
    last_x = 0
    # time data plot
    for i in range(len(data)):
        file = list(data.keys())[i]
        df = data[file]
        # get the domain number from the file name
        domain = file.split("_")[1]
        percentage = [row[1] / (row[1] + row[2]) for row in df]
        # Add a vertical dashed line spanning the whole plot to differentiate the domains
        if i > 0:
            x_axis = [round(domain_width + i + (0.1 * j), 2) for j in range(len(percentage))]
            x_ticks_vals.append(last_x + round((x_axis[0] - last_x) / 2, 2))
            plt.axvline(x=x_ticks_vals[-1], color='grey', linestyle='--', linewidth=1)
        else:
            x_ticks_vals.append(0)
            x_axis = [round(i + (0.1 * j), 2) for j in range(len(percentage))]
        last_x = x_axis[-1]
        x_ticks.append(domain)
        # plot the data as a scatter plot with domain on x-axis and percentage on y-axis
        plt.plot(x_axis, percentage, label=domain, linestyle="", marker=".", markersize=25)
        # add the points that timed out with a special marker
        timeout = [1.0] * (10 - len(percentage))
        if timeout:
            x_axis_timeout = [round(domain_width + i + (0.1 * j), 2) for j in range(len(percentage), 10)]
            plt.plot(x_axis_timeout, timeout, label=f"preprocessing timeout", linestyle="", marker="x", markersize=MARKERSIZE, color="red", markeredgewidth=3)
            last_x = x_axis_timeout[-1]
    # Change both axes at the same time
    ax.tick_params(axis="y", labelsize=TICK_SIZE*1.3)
    # For a specific axes object
    # ax.set_xlabel("Domain", fontsize=XY_LABEL_SIZE)
    # ax.set_xlabel(None)
    ax.set_xticks([])
    ax.tick_params(labelbottom=False)
    ax.set_ylabel("Preprocessing Time over Total Time", fontsize=XY_LABEL_SIZE)
    # ax.set_title("Preprocessing Time over Total Time by Domain", fontsize=TITLE_SIZE)
    # Add a horizontal dotted line at y = 1.0
    plt.axhline(y=1.0, color='black', linestyle=':', linewidth=1)
    # plt.xticks(x_ticks_vals, x_ticks)
    plt.xlim(left=-0.1)
    plt.ylim(bottom=-0.01)
    # 1. Get all handles and labels
    handles, labels = ax.get_legend_handles_labels()
    # 2. Filter out duplicates while preserving order
    # create a dictionary excluding the Timeout label
    unique_labels = {}
    timeout_handle = None
    for handle, label in zip(handles, labels):
        if label != "preprocessing timeout":
            unique_labels[label] = handle
        else:
            timeout_handle = handle
    if timeout_handle:
        unique_labels["preprocessing timeout"] = timeout_handle
    # 3. Pass the unique handles and labels to the legend
    ax.legend(unique_labels.values(), unique_labels.keys(), fontsize=TICK_SIZE, loc="upper left")
    plt.show()

    _, ax = plt.subplots()
    # ancillary effects plot
    for file, df in data.items():
        # get the domain number from the file name 
        domain = file.split("_")[1]
        # get the number of ancillary effects from the first column
        num_ancillary_effects = [row[0] for row in df]
        # plot the data as a line plot with problem number on x-axis and number of ancillary effects on y-axis
        plt.plot(range(1, len(num_ancillary_effects) + 1), num_ancillary_effects, label=f"{domain}", linewidth=4.0, marker=MARKERSTYLE, markersize=MARKERSIZE)
    plt.xticks(range(1, 11))
    # plt.xlim(left=1, right=10)
    ax.set_yscale("log")
    ax.tick_params(axis="both", labelsize=TICK_SIZE*1.5)
    ax.set_xlabel("Problem Number", fontsize=XY_LABEL_SIZE*1.5)
    ax.set_ylabel("Number of Ancillary Effects", fontsize=XY_LABEL_SIZE*1.5)
    # ax.set_title("Number of Ancillary Effects by Domain and Problem Number", fontsize=TITLE_SIZE*1.5)
    ax.legend(fontsize=TICK_SIZE*1.1, loc="lower right")
    plt.show()

    # coverage plot
    _, ax = plt.subplots()
    data_sum_time = {file: [] for file in data}
    for file in data:
        for row in data[file]:
            data_sum_time[file].append(row[1] + row[2])
    for file in data_sum_time:
        # get the domain number from the file name 
        domain = file.split("_")[1]
        # plot the data as a line plot with the time on the x-axis and the problem number on the y-axis
        plt.plot(data_sum_time[file], range(1, len(data_sum_time[file]) + 1), label=f"{domain}", linewidth=4.0, marker=MARKERSTYLE, markersize=MARKERSIZE)
    # plt.ylim(bottom=1, top=10)
    ax.set_xscale("log")
    ax.tick_params(axis="both", labelsize=TICK_SIZE)
    ax.set_xlabel("Time (s)", fontsize=XY_LABEL_SIZE)
    ax.set_ylabel("Coverage (# of Problems Solved)", fontsize=XY_LABEL_SIZE)
    # ax.set_title("Coverage Against Time for each Domain", fontsize=TITLE_SIZE)
    ax.legend(fontsize=TICK_SIZE*1.1, loc="lower right")
    plt.show()


if __name__ == "__main__":
    plot(get_data())