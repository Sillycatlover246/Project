from flask import Flask, render_template, request, redirect, url_for, session

app = Flask(__name__)
app.secret_key = "change_me_in_production"  # Must have a secret key to use sessions

@app.route("/")
def index():
    # Get the user's tasks from session; default to an empty list if not set
    tasks = session.get("tasks", [])
    return render_template("index.html", tasks=tasks)

@app.route("/add_task", methods=["POST"])
def add_task():
    # Grab the "tasks" list from session; create if not exist
    tasks = session.get("tasks", [])

    task_name = request.form.get("task_name", "").strip()
    if task_name:
        # Each task is a dict with a name and completed status
        new_task = {"name": task_name, "completed": False}
        tasks.append(new_task)
    
    # Update session
    session["tasks"] = tasks
    return redirect(url_for("index"))

@app.route("/toggle_task/<int:task_index>", methods=["POST"])
def toggle_task(task_index):
    tasks = session.get("tasks", [])
    if 0 <= task_index < len(tasks):
        tasks[task_index]["completed"] = not tasks[task_index]["completed"]
    session["tasks"] = tasks
    return redirect(url_for("index"))

@app.route("/remove_task/<int:task_index>", methods=["POST"])
def remove_task(task_index):
    tasks = session.get("tasks", [])
    if 0 <= task_index < len(tasks):
        tasks.pop(task_index)
    session["tasks"] = tasks
    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)