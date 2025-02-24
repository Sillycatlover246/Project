from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# In-memory task list (fucking stupid)
tasks = []

@app.route("/", methods=["GET"])
def index():
    return render_template("index.html", tasks=tasks)

@app.route("/add_task", methods=["POST"])
def add_task():
    task_name = request.form.get("task_name")
    if task_name:
        tasks.append(task_name)
    return redirect(url_for("index"))

@app.route("/remove_task/<int:task_index>", methods=["POST"])
def remove_task(task_index):
    if 0 <= task_index < len(tasks):
        tasks.pop(task_index)
    return redirect(url_for("index"))

if __name__ == "__main__":
    # '0.0.0.0' is important if you're running in Docker
    app.run(host="0.0.0.0", port=5000, debug=True)
