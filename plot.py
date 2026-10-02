import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

def get_data():
    """Gather the run data for every csv file in the evaluation_data folder."""
    data = {}
    for file in os.listdir("evaluation_data"):
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
    
    Also, plot a second line plot where the y-axis is the number of ancillary effects, and the x-axis is the problem number (1-10) for each domain.
    There are n lines in the plot (one for each domain, and each is a different color), and the legend shows which line corresponds to which domain.
    """
    
    # time data plot
    for file, df in data.items():
        # get the domain number from the file name
        domain = file.split("_")[0]
        percentage = [row[1] / (row[1] + row[2]) for row in df]
        
        # plot the data as a scatter plot with domain on x-axis and percentage on y-axis
        # plt.scatter([domain] * len(percentage), percentage, label=f"Domain {domain}", s=1000, alpha=0.25)
        sns.swarmplot(x=[domain] * len(percentage), y=percentage, label=f"Domain {domain}", s=15, alpha=0.75)
    plt.xlabel("Domain")
    plt.ylabel("Percentage of Preprocessing Time of Solve Time")
    plt.title("Percentage of Preprocessing Time of Solve Time by Domain")
    plt.legend()
    plt.show()

    # ancillary effects plot
    for file, df in data.items():
        # get the domain number from the file name
        domain = file.split("_")[0]
        # get the number of ancillary effects from the first column
        num_ancillary_effects = [row[0] for row in df]
        # plot the data as a line plot with problem number on x-axis and number of ancillary effects on y-axis
        plt.plot(range(1, len(num_ancillary_effects) + 1), num_ancillary_effects, label=f"Domain {domain}", linewidth=4.0)
    # Change x-axis tick positions
    plt.xticks(range(1, 11))
    plt.xlabel("Problem Number")
    plt.ylabel("Number of Ancillary Effects")
    plt.title("Number of Ancillary Effects by Problem Number and Domain")
    plt.legend()
    plt.show()


if __name__ == "__main__":
    plot(get_data())