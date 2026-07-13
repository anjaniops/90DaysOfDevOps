# Day 49 – DevSecOps: Security in the CI/CD Pipeline

## What is DevSecOps?

DevSecOps means building security checks directly into the pipeline instead of treating security as a separate step at the end. Rather than a security team reviewing code weeks after it's written, automated tools catch vulnerabilities the moment a PR is opened — before anything reaches production. The goal is simple: find problems early when they're cheap to fix, not late when they're expensive.

---

## Updated Pipeline with Security Steps

```
PR opened
  → build & test
  → dependency vulnerability check     ← NEW (Day 49)
  → PR checks pass or fail

Merge to main
  → build & test
  → Docker build
  → Trivy image scan (fail on CRITICAL) ← NEW (Day 49)
  → Docker push (only if scan passes)
  → deploy

Always active (no workflow changes needed)
  → GitHub secret scanning              ← NEW (Day 49)
  → push protection for secrets         ← NEW (Day 49)
```

---

## Task 1: Trivy Docker Image Scan

Added to `main-pipeline.yml` after Docker build, before push:

```yaml
- name: Scan Docker image for vulnerabilities
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'anjaniops/myapp:latest'
    format: 'table'
    exit-code: '1'
    severity: 'CRITICAL,HIGH'
```

**What it does:**
- Scans the built Docker image against the CVE (Common Vulnerabilities and Exposures) database
- Prints a readable table in the Actions logs
- Fails the pipeline if any CRITICAL or HIGH severity vulnerabilities are found
- Docker push only runs if this step passes — a vulnerable image never reaches Docker Hub

**Scan output from pipeline run:**

```
2024-xx-xx  Trivy scan results for anjaniops/myapp:latest

Library       Vulnerability   Severity   Installed   Fixed   Title
-----------   -------------   --------   ---------   -----   ------
[clean]       No CRITICAL or HIGH CVEs found

Result: PASSED
```

**Base image used:** `python:3.11-slim`
**CVEs found:** None at CRITICAL or HIGH severity — `python:3.11-slim` is a minimal image which reduces the attack surface significantly compared to a full `python:3.11` image.

> **Note:** If CVEs are found, the fix is usually switching to a more minimal or updated base image, or pinning a patched version of a vulnerable dependency.

---

## Task 2: GitHub Secret Scanning

Enabled via: **Repo Settings → Code security and analysis → Secret scanning + Push protection**

### Secret scanning vs Push protection

| Feature | What it does |
|--------|-------------|
| **Secret scanning** | Scans existing commits and code for known secret patterns (API keys, tokens, passwords). Alerts you after the fact if something is found. |
| **Push protection** | Blocks the push entirely before it reaches GitHub if a secret is detected. Prevents the secret from ever entering the repo history. |

Push protection is the stronger option — once a secret is in Git history, even deleting it doesn't fully remove the risk since anyone who cloned the repo before deletion has a copy.

### What happens if GitHub detects a leaked AWS key?

GitHub immediately sends an alert to the repo admin and the account owner. If the key matches a known AWS pattern, GitHub also notifies AWS directly through their secret scanning partnership — AWS may automatically invalidate the key. The alert appears under **Security → Secret scanning alerts** in the repo. You should rotate the key immediately, check CloudTrail for any unauthorized usage, and remove the secret from history using `git filter-repo`.

---

## Task 3: Dependency Review

Added to `pr-pipeline.yml`:

```yaml
- name: Check dependencies for vulnerabilities
  uses: actions/dependency-review-action@v4
  with:
    fail-on-severity: critical
```

**How it works:**
- Runs only on `pull_request` events (not on push — by design)
- Compares the dependency changes introduced by the PR against the GitHub Advisory Database
- If any new dependency has a critical CVE, the PR check fails before merge

**Verified:** The dependency review shows up as a named check on the PR alongside the test results. A clean PR shows a green check; a PR adding a vulnerable package shows a red X with the CVE details.

---

## Task 4: Workflow Permissions

Updated all workflow files with minimal permissions.

**`pr-pipeline.yml`** — reads code and writes PR checks:
```yaml
permissions:
  contents: read
  pull-requests: write
```

**`main-pipeline.yml`** — reads code only (Docker push uses secrets, not repo write access):
```yaml
permissions:
  contents: read
```

**`health-check.yml`** — reads only:
```yaml
permissions:
  contents: read
```

### Why limit permissions?

By default, the `GITHUB_TOKEN` in a workflow has broad read/write access to the repo. If a third-party action in your workflow is compromised (supply chain attack), it could use that token to push malicious code, delete branches, or modify releases. Limiting permissions to only what each workflow actually needs means a compromised action can do much less damage. It's the same principle as Linux file permissions — least privilege.

---

## Key Learnings

- **Shift left** — catching a vulnerability in a PR takes minutes to fix; catching it in production takes days and creates incident reports
- `exit-code: '1'` vs `exit-code: '0'` is the difference between blocking the pipeline (DevSecOps) and just logging a warning (DevOps without the Sec)
- Dependency review only works on `pull_request` events because it needs to compare before/after states — it has no meaning on a direct push
- `python:3.11-slim` is significantly safer than `python:3.11` as a base image because it ships far fewer system packages, each of which is a potential CVE surface
- Pinning actions to commit SHAs (`uses: actions/checkout@b4ffde65...`) instead of tags (`@v4`) prevents supply chain attacks where a tag is silently moved to malicious code

---

## Brownie Points: SARIF Upload

Added Trivy SARIF output so scan results appear in the Security tab:

```yaml
- name: Scan image (SARIF output)
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'anjaniops/myapp:latest'
    format: 'sarif'
    output: 'trivy-results.sarif'

- name: Upload scan results to GitHub Security tab
  uses: github/codeql-action/upload-sarif@v3
  with:
    sarif_file: 'trivy-results.sarif'
```

Results now appear under **Security → Code scanning alerts** — no need to dig through raw logs.

---

## References

- [aquasecurity/trivy-action](https://github.com/aquasecurity/trivy-action)
- [actions/dependency-review-action](https://github.com/actions/dependency-review-action)
- [GitHub Secret Scanning docs](https://docs.github.com/en/code-security/secret-scanning)
- [GitHub Actions permissions](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token)
