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