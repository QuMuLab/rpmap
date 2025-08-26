NL = "\n"
NL_AND_TAB = "\n" + "\t"
NL_AND_TABS = "\n" + "\t" * 2
NL_AND_3_TABS = "\n" + "\t" * 3

# general function for recursive printing of Tokens/lists of Tokens
def recursive_print(tree, outer_sep=""):
    new_str = []
    if type(tree) == list:
        for child in tree:
            if type(child) == list:
                # other printing type is defined
                if type(child[0]) == str:
                    if child[0] == "COMPOUND": # printing a list comp 
                        new_str.append(recursive_print(child[1:], " "))
                else:
                    new_str.append(recursive_print(child, ""))
            else:
                new_str.append(recursive_print(child, ""))
        return outer_sep.join(new_str)
    else:
        return str(tree) if tree else ""