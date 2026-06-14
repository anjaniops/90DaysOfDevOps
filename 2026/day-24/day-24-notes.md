# Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1: Git Merge

### What is a Fast-Forward Merge?

A fast-forward merge occurs when the target branch has no new commits since the feature branch was created. Git simply moves the branch pointer forward without creating a new merge commit.

### When does Git create a Merge Commit?

Git creates a merge commit when both branches have diverged and contain different commits. The merge commit combines both histories.

### What is a Merge Conflict?

A merge conflict occurs when Git cannot automatically merge changes because the same file and line were modified differently in two branches.

### Commands Used

```bash
git checkout -b feature-login
git add .
git commit -m "Add login feature"

git checkout main
git merge feature-login
```

---

## Task 2: Git Rebase

### What does Rebase do?

Rebase moves commits from one branch and reapplies them on top of another branch, creating a cleaner linear history.

### How is Rebase Different from Merge?

- Merge preserves branch history and creates merge commits.
- Rebase rewrites commit history and creates a straight timeline.

### Why should you avoid rebasing shared commits?

Rebasing changes commit hashes. If commits have already been pushed and shared, rebasing can cause conflicts and confusion for other collaborators.

### When should you use Rebase vs Merge?

Use Rebase:
- Before merging feature branches.
- To keep commit history clean.

Use Merge:
- When preserving branch history is important.
- For team collaboration on shared branches.

### Commands Used

```bash
git checkout feature-dashboard
git rebase main
```

---

## Task 3: Squash Merge vs Regular Merge

### What does Squash Merge do?

Squash merge combines multiple commits from a feature branch into a single commit before merging into the target branch.

### When should you use Squash Merge?

- Small features
- Bug fixes
- Cleanup commits

### Trade-off of Squashing

Pros:
- Cleaner history

Cons:
- Individual commit history is lost

### Commands Used

```bash
git merge --squash feature-profile
git commit -m "Add profile feature"
```

---

## Task 4: Git Stash

### Difference between git stash pop and git stash apply

git stash apply:
- Applies changes
- Keeps stash entry

git stash pop:
- Applies changes
- Removes stash entry

### Real-World Use Case

Stash is useful when working on a feature and an urgent production issue requires switching branches immediately.

### Commands Used

```bash
git stash
git stash list
git stash apply
git stash pop
git stash push -m "Work in progress"
```

---

## Task 5: Cherry Pick

### What does Cherry Pick do?

Cherry-pick applies a specific commit from one branch to another branch.

### When would you use Cherry Pick?

- Apply a hotfix to production
- Copy a bug fix without merging an entire branch

### Risks of Cherry Picking

- Duplicate commits
- Merge conflicts
- Confusing commit history if overused

### Commands Used

```bash
git log --oneline

git cherry-pick <commit-id>
```

---

# Merge vs Rebase

| Merge | Rebase |
|---------|---------|
| Preserves branch history | Creates linear history |
| Creates merge commits | Rewrites commit history |
| Safer for shared branches | Best for local branches |

---

# What I Learned

1. Merge preserves history while Rebase creates a cleaner timeline.
2. Stash allows temporary storage of uncommitted work.
3. Cherry-pick helps move individual fixes between branches.
