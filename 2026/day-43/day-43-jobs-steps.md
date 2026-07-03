# Day 43 – Jobs, Steps, Environment Variables & Conditionals

## 🎯 Objective

Learn how to control the execution flow of GitHub Actions workflows using multiple jobs, environment variables, job outputs, and conditional execution.

---

## ✅ Tasks Completed

### Multi-Job Workflow

* Created a workflow with three jobs:

  * **Build**
  * **Test**
  * **Deploy**
* Used `needs` to execute jobs sequentially.
* Verified the dependency graph in the GitHub Actions tab.

### Environment Variables

* Defined environment variables at:

  * Workflow level
  * Job level
  * Step level
* Printed all variables successfully.
* Used GitHub context variables to display:

  * Commit SHA
  * GitHub Actor

### Job Outputs

* Generated an output value in one job.
* Passed the output to another job using `outputs` and `needs`.
* Verified that data can be shared between jobs.

### Conditional Execution

* Executed steps only on the `main` branch.
* Ran steps when previous steps failed.
* Restricted jobs to run only on `push` events.
* Tested `continue-on-error: true` and observed workflow behavior.

### Smart Pipeline

* Triggered workflow on every push.
* Executed **Lint** and **Test** jobs in parallel.
* Ran a **Summary** job after both completed.
* Printed:

  * Branch type (main or feature)
  * Commit message

---

## 💡 Key Learnings

* `needs` creates dependencies between jobs and controls execution order.
* `outputs` allow one job to pass data to another.
* Environment variables help avoid hardcoding values and improve workflow reusability.
* Conditional expressions (`if`) make workflows smarter by running jobs or steps only when required.
* Parallel jobs reduce overall pipeline execution time.

---

## 📁 Files

* `multi-job.yml`
* `env-vars.yml`
* `job-outputs.yml`
* `conditionals.yml`
* `smart-pipeline.yml`

---

## 🚀 Outcome

Successfully built advanced GitHub Actions workflows using job dependencies, environment variables, job outputs, conditional logic, and parallel execution. These concepts form the foundation of production-ready CI/CD pipelines.
