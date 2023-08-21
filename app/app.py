from flask import Flask, render_template
import puz

app = Flask(__name__)

@app.route('/')
def index():
    # Use puzpy here to generate the crossword puzzle and pass it to the template
    puzzle = puz.Puzzle()  # Example of creating a new puzzle. You'd have to modify and expand on this.
    return render_template('index.html', puzzle=puzzle)

@app.route('/about')
def about():
    return render_template('about.html')

if __name__ == '__main__':
    app.run(debug=True, port=5000)
