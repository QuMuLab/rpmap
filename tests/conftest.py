from run import create_updated_grammar_file
import pytest

@pytest.fixture(scope="session", autouse=True)
def setUpClass():
    create_updated_grammar_file()