#!/bin/bash

set -euo pipefail

system_info() {
    echo "===== Host Information ====="
    hostnamectl
}

uptime_info() {
    echo "===== Uptime ====="
    uptime
}

disk_usage() {
    echo "===== Disk Usage ====="
    df -h | head -n 6
}

memory_usage() {
    echo "===== Memory Usage ====="
    free -h
}

top_processes() {
    echo "===== Top CPU Processes ====="
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
}

main() {
    system_info
    echo
    uptime_info
    echo
    disk_usage
    echo
    memory_usage
    echo
    top_processes
}

main