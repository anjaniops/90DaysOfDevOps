# Day 41 – Triggers & Matrix Builds

## 🚀 Objective

Learn different ways to trigger GitHub Actions workflows and execute jobs across multiple environments using Matrix Builds.

## 📚 Topics Covered

* Pull Request (`pull_request`) trigger
* Scheduled workflows using `cron`
* Manual workflow execution with `workflow_dispatch`
* Workflow inputs
* Matrix strategy
* Running jobs on multiple Python versions
* Running jobs on multiple operating systems
* Excluding matrix combinations
* `fail-fast` behavior

## ✅ Hands-on Tasks

* Created a workflow that runs automatically on Pull Requests.
* Configured a scheduled workflow to run daily using Cron syntax.
* Built a manual workflow with environment selection (Dev, Staging, Production).
* Implemented Matrix Builds for Python 3.10, 3.11, and 3.12.
* Extended Matrix Builds to multiple operating systems.
* Used `exclude` to skip specific matrix combinations.
* Tested `fail-fast: false` to observe parallel job execution during failures.

## 💡 Key Learnings

* GitHub Actions supports multiple workflow triggers for different automation scenarios.
* Matrix Builds allow the same workflow to be tested across multiple environments simultaneously.
* `workflow_dispatch` is useful for manual deployments and operational tasks.
* `fail-fast: false` ensures all matrix jobs continue running even if one fails.
* Matrix strategies improve testing reliability across different platforms and versions.

## 📂 Files

* `pr-check.yml`
* `manual.yml`
* `matrix.yml`
* `day-41-triggers.md`

## 🎯 Outcome

Successfully learned how to trigger workflows using Pull Requests, schedules, and manual execution, while leveraging Matrix Builds to test applications across multiple Python versions and operating systems using GitHub Actions.
