# Day 37 – Docker Revision & Cheat Sheet

## 📌 Overview

Today was all about revision.

Instead of learning something new, I reviewed everything I covered from **Day 29 to Day 36** to strengthen my Docker fundamentals. Revisiting concepts helped me identify areas where I'm confident and topics that still need more hands-on practice.

---

## ✅ What I Revised

* Docker Architecture
* Images vs Containers
* Image Layers & Build Cache
* Dockerfile Instructions
* CMD vs ENTRYPOINT
* Volumes & Bind Mounts
* Docker Networks
* Docker Compose
* Environment Variables (.env)
* Multi-Stage Builds
* Docker Hub
* Health Checks & `depends_on`
* Docker Cleanup Commands

---

## 📝 Self Assessment

| Topic              | Status                |
| ------------------ | --------------------- |
| Running Containers | ✅                     |
| Docker Images      | ✅                     |
| Dockerfile         | ✅                     |
| Docker Compose     | ✅                     |
| Multi-stage Builds | ✅                     |
| Docker Hub         | ✅                     |
| Health Checks      | ✅                     |
| CMD vs ENTRYPOINT  | ⚠️ Need More Practice |
| Bind Mounts        | ⚠️ Need More Practice |

---

## 💡 Key Takeaways

* Containers are created from images.
* Volumes keep data persistent even after containers are removed.
* Multi-stage builds create smaller and more secure production images.
* Health checks make Docker Compose deployments more reliable.
* Docker Compose simplifies managing multi-container applications.

---

## 📚 Docker Cheat Sheet

### Container Commands

```bash
docker run -it ubuntu bash
docker run -d nginx
docker ps
docker ps -a
docker stop <container>
docker start <container>
docker rm <container>
docker logs <container>
docker exec -it <container> bash
```

### Image Commands

```bash
docker images
docker pull nginx
docker build -t myapp:v1 .
docker tag myapp:v1 username/myapp:v1
docker push username/myapp:v1
docker rmi <image>
```

### Volume Commands

```bash
docker volume create data
docker volume ls
docker volume inspect data
docker volume rm data
```

### Network Commands

```bash
docker network create app-network
docker network ls
docker network inspect app-network
docker network connect app-network container
```

### Docker Compose

```bash
docker compose up -d
docker compose down
docker compose ps
docker compose logs
docker compose build
```

### Cleanup

```bash
docker system df
docker system prune
docker image prune
docker container prune
docker volume prune
```

---

## 🚀 Final Thoughts

Revision is just as important as learning new topics.

Understanding Docker isn't about memorizing commands—it's about knowing **why** and **when** to use them.

This revision has given me more confidence before starting Kubernetes.

**#90DaysOfDevOps**
