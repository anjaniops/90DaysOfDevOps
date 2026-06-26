# Day 36 – Docker Project: Dockerize a Full Application

## What app I chose and why

I built a small **Task Tracker** app — Flask backend + PostgreSQL database
— instead of using an existing repo. Reason: I wanted a real two-tier app
(stateless app + stateful DB) so I'd actually have to deal with the things
that matter on the job — service startup ordering, DB healthchecks, volume
persistence, and a non-root multi-stage image — rather than Dockerizing
something trivial with no DB dependency.

**Stack:** Python 3.12, Flask, Gunicorn, psycopg2, PostgreSQL 16 (alpine)

Repo path: `2026/day-36/`

```
day-36/
├── app/
│   ├── app.py            # Flask routes + DB logic
│   ├── entrypoint.sh     # init DB schema, then start gunicorn
│   ├── requirements.txt
│   ├── Dockerfile
│   ├── .dockerignore
│   └── templates/index.html
├── docker-compose.yml
├── .env.example
├── .gitignore
└── README.md
```

---

## The Dockerfile (with comments)

```dockerfile
# ---------- Stage 1: Builder ----------
# Use slim base for a smaller footprint. This stage only exists to compile
# Python dependencies (some need build tools) so the final image doesn't
# carry gcc/build headers around.
FROM python:3.12-slim AS builder

# Build deps needed for psycopg2 / compiling wheels
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Copy only requirements first -> Docker layer cache hit on rebuilds
# unless requirements.txt itself changes.
COPY requirements.txt .

# Install into a local target dir so we can copy just the installed
# packages into the final stage (no pip cache, no build tools).
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# ---------- Stage 2: Runtime ----------
# Fresh slim image, none of the build tools from stage 1 end up here.
FROM python:3.12-slim AS runtime

# Only the runtime lib for Postgres client (psycopg2 needs libpq.so),
# not the full -dev headers.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq5 \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user/group to run the app — never run as root in prod.
RUN groupadd -r appgroup && useradd -r -g appgroup -d /app appuser

WORKDIR /app

# Bring in the installed Python packages from the builder stage.
COPY --from=builder /install /usr/local

# Copy application source.
COPY app.py entrypoint.sh ./
COPY templates ./templates

# Make entrypoint executable and hand ownership of /app to the non-root user.
RUN chmod +x entrypoint.sh && chown -R appuser:appgroup /app

# Drop privileges.
USER appuser

ENV PYTHONUNBUFFERED=1
EXPOSE 5000

# Container-level healthcheck hitting the Flask /health route.
HEALTHCHECK --interval=15s --timeout=3s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

ENTRYPOINT ["./entrypoint.sh"]
```

**Why multi-stage:** `psycopg2` needs `gcc` + `libpq-dev` to build, but the
running container only needs the shared lib `libpq5`. Building in a
throwaway `builder` stage and copying just the installed packages
(`/install` → `/usr/local`) into the runtime stage keeps `gcc`/`libpq-dev`
(~150MB+ of build tooling) out of the final image entirely.

**Why non-root:** `appuser` is created with no login shell and owns only
`/app`. If the app is ever compromised via a dependency RCE, the attacker
doesn't get root inside the container.

---

## docker-compose.yml

```yaml
services:
  app:
    build:
      context: ./app
    image: anjaniops/task-tracker:latest
    container_name: task-tracker-app
    ports:
      - "5000:5000"
    environment:
      DB_HOST: ${DB_HOST}
      DB_NAME: ${DB_NAME}
      DB_USER: ${DB_USER}
      DB_PASSWORD: ${DB_PASSWORD}
      DB_PORT: ${DB_PORT}
    depends_on:
      db:
        condition: service_healthy
    networks:
      - task-net
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    container_name: task-tracker-db
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 5s
      timeout: 5s
      retries: 5
      start_period: 10s
    networks:
      - task-net
    restart: unless-stopped

networks:
  task-net:
    driver: bridge

volumes:
  pgdata:
```

