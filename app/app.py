from flask import Flask, render_template
from .puzzle_generator import generate_puzzle

app = Flask(__name__)

@app.route('/')
def index():
    # Generate the crossword puzzle and pass it to the template
    puzzle = generate_puzzle()
    return render_template('index.html', puzzle=puzzle)

@app.route('/about')
def about():
    return render_template('about.html')

if __name__ == '__main__':
    app.run(debug=True, port=5000)
