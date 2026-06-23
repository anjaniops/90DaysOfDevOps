# Day 33 – Docker Compose: Multi-Container Basics

## Task 1: Install & Verify Docker Compose

### Check Compose Availability

```bash
docker compose version
```

### Output

```bash
Docker Compose version v2.x.x
```

Docker Compose is integrated into modern Docker installations and allows multiple containers to be managed using a single YAML file.

---

# Task 2: First Docker Compose File

## docker-compose.yml

```yaml
services:
  nginx:
    image: nginx
    container_name: nginx-compose
    ports:
      - "8080:80"
```

## Start Services

```bash
docker compose up -d
```

## Verify

```bash
docker compose ps
```

Access:

```text
http://localhost:8080
```

## Stop Services

```bash
docker compose down
```

---

# Task 3: WordPress + MySQL Multi-Container Setup

## docker-compose.yml

```yaml
services:

  db:
    image: mysql:8.0
    container_name: mysql-db
    restart: always

    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wp123

    volumes:
      - mysql-data:/var/lib/mysql

  wordpress:
    image: wordpress
    container_name: wordpress-app
    restart: always

    depends_on:
      - db

    ports:
      - "8081:80"

    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wp123
      WORDPRESS_DB_NAME: wordpress

volumes:
  mysql-data:
```

## Start Stack

```bash
docker compose up -d
```

## Verify

```bash
docker compose ps
```

Open browser:

```text
http://localhost:8081
```

WordPress successfully connects to MySQL using the service name **db**.

### Persistence Test

```bash
docker compose down
docker compose up -d
```

Result:

WordPress database data remains available because the MySQL data is stored inside the named volume:

```text
mysql-data
```

---

# Task 4: Docker Compose Commands

## Start in Detached Mode

```bash
docker compose up -d
```

## View Running Services

```bash
docker compose ps
```

## View Logs of All Services

```bash
docker compose logs
```

## Follow Logs

```bash
docker compose logs -f
```

## Logs of Specific Service

```bash
docker compose logs db
```

```bash
docker compose logs wordpress
```

## Stop Services

```bash
docker compose stop
```

## Start Stopped Services

```bash
docker compose start
```

## Remove Containers & Networks

```bash
docker compose down
```

## Remove Containers, Networks & Volumes

```bash
docker compose down -v
```

## Rebuild Images

```bash
docker compose up --build
```

---

# Task 5: Environment Variables

## Using Variables Directly

```yaml
environment:
  MYSQL_ROOT_PASSWORD: root123
```

---

## Using .env File

### .env

```env
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wp123
```

### docker-compose.yml

```yaml
services:

  db:
    image: mysql:8.0

    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
```

## Verify Variables

```bash
docker compose config
```

This command shows the final configuration after variable substitution.

---

# What I Learned

1. Docker Compose manages multiple containers using a single YAML file.
2. Compose automatically creates a network for all services.
3. Service names act as DNS hostnames between containers.
4. Named volumes provide persistent storage.
5. Environment variables can be managed using a `.env` file.
6. `docker compose up -d` can deploy an entire application stack with one command.
7. Compose simplifies multi-container applications like WordPress + MySQL.

---

# Architecture

```text
+---------------------+
|     WordPress       |
|   (Port 8081)       |
+----------+----------+
           |
           |
           v
+---------------------+
|       MySQL         |
|   Database Server   |
+----------+----------+
           |
           |
           v
+---------------------+
|    mysql-data       |
|   Named Volume      |
+---------------------+
```

Docker Compose automatically creates:

* Network
* Containers
* Volume
* Service Discovery (DNS)

with a single command:

```bash
docker compose up -d
```