Key points:
- `depends_on: condition: service_healthy` — `app` won't even start until
  Postgres's `pg_isready` healthcheck passes, not just until the container
  exists (which is the mistake most people make with plain `depends_on`).
- `pgdata` named volume — data survives `docker compose down` / restarts.
- Custom bridge network `task-net` — app and db talk to each other by
  service name (`db`), isolated from other compose projects on the host.

---

## Challenges faced and how I solved them

1. **`depends_on` doesn't wait for "ready", just "started"** — by default
   Compose's `depends_on` only waits for the container process to launch,
   not for Postgres to actually accept connections. Fixed by adding a
   `healthcheck` with `pg_isready` on the `db` service and using
   `condition: service_healthy` on the `app` side.

2. **App crashing on first boot even with the healthcheck** — Postgres
   reports healthy before it's *fully* ready to accept every type of
   connection in some edge cases, and on first run the `tasks` table
   doesn't exist yet. Solved two ways: a retry loop inside `get_conn()` in
   `app.py` (5 attempts, 2s apart) and running `init_db()` from
   `entrypoint.sh` before starting Gunicorn, so schema creation happens
   exactly once per container start, before any request is served.

3. **Keeping the image small** — first version (no multi-stage) pulled in
   `gcc` and `libpq-dev` into the final image just to build `psycopg2`.
   Splitting into `builder` + `runtime` stages and only copying the
   installed site-packages across removed all the build tooling from the
   shipped image.

4. **Secrets in the repo** — didn't want real DB passwords committed.
   Solution: real `.env` is gitignored; `.env.example` with placeholder
   values is committed instead, and README tells users to copy + edit it.

---

## Final image size

```bash
docker images anjaniops/task-tracker:latest
```

> Multi-stage + slim base + no build tools in the final layer brings this
> well under what a naive single-stage `python:3.12` build would produce
> (a non-multi-stage build with gcc/libpq-dev baked in typically lands
> 150–250MB heavier). Run the command above after building locally and
> note the actual `SIZE` column value here.

---

## Docker Hub

**Image:** `anjaniops/task-tracker:latest`
**Link:** https://hub.docker.com/r/anjaniops/task-tracker

### Build, tag, and push (run these locally)

```bash
cd 2026/day-36

# Build
docker compose build

# Tag (compose already builds it as anjaniops/task-tracker:latest,
# but tagging explicitly with a version too is good practice)
docker tag anjaniops/task-tracker:latest anjaniops/task-tracker:v1

# Login
docker login

# Push both tags
docker push anjaniops/task-tracker:latest
docker push anjaniops/task-tracker:v1
```

---

## Task 5: Fresh pull test (the real proof)

```bash
# 1. Nuke everything local
docker compose down -v
docker rmi anjaniops/task-tracker:latest
docker system prune -af

# 2. Pull straight from Docker Hub and run using ONLY the compose file
docker compose up -d

# 3. Verify
docker compose ps
curl http://localhost:5000/health
# Expected: {"status": "ok", "db": "connected"}

curl -X POST http://localhost:5000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "test from fresh pull"}'

curl http://localhost:5000/api/tasks
```

If `/health` returns `{"status": "ok", "db": "connected"}` and the task
round-trips through the API, the image is genuinely self-contained — it
isn't secretly relying on anything that only existed in my local build
cache.

---

## Submission checklist

- [x] `Dockerfile` — multi-stage, non-root, slim, healthcheck
- [x] `.dockerignore`
- [x] `docker-compose.yml` — app + db, volume, custom network, env vars, db healthcheck
- [x] `.env.example` (real `.env` gitignored)
- [x] `README.md` — what it does, how to run, env vars
- [x] `day-36-docker-project.md` — this file
- [ ] Image pushed to Docker Hub (run the commands above)
- [ ] Fresh-pull test passed (run the commands above)
- [ ] Shared on LinkedIn with Docker Hub link, `#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham`
