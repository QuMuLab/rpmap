import re

def extract_predicates_lines(text: str, section: str):
    """Extract each predicate line inside the PDDL section."""
    # Remove comments (anything after a semicolon)
    text = re.sub(r";.*", "", text)

    # Find start of (:predicates
    start_match = re.search(rf"\(:\s*{section}\b", text, flags=re.IGNORECASE)
    if not start_match:
        raise ValueError(f"No (:{section} ...) section found.")
    
    start_index = start_match.end()

    # Find matching closing parenthesis (for the section)
    depth = 1
    i = start_index
    while i < len(text) and depth > 0:
        if text[i] == "(":
            depth += 1
        elif text[i] == ")":
            depth -= 1
        i += 1

    if depth != 0:
        raise ValueError(f"Unbalanced parentheses in (:{section} ...) section.")

    block = text[start_index:i-1]

    # Split by lines, strip whitespace, and remove empties
    preds = [line.strip() for line in block.splitlines() if line.strip()]
    return sorted(preds)


def compare_predicates_files(file1: str, file2: str, section: str):
    """Compare predicate lists of two PDDL domain files."""
    with open(file1, 'r', encoding='utf-8') as f1, open(file2, 'r', encoding='utf-8') as f2:
        text1, text2 = f1.read(), f2.read()

    preds1 = extract_predicates_lines(text1, section)
    preds2 = extract_predicates_lines(text2, section)

    set1, set2 = set(preds1), set(preds2)
    only_in_1 = sorted(set1 - set2)
    only_in_2 = sorted(set2 - set1)

    if not only_in_1 and not only_in_2:
        print("✅ Predicates are identical (ignoring order and spacing).")
    else:
        print("❌ Predicates differ!\n")
        if only_in_1:
            print("Only in file 1:")
            for p in only_in_1:
                print("  ", p)
        if only_in_2:
            print("\nOnly in file 2:")
            for p in only_in_2:
                print("  ", p)

    return preds1, preds2


# --- Example usage ---
if __name__ == "__main__":
    compare_predicates_files("pdkb-problem.pddl", "bdi_extension/bdi_pdkbddl_files/grounded_problem.pdkbddl", "init")
