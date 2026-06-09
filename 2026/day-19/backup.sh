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