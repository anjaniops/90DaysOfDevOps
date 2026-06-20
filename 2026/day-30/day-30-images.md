# Day 30 - Docker Images & Container Lifecycle

## Task 1: Docker Images

```bash
docker pull nginx
docker pull ubuntu
docker pull alpine

docker images
```

**Ubuntu vs Alpine — why the size difference?**

Ubuntu (~78MB) includes a full base OS with many built-in 
utilities and libraries. Alpine (~5MB) uses musl libc instead 
of glibc and BusyBox instead of full GNU utilities — stripped 
down to bare essentials. Alpine is built specifically to be 
minimal for containers, not as a general-purpose OS.

```bash
docker inspect nginx
docker rmi alpine
```

`docker inspect` shows: image ID, architecture, OS, layers, 
exposed ports, environment variables, entrypoint, and config — 
everything Docker needs to know to run it.

## Task 2: Image Layers

```bash
docker image history nginx
```

**What I saw:** Each line is a layer — one per Dockerfile 
instruction (FROM, RUN, COPY, etc.). Some show real size (a 
RUN that installed packages), others show 0B (metadata-only 
instructions like ENV, EXPOSE, CMD).

**Why layers exist:**
Layers are cached and reusable. If two images share the same 
base layer (like `FROM ubuntu`), Docker only stores it once 
and reuses it. This is why pulling a second image that shares 
a base is much faster — and why rebuilding an image after a 
small code change doesn't re-download everything, just the 
changed layer onward.

## Task 3: Container Lifecycle

```bash
docker create --name lifecycle-test nginx   # Created, not running
docker ps -a                                 # Status: Created

docker start lifecycle-test                  # Status: Up
docker ps -a

docker pause lifecycle-test                  # Status: Up (Paused)
docker ps -a

docker unpause lifecycle-test                # Status: Up
docker ps -a

docker stop lifecycle-test                   # Status: Exited (0)
docker ps -a

docker restart lifecycle-test                # Status: Up (new PID)
docker ps -a

docker kill lifecycle-test                   # Status: Exited (137)
docker ps -a

docker rm lifecycle-test                     # Container gone
docker ps -a
```

**Key observation:** `stop` sends SIGTERM (graceful shutdown, 
exit code 0), while `kill` sends SIGKILL (immediate, exit code 
137). Pause freezes all processes inside the container without 
stopping it — useful for debugging without losing state.

## Task 4: Working with Running Containers

```bash
docker run -d --name web-test nginx

docker logs web-test           # One-time log dump
docker logs -f web-test        # Live streaming logs (Ctrl+C to exit)

docker exec -it web-test bash  # Full shell inside container

docker exec web-test ls /etc/nginx   # Single command, no shell entry

docker inspect web-test
```

From `inspect`, found: container IP address (under NetworkSettings), 
port mappings, and mount points — all the runtime details that 
matter when debugging networking issues.

## Task 5: Cleanup

```bash
docker stop $(docker ps -q)      # Stop all running containers
docker container prune           # Remove all stopped containers
docker image prune -a            # Remove unused images
docker system df                 # Check disk usage
```

`docker system df` breaks down space used by images, containers, 
and local volumes — useful for spotting bloat before it becomes 
a problem.