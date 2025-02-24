from flask import Flask, render_template

app = Flask(__name__) # creates an instance of flask class passing __name__ as an argument

@app.route("/") # @ is a decorator (a function that wraps another function)
def home(): # just a function called home
    return render_template("index.html") # pretty much looks for the index.html file in the templates folder

if __name__ == "__main__":
    app.run(debug=True) # just starts the flask dev server in debug mode
