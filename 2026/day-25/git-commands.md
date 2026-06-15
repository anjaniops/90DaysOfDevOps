# Reset
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1

# Revert
git revert <commit-id>

# Recovery
git reflog

# Visualize History
git log --oneline --graph --all