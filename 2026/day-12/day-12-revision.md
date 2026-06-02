# Day 12 – Revision (Days 01–11)

## Topics Reviewed

### Linux Processes & Services

* Reviewed process management using `ps aux`
* Checked service status using `systemctl status`
* Viewed service logs using `journalctl`

### File Operations & Permissions

* Practiced file creation and modification
* Reviewed `chmod` permissions
* Reviewed `chown` and `chgrp` ownership changes

### User & Group Management

* Reviewed user creation and group assignments
* Verified ownership and permissions using `ls -l`

### Linux Commands Refreshed

* ps
* systemctl
* journalctl
* chmod
* chown

---

## Commands Revisited

```bash
ps aux | head

systemctl status ssh

journalctl -u ssh --no-pager | tail -n 10

ls -l

chmod 640 notes.txt

chown tokyo:developers devops-file.txt
```

---

## Mini Self-Check

### 1. Which 3 commands save you the most time right now, and why?

* `ps aux` → Quickly checks running processes.
* `systemctl status` → Helps identify service issues.
* `journalctl` → Useful for troubleshooting through logs.

### 2. How do you check if a service is healthy?

Commands I run first:

```bash
systemctl status <service-name>

journalctl -u <service-name>

ps aux | grep <service-name>
```

### 3. How do you safely change ownership and permissions without breaking access?

Example:

```bash
sudo chown anjani:developers app.log

sudo chmod 640 app.log
```

First verify ownership and permissions using:

```bash
ls -l app.log
```

### 4. What will you focus on improving in the next 3 days?

* Linux troubleshooting
* Shell scripting basics
* Git and GitHub workflows
* Automation concepts

---

## Key Takeaways

* Linux fundamentals are becoming more comfortable through daily practice.
* Understanding logs and services is essential for troubleshooting.
* Permissions and ownership are critical for system security and DevOps operations.
* Consistency is more important than speed while learning.

---

## Revision Complete ✅

Days 01–11 reviewed and reinforced.
Ready to continue the DevOps journey.

