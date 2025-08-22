from lark.visitors import Transformer
class AncEffTransformer(Transformer):
    def __init__(self):
        """Initialize the AncEffTransformer."""
        super().__init__()

    def start(self, children):
        """Start method for the AncEffTransformer."""
        return children

_anceff_parser_lark = ""