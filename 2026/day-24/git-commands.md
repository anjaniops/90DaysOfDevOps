# Advanced Git Commands

## Branching

```bash
git branch
git switch branch-name
git switch -c new-branch
git checkout branch-name
```

## Merge

```bash
git merge feature-branch
git merge --no-ff feature-branch
git merge --squash feature-branch
```

## Rebase

```bash
git rebase main
```

## Stash

```bash
git stash
git stash list
git stash pop
git stash apply
git stash push -m "message"
```

## Cherry Pick

```bash
git cherry-pick <commit-id>
```

## Visualize History

```bash
git log --oneline --graph --all
```

## Delete Branch

```bash
git branch -d branch-name
git branch -D branch-name
```