# Task Tracker — Dockerized (Flask + Postgres)

A minimal task tracker (add / toggle done / delete) built with **Flask**
and **PostgreSQL**, fully containerized with a multi-stage Dockerfile and
orchestrated via **Docker Compose**.

This was built as Day 36 of #90DaysOfDevOps to practice taking a real
two-tier app from code → Dockerfile → Compose → Docker Hub → fresh pull test.

---

## What it does

- Add a task
- Click a task to mark it done/undone
- Delete a task
- All data persisted in Postgres (survives container restarts via a named volume)
- `/health` endpoint checks DB connectivity — used by the container `HEALTHCHECK`

---

## Architecture

```
┌─────────────┐        ┌──────────────┐
│   app (Flask │  -->   │  db (Postgres │
│   + Gunicorn)│        │   16-alpine)  │
└─────────────┘        └──────────────┘
      :5000                  :5432
        \________task-net________/
```

- `app` only starts after `db` reports **healthy** (`depends_on: condition: service_healthy`)
- Postgres data lives in the named volume `pgdata`, so `docker compose down` (without `-v`) keeps your data
- Both services sit on a custom bridge network `task-net`

---

## Run it with Docker Compose

### Option A — Pull pre-built image from Docker Hub

```bash
git clone <this-repo>
cd day-36
cp .env.example .env          # edit values if you want
docker compose up -d
```

The `app` service in `docker-compose.yml` already points at
`anjaniops/task-tracker:latest` from Docker Hub, so `docker compose up`
will pull it if it's not built locally.

### Option B — Build from source

```bash
docker compose build
docker compose up -d
```

Then open: **http://localhost:5000**

### Stop everything

```bash
docker compose down        # keeps the pgdata volume
docker compose down -v     # also wipes the database volume
```

---

## Environment variables (`.env`)

| Variable            | Purpose                          | Default     |
|----------------------|-----------------------------------|--------------|
| `POSTGRES_DB`        | Database name (Postgres container)| `taskdb`     |
| `POSTGRES_USER`       | DB superuser for Postgres image   | `taskuser`   |
| `POSTGRES_PASSWORD`   | DB password for Postgres image    | *(set your own)* |
| `DB_HOST`             | Hostname the app uses to reach DB | `db`         |
| `DB_NAME`             | Must match `POSTGRES_DB`          | `taskdb`     |
| `DB_USER`             | Must match `POSTGRES_USER`        | `taskuser`   |
| `DB_PASSWORD`         | Must match `POSTGRES_PASSWORD`    | *(set your own)* |
| `DB_PORT`             | Postgres port                     | `5432`       |

Copy `.env.example` to `.env` and set real values before running.
**`.env` is gitignored** — never commit real secrets.

---

## Docker Hub

Image: **https://hub.docker.com/r/anjaniops/task-tracker**

```bash
docker pull anjaniops/task-tracker:latest
```

---

## Tech stack

- Python 3.12 / Flask / Gunicorn
- PostgreSQL 16 (alpine)
- Docker multi-stage build, non-root container user
- Docker Compose v2 (healthchecks, named volumes, custom bridge network)
