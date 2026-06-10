# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Objective

Build a Bash script that analyzes log files, identifies errors and critical events, and generates a summary report automatically.

---

## Script: log_analyzer.sh

```bash
#!/bin/bash

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOGFILE="$1"

if [ ! -f "$LOGFILE" ]; then
    echo "Error: File does not exist."
    exit 1
fi

DATE=$(date +%Y-%m-%d)
REPORT="log_report_${DATE}.txt"

TOTAL_LINES=$(wc -l < "$LOGFILE")
ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOGFILE" | wc -l)

echo "Total Errors: $ERROR_COUNT"

CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOGFILE" || true)

TOP_ERRORS=$(grep "ERROR" "$LOGFILE" \
    | sed 's/.*ERROR[: ]*//' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -5)

{
echo "===== Log Analysis Report ====="
echo "Date: $DATE"
echo "Log File: $LOGFILE"
echo "Total Lines Processed: $TOTAL_LINES"
echo "Total Error Count: $ERROR_COUNT"
echo

echo "===== Top 5 Error Messages ====="
echo "$TOP_ERRORS"
echo

echo "===== Critical Events ====="
echo "$CRITICAL_EVENTS"

} > "$REPORT"

echo "Report generated: $REPORT"

mkdir -p archive
mv "$LOGFILE" archive/

echo "Log file moved to archive/"
```

---

## Sample Output

```text
Total Errors: 15

Report generated: log_report_2026-06-20.txt

Log file moved to archive/
```

---

## Generated Report

```text
===== Log Analysis Report =====

Date: 2026-06-20
Log File: sample_log.log

Total Lines Processed: 500
Total Error Count: 15

===== Top 5 Error Messages =====

5 Connection timed out
4 Permission denied
3 File not found
2 Disk I/O error
1 Out of memory

===== Critical Events =====

84: CRITICAL Disk space below threshold
217: CRITICAL Database connection lost
```

---

## Commands Used

- grep
- awk
- sed
- sort
- uniq
- wc
- date
- mv
- mkdir

---

## What I Learned

1. Bash can automate log analysis and reporting tasks.
2. grep, sort, uniq, and sed are powerful tools for processing logs.
3. Automating repetitive operational tasks saves time and improves reliability.

---

## Key Takeaway

Log analysis is a critical part of troubleshooting and system administration. Automating it with Bash scripts helps identify issues faster and reduces manual effort.