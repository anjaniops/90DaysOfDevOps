# Day 34 – Docker Compose: Real-World Multi-Container Apps

## Objective

Build a production-like multi-container application stack using:

* Flask Web Application
* PostgreSQL Database
* Redis Cache
* Docker Compose
* Health Checks
* Restart Policies
* Named Networks & Volumes

---

# Project Structure

```text
day-34/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── docker-compose.yml
└── day-34-compose-advanced.md
```

---

# Task 1: Build a 3-Service Application Stack

## Flask Application

### app.py

```python
from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Docker Compose Multi-Container App!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

### requirements.txt

```text
flask
psycopg2-binary
redis
```

---

## Dockerfile

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

---

# Task 2: Docker Compose with Healthchecks

## docker-compose.yml

```yaml
version: "3.9"

services:

  web:
    build: ./app
    container_name: flask-app

    ports:
      - "5000:5000"

    depends_on:
      db:
        condition: service_healthy

    networks:
      - app-network

    labels:
      project: "day34"
      service: "web"

  db:
    image: postgres:16

    container_name: postgres-db

    restart: always

    environment:
      POSTGRES_USER: devops
      POSTGRES_PASSWORD: password
      POSTGRES_DB: devopsdb

    volumes:
      - postgres_data:/var/lib/postgresql/data

    networks:
      - app-network

    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U devops"]
      interval: 10s
      timeout: 5s
      retries: 5

    labels:
      project: "day34"
      service: "database"

  redis:
    image: redis:latest

    container_name: redis-cache

    networks:
      - app-network

    labels:
      project: "day34"
      service: "cache"

networks:
  app-network:
    driver: bridge

volumes:
  postgres_data:
```

---

# Task 3: Restart Policies

## restart: always

```yaml
restart: always
```

Behavior:

* Container restarts automatically
* Restarts after reboot
* Restarts after crashes

Best for:

* Databases
* Production services

---

## restart: on-failure

```yaml
restart: on-failure
```

Behavior:

* Restarts only when application exits with non-zero code

Best for:

* Batch jobs
* Worker containers

---

# Testing Restart Policy

Kill database container:

```bash
docker kill postgres-db
```

Verify restart:

```bash
docker ps
```

Result:

Database container automatically starts again.

---

# Task 4: Build From Dockerfile

Instead of pulling a pre-built image:

```yaml
build: ./app
```

Compose builds directly from Dockerfile.

---

## Rebuild Application

After code changes:

```bash
docker compose up --build -d
```

Compose:

* Rebuilds image
* Recreates container
* Applies new code

---

# Task 5: Named Networks and Volumes

## Network

```yaml
networks:
  app-network:
    driver: bridge
```

Benefits:

* Better isolation
* Service discovery
* Easier troubleshooting

---

## Volume

```yaml
volumes:
  postgres_data:
```

Benefits:

* Persistent storage
* Data survives container deletion
* Suitable for databases

---

## Labels

```yaml
labels:
  project: "day34"
  service: "web"
```

Benefits:

* Metadata for containers
* Easier filtering
* Better organization

---

# Task 6: Scaling

Scale Web Service

```bash
docker compose up --scale web=3 -d
```

Result:

```text
web_1
web_2
web_3
```

Three containers are created.

---

# What Breaks?

Port Mapping Conflict

All replicas attempt:

```yaml
ports:
  - "5000:5000"
```

Only one container can bind to port 5000.

Remaining replicas fail.

---

# Why Scaling Doesn't Work Well in Compose

Docker Compose lacks:

* Built-in Load Balancer
* Service Mesh
* Ingress Controller

This problem is solved by:

* Kubernetes Services
* Docker Swarm
* Nginx Load Balancer

---

# Commands Used

## Build Stack

```bash
docker compose up -d
```

## View Running Containers

```bash
docker ps
```

## View Logs

```bash
docker compose logs
```

## Follow Logs

```bash
docker compose logs -f
```

## Rebuild

```bash
docker compose up --build -d
```

## Scale

```bash
docker compose up --scale web=3 -d
```

## Stop Stack

```bash
docker compose down
```

## Remove Volumes

```bash
docker compose down -v
```

---

# Key Learnings

1. Docker Compose simplifies multi-container application deployment.
2. Health checks ensure services start only when dependencies are truly ready.
3. Restart policies improve application resilience.
4. Named volumes provide persistent storage.
5. Networks enable secure communication between services.
6. Scaling containers introduces load-balancing challenges.
7. Docker Compose is excellent for development environments and learning production concepts before Kubernetes.

---

## Conclusion

Today I deployed a real-world application stack consisting of:

* Flask Application
* PostgreSQL Database
* Redis Cache

using Docker Compose with health checks, restart policies, custom networks, volumes, labels, and scaling.

This felt much closer to how real applications are deployed in production environments.
