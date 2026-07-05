# Day 45 – Docker Build & Push in GitHub Actions

## Overview

Today I built a complete CI/CD pipeline that automatically builds a Docker image and pushes it to Docker Hub on every push to the `main` branch — no manual steps involved.

---

## Complete Workflow YAML

```yaml
name: Docker Build & Push

on:
  push:
    branches:
      - main

jobs:
  docker:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Get short SHA
        id: sha
        run: echo "short=$(echo ${{ github.sha }} | cut -c1-7)" >> $GITHUB_OUTPUT

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: ${{ github.ref == 'refs/heads/main' }}
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/my-app:latest
            ${{ secrets.DOCKER_USERNAME }}/my-app:sha-${{ steps.sha.outputs.short }}
```

---

## How It Works — Step by Step

| Step | What Happens |
|------|-------------|
| `actions/checkout@v4` | Pulls the repo code into the runner |
| `docker/login-action@v3` | Authenticates with Docker Hub using secrets |
| `cut -c1-7` on `github.sha` | Extracts the first 7 chars of the commit hash for the image tag |
| `docker/build-push-action@v5` | Builds the Docker image from the Dockerfile and pushes it |
| `push: ${{ github.ref == 'refs/heads/main' }}` | Ensures image is only pushed on `main`, not on PRs or feature branches |

---

## Tags Used

- `:latest` — always points to the most recent build from `main`
- `:sha-<7-char-hash>` — tied to the exact commit, making every image traceable

Example:
```
anjaniops/my-app:latest
anjaniops/my-app:sha-3f2a1b7
```

---

## Secrets Required

Set these in `Settings → Secrets and variables → Actions`:

| Secret Name | Value |
|-------------|-------|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_TOKEN` | Docker Hub access token (not your password) |

---

## Status Badge

Add this to your `README.md`:

```markdown
![Docker Build & Push](https://github.com/anjaniops/90DaysOfDevOps/actions/workflows/docker-publish.yml/badge.svg)
```

---

## Docker Hub Image

🐳 [hub.docker.com/r/anjaniops/my-app](https://hub.docker.com/r/anjaniops/my-app)

---

## Full Journey: git push → Running Container

```
git push origin main
       ↓
GitHub Actions triggered
       ↓
Runner checks out code
       ↓
Logs in to Docker Hub
       ↓
Builds Docker image from Dockerfile
       ↓
Tags image as :latest and :sha-<hash>
       ↓
Pushes both tags to Docker Hub
       ↓
Anyone can now pull and run it:

  docker pull anjaniops/my-app:latest
  docker run -p 80:80 anjaniops/my-app:latest
```

Every step is automated. Every image is traceable to a commit. Every deployment is repeatable.

---

## Key Learnings

- `push: ${{ github.ref == 'refs/heads/main' }}` is the cleanest way to build on all branches but only push from `main`
- Commit hash tagging is not optional in real teams — it's how you roll back to a known good state in production
- Docker Hub access tokens should always be used instead of your account password for CI secrets
- The `build-push-action` handles both building and pushing in one step, which keeps the workflow clean

---

## References

- [docker/login-action](https://github.com/docker/login-action)
- [docker/build-push-action](https://github.com/docker/build-push-action)
- [GitHub Actions Docs](https://docs.github.com/en/actions)