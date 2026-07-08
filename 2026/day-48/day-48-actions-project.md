# Day 48 – GitHub Actions Project: End-to-End CI/CD Pipeline

## Overview

This is the GitHub Actions capstone — a complete, production-style CI/CD pipeline that builds, tests, and deploys a Dockerized application using reusable workflows, environment protection, and scheduled health checks.

**Repo:** [github-actions-capstone](https://github.com/anjaniops/github-actions-capstone)
**Docker Hub:** [hub.docker.com/r/anjaniops/myapp](https://hub.docker.com/r/anjaniops/myapp)

---

## Pipeline Architecture

```
PR opened
    └── pr-pipeline.yml
          └── reusable-build-test.yml  (tests only, no Docker push)
                └── PR comment: "PR checks passed"

Merge to main
    └── main-pipeline.yml
          ├── Job 1: reusable-build-test.yml  (build + test)
          ├── Job 2: reusable-docker.yml       (Docker build & push → :latest + :sha-xxxxxxx)
          └── Job 3: deploy                    (manual approval → "Deploying to production")

Every 12 hours
    └── health-check.yml
          └── Pull image → Run container → curl /health → Report PASSED/FAILED
```

---

## Workflow Files

### 1. Reusable Build & Test — `reusable-build-test.yml`

```yaml
name: Reusable — Build & Test

on:
  workflow_call:
    inputs:
      python_version:
        type: string
        default: '3.11'
      run_tests:
        type: boolean
        default: true
    outputs:
      test_result:
        description: "passed or failed"
        value: ${{ jobs.build-test.outputs.test_result }}

jobs:
  build-test:
    runs-on: ubuntu-latest
    outputs:
      test_result: ${{ steps.result.outputs.test_result }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: ${{ inputs.python_version }}

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Run tests
        if: inputs.run_tests
        run: pytest tests/

      - name: Set test result
        id: result
        run: echo "test_result=passed" >> $GITHUB_OUTPUT
```

---

### 2. Reusable Docker Build & Push — `reusable-docker.yml`

```yaml
name: Reusable — Docker Build & Push

on:
  workflow_call:
    inputs:
      image_name:
        type: string
        required: true
      tag:
        type: string
        required: true
    secrets:
      docker_username:
        required: true
      docker_token:
        required: true
    outputs:
      image_url:
        description: "Full Docker image path"
        value: ${{ jobs.docker.outputs.image_url }}

jobs:
  docker:
    runs-on: ubuntu-latest
    outputs:
      image_url: ${{ steps.set-url.outputs.image_url }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.docker_username }}
          password: ${{ secrets.docker_token }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            ${{ secrets.docker_username }}/${{ inputs.image_name }}:${{ inputs.tag }}
            ${{ secrets.docker_username }}/${{ inputs.image_name }}:latest

      - name: Set image URL
        id: set-url
        run: echo "image_url=${{ secrets.docker_username }}/${{ inputs.image_name }}:${{ inputs.tag }}" >> $GITHUB_OUTPUT
```

---

### 3. PR Pipeline — `pr-pipeline.yml`

```yaml
name: PR Pipeline

on:
  pull_request:
    branches: [main]
    types: [opened, synchronize]

jobs:
  build-test:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: '3.11'
      run_tests: true

  pr-comment:
    runs-on: ubuntu-latest
    needs: build-test
    steps:
      - name: PR summary
        run: |
          echo "PR checks passed for branch: ${{ github.head_ref }}"
          echo "Test result: ${{ needs.build-test.outputs.test_result }}"
```

---

### 4. Main Branch Pipeline — `main-pipeline.yml`

```yaml
name: Main Pipeline

on:
  push:
    branches: [main]

jobs:
  build-test:
    uses: ./.github/workflows/reusable-build-test.yml
    with:
      python_version: '3.11'
      run_tests: true

  docker-build-push:
    needs: build-test
    uses: ./.github/workflows/reusable-docker.yml
    with:
      image_name: myapp
      tag: sha-${{ github.sha && github.sha[:7] || 'latest' }}
    secrets:
      docker_username: ${{ secrets.DOCKER_USERNAME }}
      docker_token: ${{ secrets.DOCKER_TOKEN }}

  deploy:
    runs-on: ubuntu-latest
    needs: docker-build-push
    environment: production
    steps:
      - name: Deploy to production
        run: |
          echo "Deploying image: ${{ needs.docker-build-push.outputs.image_url }} to production"
```

---

### 5. Scheduled Health Check — `health-check.yml`

```yaml
name: Health Check

on:
  schedule:
    - cron: '0 */12 * * *'
  workflow_dispatch:

jobs:
  health-check:
    runs-on: ubuntu-latest

    steps:
      - name: Pull latest image
        run: docker pull ${{ secrets.DOCKER_USERNAME }}/myapp:latest

      - name: Run container
        run: docker run -d --name myapp -p 8080:8080 ${{ secrets.DOCKER_USERNAME }}/myapp:latest

      - name: Wait for startup
        run: sleep 5

      - name: Check health endpoint
        id: health
        run: |
          STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)
          if [ "$STATUS" == "200" ]; then
            echo "result=PASSED" >> $GITHUB_OUTPUT
          else
            echo "result=FAILED" >> $GITHUB_OUTPUT
          fi

      - name: Cleanup
        run: docker stop myapp && docker rm myapp

      - name: Write step summary
        run: |
          echo "## Health Check Report" >> $GITHUB_STEP_SUMMARY
          echo "- Image: myapp:latest" >> $GITHUB_STEP_SUMMARY
          echo "- Status: ${{ steps.health.outputs.result }}" >> $GITHUB_STEP_SUMMARY
          echo "- Time: $(date)" >> $GITHUB_STEP_SUMMARY
```

---

## Secrets Required

| Secret | Used In |
|--------|---------|
| `DOCKER_USERNAME` | Docker login |
| `DOCKER_TOKEN` | Docker login |

Set via: **Repo Settings → Secrets and variables → Actions**

---

## Environment Protection

`production` environment set up under **Repo Settings → Environments**:
- Required reviewers: enabled (manual approval before deploy runs)
- This means the deploy job pauses and waits for a human to approve every time

---

## README Badges

```markdown
![PR Pipeline](https://github.com/anjaniops/github-actions-capstone/actions/workflows/pr-pipeline.yml/badge.svg)
![Main Pipeline](https://github.com/anjaniops/github-actions-capstone/actions/workflows/main-pipeline.yml/badge.svg)
![Health Check](https://github.com/anjaniops/github-actions-capstone/actions/workflows/health-check.yml/badge.svg)
```

---

## Key Learnings

- Reusable workflows (`workflow_call`) let you write logic once and call it from multiple pipelines — the same build-test logic runs identically on PRs and on main
- Outputs from one job (`needs.<job>.outputs.<name>`) are how you pass data between jobs — the image URL produced in the Docker job is consumed directly in the deploy job
- `environment: production` with required reviewers is a one-line way to add a human gate before any deployment
- `$GITHUB_STEP_SUMMARY` renders markdown in the Actions run summary — clean alternative to Slack notifications for simple health reports
- The PR pipeline deliberately skips the Docker push — builds are cheap, pushes are not, and you don't want every draft PR creating Docker Hub images

---

## What I'd Add Next

- **Slack notifications** — post to a `#deployments` channel when a production deploy completes or fails
- **Multi-environment** — separate `staging` and `production` environments, with staging deploying automatically and production requiring approval
- **Rollback workflow** — a `workflow_dispatch` that accepts an image tag and re-deploys a previous version
- **Trivy security scan** — scan the Docker image for CVEs before the push step, fail on CRITICAL severity (Day 49 preview)
- **Test coverage report** — upload coverage as an artifact and post the summary to the PR as a comment