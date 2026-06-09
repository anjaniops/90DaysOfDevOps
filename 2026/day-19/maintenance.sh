#!/bin/bash

set -euo pipefail

LOGFILE="/var/log/maintenance.log"

echo "$(date) - Maintenance Started" >> "$LOGFILE"

./log_rotate.sh /var/log/myapp >> "$LOGFILE" 2>&1

./backup.sh /data /backup >> "$LOGFILE" 2>&1

echo "$(date) - Maintenance Completed" >> "$LOGFILE"