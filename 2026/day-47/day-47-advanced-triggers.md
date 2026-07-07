# Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines

## Objective

Today I explored advanced GitHub Actions triggers to understand how workflows can respond to different events throughout the software development lifecycle. I learned how to automate PR validation, schedule recurring tasks, trigger workflows from other workflows, and even start workflows from external systems.

---

# Task 1: Pull Request Lifecycle Events

## Workflow File

```
.github/workflows/pr-lifecycle.yml
```

### Trigger Events

- opened
- synchronize
- reopened
- closed

### Workflow Features

- Printed the PR event type.
- Displayed the PR title.
- Displayed the PR author.
- Printed source and target branches.
- Executed an additional step only when the pull request was merged.

### Merge Condition

```yaml
if: github.event.pull_request.merged == true
```

### Learning

A single workflow can react differently depending on where a pull request is in its lifecycle.

---

# Task 2: PR Validation Workflow

## Workflow File

```
.github/workflows/pr-checks.yml
```

### Jobs

### File Size Check

- Checked repository files.
- Failed if any file exceeded 1 MB.

### Branch Name Check

Allowed branch patterns:

```
feature/*
fix/*
docs/*
```

Rejected any branch not following the naming convention.

### PR Body Check

Verified whether the pull request description was empty.

Displayed a warning instead of failing the workflow.

### Learning

Automated PR validation improves code quality before merging into the main branch.

---

# Task 3: Scheduled Workflows (Cron)

## Workflow File

```
.github/workflows/scheduled-tasks.yml
```

### Schedule

Every Monday at 2:30 AM UTC

```yaml
30 2 * * 1
```

Every 6 hours

```yaml
0 */6 * * *
```

Also added:

```yaml
workflow_dispatch:
```

to allow manual execution.

### Health Check

Used curl to verify an application endpoint.

Example:

```bash
curl -I https://example.com
```

---

## Cron Expressions

### Every weekday at 9:00 AM IST

GitHub Actions uses UTC.

9:00 AM IST = 3:30 AM UTC

```text
30 3 * * 1-5
```

### First day of every month at midnight UTC

```text
0 0 1 * *
```

### Why scheduled workflows may be delayed

GitHub may delay or skip scheduled workflows on inactive repositories or during periods of heavy platform usage.

---

# Task 4: Path and Branch Filters

## Workflow File

```
.github/workflows/smart-triggers.yml
```

### Paths

Triggered only when files changed inside

```
src/**
app/**
```

### Paths Ignore

Ignored changes to

```
*.md
docs/**
```

### Branch Filters

Allowed branches

```
main
release/*
```

### Learning

- `paths` runs workflows only when specific files change.
- `paths-ignore` skips workflows for unimportant file changes like documentation.

---

# Task 5: Workflow Chaining

## Workflow Files

```
.github/workflows/tests.yml
```

```
.github/workflows/deploy-after-tests.yml
```

### Workflow Flow

Push

↓

Run Tests

↓

Workflow Completed

↓

Deploy Workflow

### Success Condition

```yaml
if: github.event.workflow_run.conclusion == 'success'
```

### Learning

`workflow_run` allows workflows to execute sequentially without placing everything inside a single YAML file.

---

# Task 6: repository_dispatch

## Workflow File

```
.github/workflows/external-trigger.yml
```

### Event

```
repository_dispatch
```

### Event Type

```
deploy-request
```

### Payload Example

```json
{
  "environment": "production"
}
```

Triggered using:

```bash
gh api repos/<owner>/<repo>/dispatches \
-f event_type=deploy-request \
-f client_payload='{"environment":"production"}'
```

### Learning

External applications such as monitoring tools, Slack bots, deployment portals, or internal automation platforms can trigger GitHub Actions workflows using `repository_dispatch`.

---

# workflow_run vs workflow_call

| workflow_run | workflow_call |
|---------------|--------------|
| Starts after another workflow completes | Called directly by another workflow |
| Event-driven | Function-like reusable workflow |
| Good for chaining pipelines | Good for sharing reusable CI/CD logic |
| Uses workflow completion status | Uses inputs, outputs, and secrets |

---

# Key Learnings

- Pull Request events support multiple lifecycle triggers.
- Scheduled workflows automate recurring maintenance tasks.
- Path filters reduce unnecessary workflow executions.
- `workflow_run` enables event-driven pipeline chaining.
- `repository_dispatch` allows external systems to trigger GitHub Actions.
- Advanced triggers make CI/CD pipelines smarter, faster, and more efficient.

---

# Screenshots

- PR lifecycle workflow
- PR validation workflow
- Scheduled workflow
- workflow_run execution
- repository_dispatch execution

---

# Conclusion

Day 47 expanded my understanding of GitHub Actions beyond basic push events. By learning advanced triggers like pull request lifecycle events, scheduled workflows, workflow chaining, path filters, and external event triggers, I now have a much better understanding of how production-grade CI/CD pipelines respond intelligently to different events.