# Day 35 – Multi-Stage Builds & Docker Hub

## Objective

Learn how to create optimized Docker images using Multi-Stage Builds and publish them to Docker Hub.

---

# Task 1: The Problem with Large Images

## Simple Node.js Application

### app.js

```javascript
console.log("Hello from Docker Multi-Stage Build!");
```

### package.json

```json
{
  "name": "docker-multistage-demo",
  "version": "1.0.0",
  "main": "app.js"
}
```

## Single-Stage Dockerfile

```dockerfile
FROM node:22

WORKDIR /app

COPY . .

CMD ["node", "app.js"]
```

## Build Image

```bash
docker build -t node-single:v1 .
```

## Check Image Size

```bash
docker images
```

Example Output:

| Image | Size |
|---------|---------|
| node-single:v1 | 1.12GB |

### Observation

The image contains:

- Node runtime
- Build dependencies
- Package manager
- Temporary files
- Entire build environment

This makes the image unnecessarily large.

---

# Task 2: Multi-Stage Build

## Multi-Stage Dockerfile

```dockerfile
# Build Stage
FROM node:22 AS builder

WORKDIR /app

COPY . .

# Runtime Stage
FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app .

CMD ["node", "app.js"]
```

## Build Multi-Stage Image

```bash
docker build -t node-multistage:v1 .
```

## Check Image Size

```bash
docker images
```

Example Output:

| Image | Size |
|---------|---------|
| node-single:v1 | 1.12GB |
| node-multistage:v1 | 180MB |

---

## Size Comparison

| Type | Size |
|---------|---------|
| Single Stage | 1.12GB |
| Multi Stage | 180MB |

### Why Multi-Stage Images Are Smaller

Multi-stage builds separate the build environment from the runtime environment.

Only the required application files are copied into the final image.

Benefits:

- Smaller image size
- Faster deployments
- Reduced attack surface
- Improved security
- Faster image pulls

---

# Task 3: Push Image to Docker Hub

## Login

```bash
docker login
```

## Tag Image

```bash
docker tag node-multistage:v1 anjaniops/node-multistage:v1
```

## Push Image

```bash
docker push anjaniops/node-multistage:v1
```

## Verify

Remove local image:

```bash
docker rmi anjaniops/node-multistage:v1
```

Pull again:

```bash
docker pull anjaniops/node-multistage:v1
```

Run container:

```bash
docker run anjaniops/node-multistage:v1
```

Output:

```bash
Hello from Docker Multi-Stage Build!
```

---

# Task 4: Docker Hub Repository

## Repository Information

Repository:

```text
anjaniops/node-multistage
```

### Added Repository Description

```text
Node.js application demonstrating Docker Multi-Stage Builds.
```

---

## Tags

Available Tags:

```text
v1
latest
```

### Pull Specific Version

```bash
docker pull anjaniops/node-multistage:v1
```

### Pull Latest Version

```bash
docker pull anjaniops/node-multistage:latest
```

### Difference

- Specific tags provide predictable deployments.
- latest always points to the newest pushed image.

Production environments should use version tags instead of latest.

---

# Task 5: Docker Image Best Practices

## 1. Use Minimal Base Images

### Ubuntu

```dockerfile
FROM ubuntu:24.04
```

Size:

```text
~80MB+
```

### Alpine

```dockerfile
FROM alpine:3.22
```

Size:

```text
~8MB
```

### Observation

Alpine significantly reduces image size.

---

## 2. Run as Non-Root User

```dockerfile
FROM alpine:3.22

RUN adduser -D appuser

USER appuser

CMD ["echo", "Running as non-root user"]
```

### Benefit

Improves container security by avoiding root privileges.

---

## 3. Reduce Layers

### Bad Example

```dockerfile
RUN apk update
RUN apk add curl
RUN apk add vim
```

### Better Example

```dockerfile
RUN apk update && \
    apk add curl vim
```

### Benefit

Creates fewer image layers and reduces image size.

---

## 4. Use Specific Tags

### Avoid

```dockerfile
FROM node:latest
```

### Recommended

```dockerfile
FROM node:22-alpine
```

### Benefit

Ensures consistent and predictable builds.

---

# Commands Used

```bash
docker build -t image-name:tag .

docker images

docker login

docker tag local-image username/repository:tag

docker push username/repository:tag

docker pull username/repository:tag

docker rmi image-name

docker run image-name

docker image history image-name
```

---

# Key Learnings

1. Docker images are built in layers.
2. Multi-stage builds reduce image size significantly.
3. Smaller images improve security and deployment speed.
4. Docker Hub enables image sharing and distribution.
5. Running containers as non-root users improves security.
6. Alpine images are preferred for lightweight containers.
7. Version tags are safer than using latest in production.
8. Combining RUN instructions reduces image layers.

---

# Conclusion

Today I learned how Multi-Stage Builds help create smaller, cleaner, and more secure Docker images. I also pushed my first optimized image to Docker Hub and explored image versioning, tagging, and best practices used in production environments.

Docker Multi-Stage Builds are an essential skill for building efficient containerized applications and are widely used in modern DevOps workflows.