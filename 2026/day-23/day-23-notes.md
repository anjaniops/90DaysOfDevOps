# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### 1. What is a branch in Git?

A branch is an independent line of development that allows changes to be made without affecting the main codebase.

### 2. Why do we use branches instead of committing everything to main?

Branches help developers work on features, bug fixes, and experiments separately. This reduces risk and keeps the main branch stable.

### 3. What is HEAD in Git?

HEAD is a pointer that references the current branch and latest commit you are working on.

### 4. What happens to your files when you switch branches?

Git updates the working directory to match the selected branch. Files may appear, disappear, or change based on that branch's commits.

---

## Task 2: Branching Commands Practiced

### List Branches

```bash
git branch
```

### Create a New Branch

```bash
git branch feature-1
```

### Switch to Branch

```bash
git checkout feature-1
```

### Create and Switch in One Command

```bash
git checkout -b feature-2
```

### Using git switch

```bash
git switch feature-1
```

### Difference Between git switch and git checkout

* `git switch` is dedicated to branch switching.
* `git checkout` can switch branches and restore files.
* `git switch` is easier and less error-prone.

---

## Task 3: Push to GitHub

### Add Remote Repository

```bash
git remote add origin https://github.com/username/devops-git-practice.git
```

### Verify Remote

```bash
git remote -v
```

### Push Main Branch

```bash
git push -u origin master
```

### Push Feature Branch

```bash
git push -u origin feature-1
```

### Origin vs Upstream

**Origin**

* Default remote repository that points to your fork or repository.

**Upstream**

* Original repository from which a fork was created.
* Used to keep a fork updated with the original project.

---

## Task 4: Pull from GitHub

### Pull Latest Changes

```bash
git pull origin master
```

### Difference Between git fetch and git pull

**git fetch**

* Downloads new changes from remote.
* Does not merge changes automatically.

**git pull**

* Downloads and immediately merges changes into the current branch.

---

## Task 5: Clone vs Fork

### Clone

Creates a local copy of an existing repository.

```bash
git clone https://github.com/user/repository.git
```

### Fork

Creates a personal copy of someone else's repository on GitHub.

### Difference

| Clone                      | Fork                              |
| -------------------------- | --------------------------------- |
| Local copy                 | GitHub copy                       |
| Git feature                | GitHub feature                    |
| Used for local development | Used for contributing to projects |

### When to Use Clone?

* Working on your own repositories.
* Downloading code locally.

### When to Use Fork?

* Contributing to open-source projects.
* Working independently without affecting the original repository.

### Keeping a Fork Updated

```bash
git remote add upstream https://github.com/original/repository.git

git fetch upstream

git merge upstream/master
```

---

# What I Learned

1. Branches allow isolated development without affecting the main codebase.
2. GitHub remotes help synchronize local and remote repositories.
3. Understanding fetch, pull, clone, and fork is essential for collaboration.
