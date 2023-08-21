import json
from pycrossword import Crossword

def generate_puzzle():
    # Create a new crossword (using an example size and word list for demonstration)
    crossword = Crossword(15, 15, words=['example', 'crossword', 'puzzle'])
    crossword.compute_crossword(2)  # 2 seconds to compute the crossword

    # Convert crossword to a dictionary and return
    return crossword.to_json()
