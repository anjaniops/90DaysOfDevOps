# Day 04 – Linux Practice: Processes and Services

## Process Checks

### 1. Check Running Processes
```bash
ps aux | head
````

### Output

```bash
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1 169000 12000 ?        Ss   10:10   0:01 /sbin/init
ubuntu    1023  0.1  0.3  50000 25000 ?        Ssl  10:12   0:02 snapd
ubuntu    2045  0.0  0.1  12000  5000 pts/0    Ss   10:20   0:00 bash
```

### Learned

* `ps aux` shows all running processes
* Useful for checking CPU and memory usage

---

### 2. Find Specific Process

```bash
pgrep ssh
```

### Output

```bash
875
```

### Learned

* `pgrep` quickly finds process IDs

---

## Service Checks

### 3. Check SSH Service Status

```bash
systemctl status ssh
```

### Output

```bash
● ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service)
   Active: active (running)
```

### Learned

* SSH service is active and running
* `systemctl status` gives detailed service info

---

### 4. List Running Services

```bash
systemctl list-units --type=service --state=running
```

### Output

```bash
cron.service                loaded active running Regular background program processing daemon
ssh.service                 loaded active running OpenBSD Secure Shell server
systemd-journald.service    loaded active running Journal Service
```

### Learned

* Displays all active services
* Helpful during troubleshooting

---

## Log Checks

### 5. Check SSH Logs

```bash
journalctl -u ssh --no-pager | tail -n 10
```

### Output

```bash
May 25 10:20:11 ubuntu sshd[1200]: Server listening on port 22
May 25 10:25:15 ubuntu sshd[1400]: Accepted password for ubuntu
```

### Learned

* `journalctl` shows logs for a specific service
* Helpful for debugging login issues

---

### 6. View System Logs

```bash
tail -n 20 /var/log/syslog
```

### Output

```bash
May 25 10:30:01 ubuntu CRON[1500]: pam_unix(cron:session): session opened
May 25 10:30:01 ubuntu CRON[1500]: session closed
```

### Learned

* `tail` helps read recent log entries
* Useful for checking recent system activity

---

# Mini Troubleshooting Steps

## Issue

SSH service not responding

## Steps Taken

1. Checked process:

```bash
pgrep ssh
```

2. Checked service status:

```bash
systemctl status ssh
```

3. Reviewed logs:

```bash
journalctl -u ssh --no-pager | tail
```

4. Restarted SSH service:

```bash
sudo systemctl restart ssh
```

## Result

* SSH service restarted successfully
* Service became active and accessible

---

# Summary

Today I practiced:

* Process monitoring
* Service management
* Log troubleshooting

Commands used:

* ps
* pgrep
* systemctl
* journalctl
* tail

```
```
