import os
import time
import psycopg2
from psycopg2.extras import RealDictCursor
from flask import Flask, request, jsonify, render_template

app = Flask(__name__)

DB_HOST = os.environ.get("DB_HOST", "db")
DB_NAME = os.environ.get("DB_NAME", "taskdb")
DB_USER = os.environ.get("DB_USER", "taskuser")
DB_PASS = os.environ.get("DB_PASSWORD", "taskpass")
DB_PORT = os.environ.get("DB_PORT", "5432")


def get_conn():
    """Create a new DB connection. Retries a few times in case Postgres
    is still starting up (compose healthcheck should prevent this, but
    being defensive costs nothing)."""
    attempts = 5
    last_err = None
    for _ in range(attempts):
        try:
            return psycopg2.connect(
                host=DB_HOST,
                dbname=DB_NAME,
                user=DB_USER,
                password=DB_PASS,
                port=DB_PORT,
                cursor_factory=RealDictCursor,
            )
        except psycopg2.OperationalError as e:
            last_err = e
            time.sleep(2)
    raise last_err


def init_db():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(
        """
        CREATE TABLE IF NOT EXISTS tasks (
            id SERIAL PRIMARY KEY,
            title VARCHAR(200) NOT NULL,
            done BOOLEAN DEFAULT FALSE,
            created_at TIMESTAMP DEFAULT NOW()
        );
        """
    )
    conn.commit()
    cur.close()
    conn.close()


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/health")
def health():
    """Used by Docker healthcheck and load balancers."""
    try:
        conn = get_conn()
        conn.close()
        return jsonify(status="ok", db="connected"), 200
    except Exception as e:
        return jsonify(status="error", detail=str(e)), 503


@app.route("/api/tasks", methods=["GET"])
def list_tasks():
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("SELECT * FROM tasks ORDER BY id DESC;")
    tasks = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(tasks)


@app.route("/api/tasks", methods=["POST"])
def create_task():
    data = request.get_json(force=True)
    title = data.get("title", "").strip()
    if not title:
        return jsonify(error="title is required"), 400
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO tasks (title) VALUES (%s) RETURNING *;", (title,)
    )
    task = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()
    return jsonify(task), 201


@app.route("/api/tasks/<int:task_id>", methods=["PUT"])
def toggle_task(task_id):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(
        "UPDATE tasks SET done = NOT done WHERE id = %s RETURNING *;",
        (task_id,),
    )
    task = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()
    if not task:
        return jsonify(error="not found"), 404
    return jsonify(task)


@app.route("/api/tasks/<int:task_id>", methods=["DELETE"])
def delete_task(task_id):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("DELETE FROM tasks WHERE id = %s;", (task_id,))
    conn.commit()
    cur.close()
    conn.close()
    return "", 204


if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)
