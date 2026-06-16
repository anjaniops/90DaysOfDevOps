# Day 26 – GitHub CLI Notes

## Task 1: Authentication
**Q: What authentication methods does `gh` support?**
- HTTPS (browser-based OAuth)
- SSH key authentication
- Personal Access Token (PAT)
- GitHub Enterprise SSO

Commands used:
```bash
gh auth login
gh auth status
```

## Task 2: Repositories
```bash
# Create new repo
gh repo create my-test-repo --public --add-readme

# Clone repo
gh repo clone username/repo-name

# View repo details
gh repo view

# List all repos
gh repo list

# Open in browser
gh repo view --web

# Delete repo
gh repo delete my-test-repo --confirm
```

## Task 3: Issues
```bash
# Create issue
gh issue create --title "Bug fix" --body "Description" --label bug

# List issues
gh issue list --state open

# View specific issue
gh issue view 1

# Close issue
gh issue close 1
```

**Q: How to use `gh issue` in automation?**
- Auto-create issues from failed CI/CD pipelines
- Script bulk issue closing after release
- Label issues automatically based on content

## Task 4: Pull Requests
```bash
# Create PR
gh pr create --fill

# List PRs
gh pr list

# View PR details
gh pr view 1

# Merge PR
gh pr merge 1 --squash
```

**Q: What merge methods does `gh pr merge` support?**
- `--merge` — standard merge commit
- `--squash` — squash all commits
- `--rebase` — rebase and merge

**Q: How to review someone's PR?**
```bash
gh pr review 1 --approve
gh pr review 1 --request-changes --body "Please fix X"
gh pr review 1 --comment --body "Looks good!"
```

## Task 5: GitHub Actions
```bash
# List workflow runs
gh run list

# View specific run
gh run view <run-id>

# Watch live run
gh run watch <run-id>
```

**Q: How is `gh run` useful in CI/CD?**
- Monitor pipeline status from terminal
- Trigger workflows via scripts
- Get real-time feedback without browser

## Task 6: Useful Tricks
```bash
# Raw API call
gh api /user

# Create gist
gh gist create file.txt --public

# Create release
gh release create v1.0.0 --notes "Release notes"

# Create alias
gh alias set prc 'pr create --fill'

# Search repos
gh search repos kubernetes --language go
```
