# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Task 1: Log Rotation Script

### log_rotate.sh

```bash
#!/bin/bash

set -euo pipefail

LOG_DIR=${1:-}

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

compressed=$(find "$LOG_DIR" -name "*.log" -mtime +7 -exec gzip {} \; | wc -l)

deleted=$(find "$LOG_DIR" -name "*.gz" -mtime +30 -delete | wc -l)

echo "Compressed files: $compressed"
echo "Deleted files: $deleted"
```

### Sample Output

```text
Compressed files: 5
Deleted files: 2
```

---

## Task 2: Server Backup Script

### backup.sh

```bash
#!/bin/bash

set -euo pipefail

SOURCE=${1:-}
DEST=${2:-}

if [ ! -d "$SOURCE" ]; then
    echo "Source directory does not exist."
    exit 1
fi

mkdir -p "$DEST"

TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
BACKUP_FILE="$DEST/backup-$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE"

if [ -f "$BACKUP_FILE" ]; then
    echo "Backup created successfully."
    ls -lh "$BACKUP_FILE"
fi

find "$DEST" -name "*.tar.gz" -mtime +14 -delete
```

### Sample Output

```text
Backup created successfully.
-rw-r--r-- 1 root root 15M Jun 19 backup-2026-06-19.tar.gz
```

---

## Task 3: Crontab

### Current Crontab

```bash
crontab -l
```

### Run log rotation every day at 2 AM

```bash
0 2 * * * /home/anjani/scripts/log_rotate.sh /var/log/myapp
```

### Run backup every Sunday at 3 AM

```bash
0 3 * * 0 /home/anjani/scripts/backup.sh /data /backup
```

### Run health check every 5 minutes

```bash
*/5 * * * * /home/anjani/scripts/health_check.sh
```

---

## Task 4: Scheduled Maintenance Script

### maintenance.sh

```bash
#!/bin/bash

set -euo pipefail

LOGFILE="/var/log/maintenance.log"

echo "$(date) - Maintenance Started" >> "$LOGFILE"

./log_rotate.sh /var/log/myapp >> "$LOGFILE" 2>&1

./backup.sh /data /backup >> "$LOGFILE" 2>&1

echo "$(date) - Maintenance Completed" >> "$LOGFILE"
```

### Daily Maintenance Cron

```bash
0 1 * * * /home/anjani/scripts/maintenance.sh
```

---

## Commands Used

```bash
find
gzip
tar
crontab
date
wc
mkdir
ls
```

---

## What I Learned

1. Log rotation helps manage disk space and keeps log directories organized.
2. Automated backups improve reliability and recovery readiness.
3. Cron jobs enable hands-free scheduling of routine maintenance tasks.

## Key Takeaway

Combining shell scripting with cron allows repetitive operational tasks such as backups, log cleanup, and health checks to run automatically, improving system reliability and reducing manual effort.
