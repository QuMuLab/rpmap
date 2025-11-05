import re

def normalize_effect(effect: str, is_generated: bool) -> str:
    """Clean up effect strings and normalize for fair comparison."""
    effect = re.sub(r";[^\n]*", "", effect)  # remove comments
    effect = re.sub(r"\s+", " ", effect).strip()  # collapse whitespace
    # Remove a stray trailing parenthesis (ground truth sometimes has one more)
    effect = re.sub(r"\)+\s*$", ")", effect)
    if is_generated:
        # convert PB → P in generated file
        effect = re.sub(r"\bPB", "P", effect)
    return effect

def extract_action_block(text: str, action_name: str) -> str:
    """Extract a specific (:action name ...) block."""
    pattern = rf"\(:action\s+{re.escape(action_name)}\b(.*?)\)\s*(?=\(:action|\Z)"
    match = re.search(pattern, text, flags=re.S)
    return match.group(1) if match else ""

def extract_effects(block: str, is_generated: bool) -> set:
    """Extract all (when ...) effects from an action block."""
    # Get the effect section
    match = re.search(r":effect\s*\((.*?)\)\s*\)?$", block, flags=re.S)
    if not match:
        return set()

    content = match.group(1)
    # Split on "(when" but keep the token
    parts = re.split(r"(?=\(when)", content)
    effects = [
        normalize_effect(p, is_generated)
        for p in parts
        if "(when" in p
    ]
    return set(effects)

def compare_effects(generated_file: str, truth_file: str, action_name: str):
    """Compare effects of one action between generated and truth PDDL files."""
    with open(generated_file, encoding="utf-8") as f1, open(truth_file, encoding="utf-8") as f2:
        gen_text, truth_text = f1.read(), f2.read()

    gen_block = extract_action_block(gen_text, action_name)
    truth_block = extract_action_block(truth_text, action_name)
    if not gen_block or not truth_block:
        print(f"⚠️ Action '{action_name}' not found in one or both files.")
        return

    gen_effects = extract_effects(gen_block, is_generated=True)
    truth_effects = extract_effects(truth_block, is_generated=False)

    missing = sorted(truth_effects - gen_effects)
    incorrect = sorted(gen_effects - truth_effects)

    print(f"=== Action: {action_name} ===")
    print("missing effects:")
    for e in missing:
        print(e, "\n")
    print("\nincorrect effects:")
    for e in incorrect:
        print(e, "\n")

def extract_all_action_names_from_text(text: str):
    """
    Return a list of action names found in the given PDDL text.
    Uses a case-insensitive search for '(:action <name'.
    """
    names = re.findall(r"\(:action\s+([^\s\)]+)", text, flags=re.IGNORECASE)
    # dedupe and preserve sort order
    seen = set()
    out = []
    for n in names:
        if n not in seen:
            seen.add(n)
            out.append(n)
    return out

# Example usage:
text = open("bdi_extension/bdi_pdkbddl_files/grounded_domain.pdkbddl", encoding="utf-8").read()
actions = extract_all_action_names_from_text(text)
for a in actions:
    compare_effects("bdi_extension/bdi_pdkbddl_files/grounded_domain.pdkbddl", "pdkb-domain.pddl", a)
# compare_effects("bdi_extension/bdi_pdkbddl_files/grounded_domain.pdkbddl", "pdkb-domain.pddl", "share_a_b_l1")
