import json
import random
from crossword import Crossword

def generate_puzzle(event, context):
    # Extract required parameters from the event
    grid_size = event['grid_size']
    word_lengths = event['word_lengths']

    # Generate the crossword puzzle
    crossword = Crossword(grid_size)
    crossword.generate(word_lengths)

    # Return the puzzle as a JSON response
    response = {
        'statusCode': 200,
        'body': json.dumps(crossword.to_dict())
    }

    return response
