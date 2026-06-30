# Day 40 – My First GitHub Actions Workflow

## Objective
Today I created my first GitHub Actions workflow and executed it successfully on GitHub.

## Workflow Features
- Triggered on every push
- Checked out the repository
- Printed a greeting message
- Displayed current date and time
- Printed the branch name
- Listed repository files
- Displayed the runner operating system

## Workflow File

Location:
.github/workflows/hello.yml

## GitHub Actions Keywords

### on:
Defines the event that starts the workflow.

### jobs:
Contains one or more jobs to execute.

### runs-on:
Specifies which runner executes the job.

### steps:
A sequence of tasks performed inside the job.

### uses:
Uses a pre-built GitHub Action.

### run:
Executes shell commands on the runner.

### name:
Provides a readable name for the workflow or step.

## Learning Outcome

Today I understood how GitHub Actions automatically runs workflows after every push. I also learned the basic structure of a workflow and how runners execute commands in the cloud.

## Screenshot

(Add your successful green GitHub Actions run screenshot here.)
