# Day 22 – Git Basics Notes

## 1. What is the difference between git add and git commit?

* `git add` moves changes from the working directory to the staging area.
* `git commit` saves the staged changes to the Git repository with a message.

Example:

```bash
git add file.txt
git commit -m "Add file.txt"
```

---

## 2. What does the staging area do?

The staging area acts as a temporary holding area where changes can be reviewed before creating a commit.

It allows developers to choose exactly which changes should be included in the next commit.

---

## 3. What information does git log show?

`git log` displays:

* Commit ID (SHA)
* Author name
* Author email
* Commit date
* Commit message

Example:

```bash
git log
```

Compact view:

```bash
git log --oneline
```

---

## 4. What is the .git folder?

The `.git` directory contains all repository metadata, commit history, branches, tags, and configuration.

If the `.git` folder is deleted:

* Commit history is lost
* Branch information is lost
* Git no longer recognizes the directory as a repository

---

## 5. Working Directory vs Staging Area vs Repository

### Working Directory

Where files are created and modified.

### Staging Area

Temporary area where selected changes are prepared for commit.

### Repository

The permanent Git database where commits and history are stored.

Workflow:

Working Directory → Staging Area → Repository

```bash
git add file.txt
git commit -m "Save changes"
```

---

## What I Learned

1. Git tracks changes efficiently using commits.
2. The staging area provides control before committing.
3. A clean commit history makes collaboration easier.
