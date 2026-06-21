# Day 31 – Dockerfile: Build Your Own Images

## Task 1: My First Dockerfile

### Dockerfile

```dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]
```

### Build Image

```bash
docker build -t my-ubuntu:v1 .
```

### Run Container

```bash
docker run my-ubuntu:v1
```

### Output

```text
Hello from my custom image!
```

---

## Task 2: Dockerfile Instructions

### Project Structure

```text
docker-demo/
├── Dockerfile
└── app.txt
```

### app.txt

```text
Dockerfile Instructions Demo
```

### Dockerfile

```dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY app.txt .

EXPOSE 8080

CMD ["cat", "/app/app.txt"]
```

### Build

```bash
docker build -t docker-demo:v1 .
```

### Run

```bash
docker run docker-demo:v1
```

### Explanation

| Instruction | Purpose                               |
| ----------- | ------------------------------------- |
| FROM        | Sets base image                       |
| RUN         | Executes commands during build        |
| WORKDIR     | Sets working directory                |
| COPY        | Copies files into image               |
| EXPOSE      | Documents application port            |
| CMD         | Default command when container starts |

---

## Task 3: CMD vs ENTRYPOINT

### CMD Example

Dockerfile:

```dockerfile
FROM alpine

CMD ["echo", "hello"]
```

Run:

```bash
docker run cmd-demo
```

Output:

```text
hello
```

Override command:

```bash
docker run cmd-demo ls
```

Result:

```text
Runs ls instead of echo hello
```

### ENTRYPOINT Example

Dockerfile:

```dockerfile
FROM alpine

ENTRYPOINT ["echo"]
```

Run:

```bash
docker run entrypoint-demo hello
```

Output:

```text
hello
```

Run:

```bash
docker run entrypoint-demo Docker
```

Output:

```text
Docker
```

### CMD vs ENTRYPOINT

| CMD                          | ENTRYPOINT                    |
| ---------------------------- | ----------------------------- |
| Default command              | Fixed executable              |
| Easily overridden            | Arguments appended            |
| Good for flexible containers | Good for dedicated containers |

---

## Task 4: Simple Web App Image

### index.html

```html
<!DOCTYPE html>
<html>
<head>
<title>My Docker Website</title>
</head>
<body>
<h1>Welcome to My Docker Website</h1>
<p>Day 31 - Dockerfile Practice</p>
</body>
</html>
```

### Dockerfile

```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html
```

### Build

```bash
docker build -t my-website:v1 .
```

### Run

```bash
docker run -d -p 8080:80 --name my-website my-website:v1
```

### Access

```text
http://localhost:8080
```

---

## Task 5: .dockerignore

### .dockerignore

```text
node_modules
.git
*.md
.env
```

### Why Use It?

* Reduces image size
* Improves build speed
* Prevents sensitive files from entering images
* Reduces build context sent to Docker daemon

---

## Task 6: Build Optimization & Layer Caching

### Initial Build

```dockerfile
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y curl

COPY . .

CMD ["bash"]
```

Docker caches each layer after the first build.

### Why Layer Order Matters

Docker builds images layer by layer.

If a layer changes, Docker rebuilds that layer and all layers after it.

Best Practice:

```dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .
```

Frequently changing application code should be copied near the end.

### Benefits

* Faster rebuilds
* Better cache utilization
* Reduced CI/CD build time

---

## Key Learnings

1. Docker images are templates used to create containers.
2. Dockerfiles define images using instructions such as FROM, RUN, COPY, WORKDIR, EXPOSE, CMD, and ENTRYPOINT.
3. Docker uses layered architecture and caching to optimize storage and build performance.
4. CMD provides default commands while ENTRYPOINT defines the container's primary executable.
5. .dockerignore helps keep images smaller and more secure.
6. Proper Dockerfile ordering significantly improves build speed.
