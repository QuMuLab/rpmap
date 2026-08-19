from run import create_updated_grammar_file
import pytest

@pytest.fixture(scope="session", autouse=True)
def setUpClass():
    # before tests are run, perform a fresh reconstruction of the grammar file
    # also ensures that pddl classes (e.g. Predicate) are updated with our new attributes and functions before testing
    create_updated_grammar_file()