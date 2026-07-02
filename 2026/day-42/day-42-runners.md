Day 42 – GitHub-Hosted & Self-Hosted Runners

🎯 Objective

Understand how GitHub Actions workflows are executed using runners and learn the differences between GitHub-hosted and self-hosted runners.

✅ Tasks Completed

- Created workflows that run on:
  - Ubuntu ("ubuntu-latest")
  - Windows ("windows-latest")
  - macOS ("macos-latest")
- Displayed runner information such as:
  - Operating System
  - Hostname
  - Current User
- Explored pre-installed software on GitHub-hosted runners:
  - Docker
  - Python
  - Node.js
  - Git
- Configured a self-hosted runner for the repository.
- Executed a workflow on the self-hosted runner.
- Printed the machine hostname and working directory.
- Created and verified a file on the self-hosted machine.
- Added a custom runner label and executed a workflow using that label.

💡 Key Learnings

- GitHub-hosted runners are fully managed by GitHub and come with commonly used development tools pre-installed.
- Self-hosted runners provide complete control over the execution environment and are useful when custom software, private network access, or specialized hardware is required.
- Runner labels make it easy to target specific self-hosted machines when multiple runners are available.

📁 Files

- "hosted-runner.yml"
- "self-hosted.yml"
- "day-42-runners.md"

🚀 Outcome

Successfully learned how GitHub Actions runners execute workflows, configured a self-hosted runner, and compared GitHub-hosted and self-hosted environments through hands-on practice.
