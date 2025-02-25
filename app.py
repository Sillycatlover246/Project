import os
from flask import Flask, render_template, request, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# Load secrets from environment variables (GitHub Actions, etc.)
app.config["SECRET_KEY"] = os.environ.get("FLASK_SECRET_KEY", "dev_key")
# In production, avoid hardcoded fallback. Always use a real secret.

# Use DATABASE_URL from environment, fallback to local SQLite for dev
db_uri = os.environ.get("DATABASE_URL", "sqlite:///local_dev.db")
app.config["SQLALCHEMY_DATABASE_URI"] = db_uri
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

# ---------------------------
# DATABASE MODELS
# ---------------------------
class User(db.Model):
    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now())

class Task(db.Model):
    __tablename__ = "tasks"

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    task_name = db.Column(db.String(255), nullable=False)
    completed = db.Column(db.Boolean, nullable=False, default=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now())

# ---------------------------
# ROUTES: AUTHENTICATION
# ---------------------------
@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        # Check if user already exists
        existing_user = User.query.filter_by(username=username).first()
        if existing_user:
            return "Username already taken. Please try another."

        # Hash the password
        pwd_hash = generate_password_hash(password)
        new_user = User(username=username, password_hash=pwd_hash)
        db.session.add(new_user)
        db.session.commit()
        return redirect(url_for("login"))

    return render_template("register.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")

        user = User.query.filter_by(username=username).first()
        if user and check_password_hash(user.password_hash, password):
            # Store user ID in session
            session["user_id"] = user.id
            return redirect(url_for("index"))
        else:
            return "Invalid credentials. Please try again."

    return render_template("login.html")


@app.route("/logout")
def logout():
    session.pop("user_id", None)
    return redirect(url_for("login"))

# ---------------------------
# ROUTES: TASKS
# ---------------------------
@app.route("/")
def index():
    if "user_id" not in session:
        return redirect(url_for("login"))
    user_id = session["user_id"]
    tasks = Task.query.filter_by(user_id=user_id).all()
    return render_template("index.html", tasks=tasks)

@app.route("/add_task", methods=["POST"])
def add_task():
    if "user_id" not in session:
        return redirect(url_for("login"))
    user_id = session["user_id"]

    task_name = request.form.get("task_name")
    if task_name:
        new_task = Task(user_id=user_id, task_name=task_name)
        db.session.add(new_task)
        db.session.commit()
    return redirect(url_for("index"))

@app.route("/remove_task/<int:task_id>", methods=["POST"])
def remove_task(task_id):
    if "user_id" not in session:
        return redirect(url_for("login"))
    user_id = session["user_id"]

    task = Task.query.get(task_id)
    if task and task.user_id == user_id:
        db.session.delete(task)
        db.session.commit()
    return redirect(url_for("index"))

@app.route("/toggle_task/<int:task_id>", methods=["POST"])
def toggle_task(task_id):
    if "user_id" not in session:
        return redirect(url_for("login"))
    user_id = session["user_id"]

    task = Task.query.get(task_id)
    if task and task.user_id == user_id:
        task.completed = not task.completed
        db.session.commit()
    return redirect(url_for("index"))

# ---------------------------
# START APP (LOCAL DEV)
# ---------------------------
if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(host="0.0.0.0", port=5000, debug=True)
