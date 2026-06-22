# Day 32 - Docker Volumes & Networking

## Task 1: The Problem

```bash
docker run -d --name pg-test -e POSTGRES_PASSWORD=test postgres
docker exec -it pg-test psql -U postgres
```
```sql
CREATE TABLE users (id SERIAL, name VARCHAR(50));
INSERT INTO users (name) VALUES ('Anjani');
```
```bash
docker stop pg-test
docker rm pg-test
docker run -d --name pg-test2 -e POSTGRES_PASSWORD=test postgres
docker exec -it pg-test2 psql -U postgres -c "\dt"
```

**What happened:** Table is GONE. Fresh container = fresh filesystem, 
no memory of the previous one's data.

**Why:** Containers are ephemeral by design. Without a volume, all 
data lives inside the container's writable layer, which is destroyed 
the moment `docker rm` runs. The image only defines the starting 
state — it doesn't carry forward runtime changes.

## Task 2: Named Volumes

```bash
docker volume create pg-data
docker run -d --name pg-vol -e POSTGRES_PASSWORD=test -v pg-data:/var/lib/postgresql/data postgres

docker exec -it pg-vol psql -U postgres -c "CREATE TABLE users (id SERIAL, name VARCHAR(50));"
docker exec -it pg-vol psql -U postgres -c "INSERT INTO users (name) VALUES ('Anjani');"

docker stop pg-vol
docker rm pg-vol

docker run -d --name pg-vol2 -e POSTGRES_PASSWORD=test -v pg-data:/var/lib/postgresql/data postgres
docker exec -it pg-vol2 psql -U postgres -c "SELECT * FROM users;"
```

**Result:** Data is STILL THERE. 

```bash
docker volume ls
docker volume inspect pg-data
```

The volume lives independently of any container — Docker manages 
it outside the container lifecycle, on the host filesystem, but in 
a location Docker controls.

## Task 3: Bind Mounts

```bash
mkdir my-site
echo "<h1>Hello from bind mount!</h1>" > my-site/index.html

docker run -d --name web-bind -p 8080:80 -v $(pwd)/my-site:/usr/share/nginx/html nginx
```

Visited localhost:8080 → saw the page. Edited `index.html` on host, 
refreshed browser → change appeared INSTANTLY, no rebuild needed.

**Named Volume vs Bind Mount:**

| | Named Volume | Bind Mount |
|---|---|---|
| Location | Docker-managed area on host | Any path I choose on host |
| Visibility | Abstracted — I don't directly browse it | Direct — I can edit files myself |
| Use case | Databases, persistent app data | Local dev, live code editing |
| Portability | Works across environments | Tied to host's exact file structure |

A named volume is for "Docker, please remember this data for me." 
A bind mount is for "let me directly control these files from my host."

## Task 4: Docker Networking Basics

```bash
docker network ls
docker network inspect bridge
```

```bash
docker run -d --name c1 alpine sleep 1000
docker run -d --name c2 alpine sleep 1000

docker exec c1 ping -c 2 c2          # FAILS - name resolution doesn't work
docker exec c1 ping -c 2 <c2_IP>     # WORKS - direct IP ping succeeds
```

On the default bridge, containers get IPs but NOT automatic DNS 
resolution by container name.

## Task 5: Custom Networks

```bash
docker network create my-app-net

docker run -d --name c3 --network my-app-net alpine sleep 1000
docker run -d --name c4 --network my-app-net alpine sleep 1000

docker exec c3 ping -c 2 c4          # WORKS now, by name!
```

**Why custom networks support name-based communication but the 
default bridge doesn't:**

The default bridge network is a legacy network type — it only 
provides IP connectivity, no embedded DNS server. Custom (user-
defined) bridge networks come with Docker's built-in DNS resolver, 
which automatically registers each container's name as a resolvable 
hostname within that network. This is why best practice is: always 
create a custom network for multi-container apps.

## Task 6: Put It Together

```bash
docker network create app-net
docker volume create db-data

docker run -d --name mydb --network app-net \
  -e POSTGRES_PASSWORD=test -v db-data:/var/lib/postgresql/data postgres

docker run -d --name myapp --network app-net alpine sleep 1000

docker exec myapp ping -c 2 mydb     # Successfully reaches DB by name
```

This is the exact pattern real applications use: app container 
talks to db container by name, db container persists data via 
volume — both isolated on their own network.