# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset

### Difference Between Reset Types

| Command                  | Staging Area | Working Directory | Commit History |
| ------------------------ | ------------ | ----------------- | -------------- |
| git reset --soft HEAD~1  | Preserved    | Preserved         | Moved Back     |
| git reset --mixed HEAD~1 | Cleared      | Preserved         | Moved Back     |
| git reset --hard HEAD~1  | Cleared      | Removed           | Moved Back     |

### Which One is Destructive?

`git reset --hard` is destructive because it permanently removes uncommitted changes from the working directory.

### When to Use Each?

* **--soft**: When you want to undo a commit but keep changes staged.
* **--mixed**: When you want to undo a commit and review changes before staging again.
* **--hard**: When you want to completely discard commits and local changes.

### Should You Use Reset on Pushed Commits?

Generally no. Reset rewrites history and can cause problems for collaborators who already pulled the commits.

---

## Task 2: Git Revert

### What Happens During Revert?

Git creates a new commit that reverses the changes introduced by a previous commit.

### Is the Original Commit Removed?

No. The original commit remains in history, and Git adds another commit that cancels its effect.

### Reset vs Revert

* **Reset** removes commits from branch history.
* **Revert** preserves history and adds an undo commit.

### Why is Revert Safer?

Because it does not rewrite Git history. This makes it safe for shared branches and team environments.

### When to Use Revert?

* Production fixes
* Shared repositories
* Public branches

---

## Task 3: Reset vs Revert Comparison

| Feature                  | git reset            | git revert             |
| ------------------------ | -------------------- | ---------------------- |
| What it does             | Moves branch pointer | Creates an undo commit |
| Removes history          | Yes                  | No                     |
| Safe for pushed branches | No                   | Yes                    |
| Rewrites history         | Yes                  | No                     |
| Best use case            | Local cleanup        | Shared repositories    |

---

## Task 4: Branching Strategies

### 1. GitFlow

Flow:

main → develop → feature → release → main

Used for:

* Enterprise software
* Scheduled releases

Pros:

* Structured workflow
* Stable releases

Cons:

* Complex
* More branches to manage

---

### 2. GitHub Flow

Flow:

main → feature branch → pull request → main

Used for:

* SaaS applications
* Continuous deployment

Pros:

* Simple
* Easy collaboration

Cons:

* Less control over release cycles

---

### 3. Trunk-Based Development

Flow:

main ← short-lived branches ← developers

Used for:

* DevOps teams
* CI/CD environments

Pros:

* Faster delivery
* Smaller merges

Cons:

* Requires strong testing

---

### Which Strategy for a Startup?

GitHub Flow because it is lightweight and supports rapid releases.

### Which Strategy for a Large Enterprise?

GitFlow because it provides better release management and stability.

### Which Strategy Does Kubernetes Use?

Kubernetes primarily follows a Trunk-Based Development approach with short-lived branches and pull requests.

---

## Commands Practiced

```bash
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1

git revert <commit-id>

git reflog

git log --oneline --graph --all
```

---

## What I Learned

1. Reset rewrites history while Revert preserves history.
2. Revert is safer for team environments and production branches.
3. Different projects use different branching strategies depending on release requirements.
