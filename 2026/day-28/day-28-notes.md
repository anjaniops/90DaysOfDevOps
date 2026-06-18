# Day 28 – Revision Day (Days 1–27)

## Task 1: Self-Assessment Checklist

### Linux

| Topic | Status |
|---------|---------|
| Navigate file system, create/move/delete files | ✅ Can do confidently |
| Manage processes | ✅ Can do confidently |
| Work with systemd services | ✅ Can do confidently |
| Edit files with vi/vim or nano | ✅ Can do confidently |
| Troubleshoot CPU, memory, disk issues | ✅ Can do confidently |
| Linux file system hierarchy | ✅ Can do confidently |
| Create users and groups | ✅ Can do confidently |
| Manage file permissions | ✅ Can do confidently |
| Change ownership with chown/chgrp | ✅ Can do confidently |
| Create and manage LVM volumes | ⚠️ Need to revisit |
| Network troubleshooting commands | ✅ Can do confidently |
| DNS, IP, subnets and ports | ✅ Can do confidently |

### Shell Scripting

| Topic | Status |
|---------|---------|
| Variables, arguments and user input | ✅ Can do confidently |
| If/elif/else and case statements | ✅ Can do confidently |
| Loops | ✅ Can do confidently |
| Functions | ✅ Can do confidently |
| grep, awk, sed, sort, uniq | ✅ Can do confidently |
| Error handling | ⚠️ Need to revisit |
| Crontab scheduling | ✅ Can do confidently |

### Git & GitHub

| Topic | Status |
|---------|---------|
| Init, add, commit, log | ✅ Can do confidently |
| Branching | ✅ Can do confidently |
| Push and pull | ✅ Can do confidently |
| Clone vs Fork | ✅ Can do confidently |
| Merge branches | ✅ Can do confidently |
| Rebase | ⚠️ Need to revisit |
| Stash | ✅ Can do confidently |
| Cherry-pick | ⚠️ Need to revisit |
| Squash merge | ✅ Can do confidently |
| Reset and Revert | ✅ Can do confidently |
| Branching strategies | ✅ Can do confidently |
| GitHub CLI | ✅ Can do confidently |

---

## Task 2: Weak Topics Revisited

### 1. LVM Management

Revisited:
- Physical Volumes (PV)
- Volume Groups (VG)
- Logical Volumes (LV)
- Extending and resizing storage

Re-learned:
- LVM provides flexible storage management.
- Volumes can be expanded without repartitioning disks.

### 2. Git Rebase

Revisited:
- Rebasing feature branches onto main.
- Resolving rebase conflicts.

Re-learned:
- Rebase creates a cleaner linear history.
- Avoid rebasing shared branches.

### 3. Cherry-Pick

Revisited:
- Applying specific commits using commit hash.

Re-learned:
- Useful for hotfixes.
- Can create duplicate commits if used incorrectly.

---

## Task 3: Quick-Fire Questions

### 1. What does chmod 755 script.sh do?

Owner gets rwx permissions.
Group and others get r-x permissions.

### 2. Difference between process and service?

Process:
A running program.

Service:
A background process managed by systemd.

### 3. How do you find which process is using port 8080?

```bash
sudo ss -tulpn | grep 8080

4. What does set -euo pipefail do?
set -e → Exit on command failure
set -u → Error on undefined variables
set -o pipefail → Detect failures inside pipelines
5. Difference between git reset --hard and git revert?

git reset --hard removes commits and changes.

git revert creates a new commit that undoes changes.

6. Which branching strategy for a team of 5 developers shipping weekly?

GitHub Flow.

7. What does git stash do?

Temporarily saves uncommitted changes.

8. How do you schedule a script every day at 3 AM?
0 3 * * * /path/script.sh
9. Difference between git fetch and git pull?

git fetch downloads changes.

git pull downloads and merges changes.

10. What is LVM?

Logical Volume Manager provides flexible storage allocation and resizing without repartitioning disks.

Task 4: Work Organization
All submissions reviewed and pushed to GitHub.
git-commands.md updated.
Shell scripting cheat sheet verified.
GitHub profile reviewed and cleaned.
Task 5: Teach It Back
Explaining Git Branches

Git branches allow developers to work on different features independently without affecting the main codebase. Every branch starts from an existing commit and maintains its own history. Once a feature is complete, it can be merged back into the main branch. Branches help teams work in parallel, reduce conflicts, and safely experiment with new ideas before releasing them.

Key Takeaways
Consistency is more important than speed.
Hands-on practice improves retention far more than theory.
Git, Linux, Networking, and Shell Scripting are deeply connected in real-world DevOps work.