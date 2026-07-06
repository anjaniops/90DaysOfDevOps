# Day 46 – Reusable Workflows & Composite Actions

## Objective

Today's goal was to learn how to eliminate duplication in GitHub Actions by creating reusable workflows and custom composite actions. These features help teams standardize CI/CD pipelines and improve maintainability across multiple repositories.

---

# Task 1: Understanding `workflow_call`

## 1. What is a Reusable Workflow?

A reusable workflow is a GitHub Actions workflow that can be called by other workflows. It helps avoid duplicating the same CI/CD logic across multiple repositories or projects.

## 2. What is `workflow_call`?

`workflow_call` is a special trigger that allows a workflow to be invoked by another workflow instead of being triggered by events like `push` or `pull_request`.

## 3. Reusable Workflow vs Regular Action

| Reusable Workflow | Regular Action |
|-------------------|---------------|
| Contains one or more jobs | Contains one or more steps |
| Triggered using `workflow_call` | Used with `uses:` inside a step |
| Can define jobs, outputs, permissions, and secrets | Performs a specific reusable task |
| Best for sharing complete CI/CD pipelines | Best for sharing small reusable logic |

## 4. Where must a reusable workflow live?

Reusable workflows must be stored inside:

```
.github/workflows/
```

---

# Task 2: Creating My First Reusable Workflow

## File

```
.github/workflows/reusable-build.yml
```

## Features

- Triggered using `workflow_call`
- Accepts:
  - `app_name`
  - `environment`
- Uses secret:
  - `docker_token`
- Checks out source code
- Prints build information
- Confirms Docker token is available without exposing it

### Learning

Unlike normal workflows, reusable workflows cannot run directly. They require another workflow to call them.

---

# Task 3: Creating the Caller Workflow

## File

```
.github/workflows/call-build.yml
```

## Features

- Triggered on push to the `main` branch
- Calls the reusable workflow
- Passes input parameters
- Passes GitHub Secrets securely

Example:

```yaml
jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml
    with:
      app_name: my-web-app
      environment: production
    secrets:
      docker_token: ${{ secrets.DOCKER_TOKEN }}
```

### Result

Successfully triggered the reusable workflow and passed both inputs and secrets.

---

# Task 4: Using Outputs

## What I Did

- Generated a build version inside the reusable workflow.
- Exposed it as a workflow output.
- Accessed the output from the caller workflow using:

```yaml
needs.build.outputs.build_version
```

### Learning

Outputs allow workflows to pass information between jobs and workflows, making pipelines modular and reusable.

---

# Task 5: Creating a Composite Action

## Location

```
.github/actions/setup-and-greet/
```

## Files

```
action.yml
```

## Features

- Accepts:
  - name
  - language
- Prints a greeting
- Displays current date
- Displays runner operating system
- Returns an output:

```
greeted = true
```

### Learning

Composite actions bundle multiple steps into one reusable action, reducing repeated code.

---

# Task 6: Reusable Workflow vs Composite Action

| Feature | Reusable Workflow | Composite Action |
|---------|-------------------|------------------|
| Triggered by | `workflow_call` | `uses:` inside a workflow step |
| Can contain jobs | ✅ Yes | ❌ No |
| Can contain multiple steps | ✅ Yes | ✅ Yes |
| Lives in | `.github/workflows/` | Any directory containing `action.yml` |
| Can accept secrets directly | ✅ Yes | ❌ No (must receive via environment variables or inputs) |
| Best for | Entire CI/CD pipelines | Reusable step collections |

---

# Key Learnings

- Reusable workflows eliminate duplicated CI/CD pipelines.
- `workflow_call` allows workflows to behave like reusable functions.
- Inputs and secrets make reusable workflows flexible and secure.
- Outputs enable workflows to share information with callers.
- Composite actions simplify repeated workflow steps.
- Using reusable workflows and composite actions improves maintainability and scalability in GitHub Actions.

---

# Screenshots

- Reusable workflow execution
- Caller workflow
- Composite action execution
- Workflow outputs

---

# Conclusion

Day 46 introduced advanced GitHub Actions concepts that are widely used in production environments. Reusable workflows reduce duplication across repositories, while composite actions simplify repetitive tasks. Together, they help build cleaner, more modular, and maintainable CI/CD pipelines.