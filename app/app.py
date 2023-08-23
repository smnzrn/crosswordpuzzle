from flask import Flask, render_template
import puz

app = Flask(__name__)

def parse_puz_file(file_path):
    puzzle = puz.read(file_path)
    
    # You can extract various data from the puzzle object.
    # For example:
    title = puzzle.title
    author = puzzle.author
    width = puzzle.width
    height = puzzle.height
    solution = puzzle.solution  # this is the solution grid
    
    # Convert the solution to a 2D list for easier rendering in templates
    solution_grid = [list(solution[i:i+width]) for i in range(0, len(solution), width)]
    
    return {
        "title": title,
        "author": author,
        "width": width,
        "height": height,
        "solution_grid": solution_grid
    }

@app.route('/')
def index():
    parsed_puzzle = parse_puz_file("puzzles/yourfile.puz")
    return render_template('index.html', puzzle=parsed_puzzle)

@app.route('/about')
def about():
    return render_template('about.html')

if __name__ == '__main__':
    app.run(debug=True, port=5000)
