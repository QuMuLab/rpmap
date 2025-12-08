import csv

filename = "evaluation/original_grapevine_evaluation.csv"

# Step 1: read everything
rows = []
with open(filename, newline="") as f_in:
    reader = csv.reader(f_in)
    for row in reader:
        # modify 6th column if possible
        try:
            row[6] = round(float(row[6]), 2)
        except (ValueError, IndexError):
            pass
        rows.append(row)

# Step 2: write it back to the same file
with open(filename, "w", newline="") as f_out:
    writer = csv.writer(f_out)
    writer.writerows(rows)

print("Done! Updated", filename, "in place ✨")
