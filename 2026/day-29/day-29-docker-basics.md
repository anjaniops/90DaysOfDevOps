# Day 29 – Introduction to Docker

## What is Docker?

Docker is a containerization platform that allows developers and operations teams to package applications and their dependencies into lightweight, portable containers.

### Why Do We Need Containers?

Before containers, applications often worked on one machine but failed on another because of differences in operating systems, libraries, or configurations.

Containers solve this problem by packaging:

* Application code
* Runtime
* Dependencies
* Configuration

into a single portable unit.

### Benefits of Containers

* Consistent environments
* Faster deployments
* Lightweight compared to VMs
* Easy scalability
* Better resource utilization

---

# Containers vs Virtual Machines

| Feature        | Containers   | Virtual Machines |
| -------------- | ------------ | ---------------- |
| Virtualize     | OS Level     | Hardware Level   |
| Size           | MBs          | GBs              |
| Startup Time   | Seconds      | Minutes          |
| Resource Usage | Low          | High             |
| Guest OS       | Not Required | Required         |
| Performance    | Near Native  | Higher Overhead  |

### Key Difference

Containers share the host operating system kernel, while virtual machines run their own complete operating system.

---

# Docker Architecture

Docker consists of:

### Docker Client

The command-line interface used by users.

Example:

```bash
docker run nginx
```

### Docker Daemon (dockerd)

Background service responsible for:

* Building images
* Running containers
* Managing networks
* Managing storage

### Docker Images

Read-only templates used to create containers.

Example:

```bash
nginx
ubuntu
mysql
```

### Docker Containers

Running instances of Docker images.

### Docker Registry

Stores Docker images.

Example:

* Docker Hub
* Amazon ECR
* GitHub Container Registry

---

## Docker Architecture Flow

```text
+------------------+
| Docker Client    |
| (docker CLI)     |
+--------+---------+
         |
         v
+------------------+
| Docker Daemon    |
| (dockerd)        |
+--------+---------+
         |
         v
+------------------+
| Docker Registry  |
| (Docker Hub)     |
+--------+---------+
         |
         v
+------------------+
| Docker Container |
+------------------+
```

---

# Docker Installation Verification

Check Docker version:

```bash
docker --version
```

Example Output:

```bash
Docker version 28.x.x
```

Verify Docker service:

```bash
systemctl status docker
```

---

# Running Hello World

Command:

```bash
docker run hello-world
```

Output Summary:

* Docker client contacted daemon
* Daemon pulled image from Docker Hub
* Container was created
* Container executed successfully

---

# Running an Nginx Container

Command:

```bash
docker run -d -p 8080:80 --name mynginx nginx
```

Explanation:

* `-d` → Detached mode
* `-p 8080:80` → Port mapping
* `--name mynginx` → Custom container name

Verify:

```bash
docker ps
```

Access:

```text
http://localhost:8080
```

Expected Output:

```text
Welcome to nginx!
```

---

# Running Ubuntu in Interactive Mode

Command:

```bash
docker run -it ubuntu bash
```

Inside Container:

```bash
ls
pwd
cat /etc/os-release
```

Exit:

```bash
exit
```

---

# List Running Containers

```bash
docker ps
```

---

# List All Containers

```bash
docker ps -a
```

---

# Stop a Container

```bash
docker stop mynginx
```

---

# Remove a Container

```bash
docker rm mynginx
```

---

# Detached Mode

Command:

```bash
docker run -d nginx
```

Container runs in the background.

Useful for production services.

---

# Custom Container Name

```bash
docker run --name webserver nginx
```

---

# Port Mapping

```bash
docker run -d -p 8080:80 nginx
```

Format:

```bash
-p HOST_PORT:CONTAINER_PORT
```

---

# View Logs

```bash
docker logs mynginx
```

Follow logs live:

```bash
docker logs -f mynginx
```

---

# Execute Commands Inside Running Container

```bash
docker exec -it mynginx bash
```

Example:

```bash
ls /usr/share/nginx/html
```

---

# Commands Practiced Today

```bash
docker --version
docker run hello-world
docker run -d -p 8080:80 --name mynginx nginx
docker run -it ubuntu bash
docker ps
docker ps -a
docker stop mynginx
docker rm mynginx
docker logs mynginx
docker exec -it mynginx bash
```

---

# Screenshots to Capture

1. Docker version
2. Hello-world output
3. Nginx running in browser
4. docker ps output
5. Ubuntu interactive container
6. docker exec into Nginx container

---

# What I Learned

### 1. Containers Are Lightweight

Containers share the host OS kernel and start much faster than virtual machines.

### 2. Docker Uses Images to Create Containers

Images are templates, while containers are running instances of those templates.

### 3. Detached Mode Powers Real Deployments

Using `-d` allows services to run in the background while administrators manage them through logs and exec commands.
