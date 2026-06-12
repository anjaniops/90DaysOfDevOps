# Git Commands Reference

## Setup & Configuration

### Check Git Version

```bash
git --version
```

Displays installed Git version.

### Configure Username

```bash
git config --global user.name "Anjani Kumar"
```

Sets Git username.

### Configure Email

```bash
git config --global user.email "your-email@example.com"
```

Sets Git email address.

### Verify Configuration

```bash
git config --list
```

Displays all Git configuration values.

---

## Repository Initialization

### Initialize Repository

```bash
git init
```

Creates a new Git repository.

### Check Repository Status

```bash
git status
```

Shows tracked, modified, and untracked files.

---

## Basic Workflow

### Stage File

```bash
git add filename
```

Adds a specific file to staging.

### Stage All Changes

```bash
git add .
```

Stages all changes.

### Commit Changes

```bash
git commit -m "Commit message"
```

Creates a commit with a message.

---

## Viewing Changes

### Show Commit History

```bash
git log
```

Displays detailed commit history.

### Compact History

```bash
git log --oneline
```

Shows commit history in one line per commit.

### Show Changes

```bash
git diff
```

Displays unstaged changes.

### Show Staged Changes

```bash
git diff --staged
```

Displays staged changes.

---

## Useful Commands

### Show Hidden Files

```bash
ls -la
```

Displays hidden files including `.git`.

### View Git Directory

```bash
ls -la .git
```

Shows Git repository metadata.

---

## Commands Learned So Far

```bash
git --version
git config --list
git init
git status
git add .
git commit -m "message"
git log
git log --oneline
git diff
git diff --staged
```
