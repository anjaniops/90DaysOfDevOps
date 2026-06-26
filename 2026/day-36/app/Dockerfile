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
