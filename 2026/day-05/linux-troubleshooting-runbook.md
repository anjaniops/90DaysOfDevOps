# Day 05 – Linux Troubleshooting Drill

## Target Service / Process
Service inspected: ssh

Goal:
Check system health, inspect logs, verify network activity, and identify possible issues before escalation.

---

# Environment Basics

## 1. System Information

```bash
uname -a
```

Output:
```bash
Linux ubuntu 6.8.0-31-generic x86_64 GNU/Linux
```

Observation:
Kernel and architecture look normal. System is running Ubuntu Linux.

---

## 2. OS Release

```bash
cat /etc/os-release
```

Output:
```bash
PRETTY_NAME="Ubuntu 24.04 LTS"
```

Observation:
Confirmed OS version and distribution.

---

# Filesystem Sanity

## 3. Create Temporary Runbook Folder

```bash
mkdir /tmp/runbook-demo
```

Observation:
Temporary troubleshooting workspace created successfully.

---

## 4. Copy and Verify File

```bash
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```

Output:
```bash
-rw-r--r-- 1 user user 234 hosts-copy
```

Observation:
Filesystem is writable and file operations are working correctly.

---

# Snapshot: CPU & Memory

## 5. Check Memory Usage

```bash
free -h
```

Output:
```bash
Mem: 7.6Gi used 3.2Gi free 2.1Gi
```

Observation:
Memory usage is healthy. No swap pressure observed.

---

## 6. Inspect SSH Process Resource Usage

```bash
ps -o pid,pcpu,pmem,comm -C sshd
```

Output:
```bash
PID   %CPU %MEM COMMAND
722    0.0  0.2 sshd
```

Observation:
SSH service is consuming very low CPU and memory.

---

# Snapshot: Disk & IO

## 7. Disk Space Check

```bash
df -h
```

Output:
```bash
/ dev/sda1   50G   21G   27G   45%
```

Observation:
Disk usage is normal. No partition is critically full.

---

## 8. Check Log Directory Size

```bash
du -sh /var/log
```

Output:
```bash
1.2G /var/log
```

Observation:
Log directory size is manageable. No unusual growth detected.

---

# Snapshot: Network

## 9. Verify Listening Ports

```bash
ss -tulpn | grep ssh
```

Output:
```bash
tcp LISTEN 0 128 0.0.0.0:22
```

Observation:
SSH service is actively listening on port 22.

---

## 10. Test Local Connectivity

```bash
curl -I http://localhost
```

Output:
```bash
curl: (7) Failed to connect
```

Observation:
No web service running locally, which is expected for this drill.

---

# Logs Reviewed

## 11. Review SSH Service Logs

```bash
journalctl -u ssh -n 50
```

Output:
```bash
Accepted password for user from 192.168.1.5
```

Observation:
Recent login activity appears normal. No authentication failures observed.

---

## 12. Review System Logs

```bash
tail -n 50 /var/log/syslog
```

Observation:
No critical errors or repeated service crashes found in recent logs.

---

# Quick Findings

- System memory and CPU usage are stable
- SSH service is running normally
- Disk usage is within safe limits
- No major network or log-related issues detected
- No repeated failures or restart loops observed

---

# If This Worsens (Next Steps)

1. Restart SSH service safely:
```bash
sudo systemctl restart ssh
```

2. Increase log monitoring:
```bash
journalctl -u ssh -f
```

3. Capture deeper diagnostics:
```bash
strace -p <PID>
```

Additional checks:
- Investigate failed login attempts
- Review firewall rules
- Verify network latency and connectivity

---

# Commands Used

- uname -a
- cat /etc/os-release
- mkdir
- cp
- ls -l
- free -h
- ps
- df -h
- du -sh
- ss -tulpn
- curl
- journalctl
- tail
