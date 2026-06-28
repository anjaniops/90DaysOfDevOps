Day 38 – YAML Basics

Objective

Today's goal was to understand the fundamentals of YAML, the configuration language widely used in DevOps tools like GitHub Actions, Kubernetes, Docker Compose, Ansible, and CI/CD pipelines.

---

Task 1 – Key-Value Pairs

person.yaml

name: Anjani Kumar
role: System Engineer
experience_years: 3
learning: true

tools:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS

hobbies: [Learning DevOps, Gym, Reading, Problem Solving]

Observation

- YAML stores data using key-value pairs.
- Booleans are written as "true" or "false".
- Indentation uses spaces only.

---

Task 2 – Lists

YAML supports lists in two ways.

Block Style

tools:
  - Linux
  - Docker
  - Git

Inline Style

tools: [Linux, Docker, Git]

Observation

Block style is easier to read for long lists.

Inline style is useful for short values.

---

Task 3 – Nested Objects

server.yaml

server:
  name: web-server
  ip: 192.168.1.100
  port: 80

database:
  host: localhost
  name: appdb
  credentials:
    user: admin
    password: password123

Observation

Nested objects are created using indentation.

Adding a Tab instead of spaces causes YAML validation to fail because YAML only accepts spaces.

---

Task 4 – Multi-line Strings

Literal Style ("|")

startup_script: |
  sudo apt update
  sudo apt install nginx
  sudo systemctl start nginx

Preserves line breaks exactly.

---

Folded Style (">")

startup_message: >
  Welcome to
  my production
  server.

Output becomes:

Welcome to my production server.

When to use

"|"

- Shell scripts
- Configuration files
- Certificates

">"

- Long descriptions
- Documentation
- Messages

---

Task 5 – YAML Validation

Validated both YAML files using yamllint.

After intentionally replacing spaces with a Tab, validation failed with an indentation error.

After replacing the Tab with two spaces, validation passed successfully.

---

Task 6 – Spot the Difference

Correct

name: devops
tools:
  - docker
  - kubernetes

Incorrect

name: devops
tools:
- docker
  - kubernetes

Problem

The list items are incorrectly indented.

YAML relies entirely on proper spacing to understand structure.

---

Three Key Learnings

1. YAML uses spaces only; tabs are not allowed.

2. Indentation defines hierarchy and structure.

3. YAML is human-readable and widely used in Docker Compose, Kubernetes, GitHub Actions, Ansible, and many CI/CD tools.

---

Conclusion

Today I learned that YAML is simple to read but very strict about formatting. Even a single indentation mistake or tab character can break an entire configuration file. Understanding YAML fundamentals is essential before working with Kubernetes manifests, GitHub Actions workflows, and CI/CD pipelines.

#90DaysOfDevOps
