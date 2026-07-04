# Day 44 – Secrets, Artifacts & Running Real Tests in CI

## Objective

Today's goal was to learn how to securely manage sensitive information, share files between workflow jobs, optimize workflow execution, and run real tests using GitHub Actions.

---

# Task 1: GitHub Secrets

## What I Did

- Created a GitHub secret named `MY_SECRET_MESSAGE`.
- Accessed the secret securely inside a workflow.
- Verified that GitHub automatically masks secret values in workflow logs.
- Printed only whether the secret existed instead of exposing its value.

### Example

```yaml
env:
  SECRET: ${{ secrets.MY_SECRET_MESSAGE }}

steps:
  - name: Check Secret
    run: |
      if [ -n "$SECRET" ]; then
        echo "The secret is set: true"
      else
        echo "Secret not found"
      fi
```

### What I Learned

- Secrets should never be hardcoded inside workflows.
- GitHub automatically masks secrets in logs.
- Secrets are useful for passwords, API keys, Docker tokens, and cloud credentials.

---

# Task 2: Using Secrets as Environment Variables

## What I Did

- Passed GitHub Secrets as environment variables.
- Used them inside shell commands securely.

Example:

```yaml
env:
  DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
  DOCKER_TOKEN: ${{ secrets.DOCKER_TOKEN }}
```

### Learning

Sensitive values remain encrypted and are never exposed in workflow files.

---

# Task 3: Upload Artifacts

## What I Did

Generated a sample report and uploaded it as an artifact.

Example:

```yaml
- name: Generate Report
  run: echo "CI Test Successful" > report.txt

- name: Upload Artifact
  uses: actions/upload-artifact@v4
  with:
    name: test-report
    path: report.txt
```

### Result

Successfully downloaded the artifact from the GitHub Actions page after workflow completion.

---

# Task 4: Download Artifacts Between Jobs

## Job 1

Generated and uploaded the artifact.

## Job 2

Downloaded the artifact.

Example:

```yaml
- uses: actions/download-artifact@v4
  with:
    name: test-report

- run: cat report.txt
```

### What I Learned

Artifacts allow jobs to share files such as:

- Test reports
- Build outputs
- Coverage reports
- Log files
- Release packages

---

# Task 5: Running Real Tests

## Workflow Steps

- Checked out repository
- Installed dependencies
- Executed a shell/Python script
- Verified successful execution
- Intentionally introduced an error
- Observed pipeline failure
- Fixed the issue
- Confirmed successful pipeline execution

### Learning

A failed pipeline helps detect issues before deployment, making CI/CD more reliable.

---

# Task 6: Dependency Caching

## What I Did

Used GitHub Actions Cache.

Example:

```yaml
uses: actions/cache@v4
```

### Result

- First run downloaded dependencies.
- Second run restored them from cache.
- Workflow completed much faster.

### What is Cached?

- Python packages
- npm dependencies
- Maven packages
- Gradle cache
- Other dependency directories

GitHub stores cache securely and restores it automatically when the cache key matches.

---

# Key Learnings

- GitHub Secrets securely store sensitive information.
- Secrets are automatically masked in workflow logs.
- Artifacts help transfer files between jobs.
- Running real tests ensures code quality.
- Caching significantly improves workflow performance.
- CI/CD pipelines become more secure, faster, and more reliable with these features.

---

# Screenshots

- GitHub Secrets Configuration
- Passing Workflow
- Uploaded Artifact
- Downloaded Artifact
- Successful Test Run

---

# Conclusion

Day 44 introduced practical GitHub Actions features that are commonly used in production CI/CD pipelines. Learning how to manage secrets, share artifacts between jobs, run automated tests, and optimize workflow performance with caching makes pipelines more secure, efficient, and production-ready.