Day 03 – Linux Commands Practice
A quick-reference toolkit for daily operations, log inspection, and system troubleshooting.
📁 File System & Navigation
`pwd` - Print the current working directory path.
`ls -lah` - List all files (including hidden) with detailed permissions in a human-readable format.
`cd -` - Quickly jump back to the previous working directory.
`mkdir -p /path/to/dir` - Create nested directories in a single command without errors.
`rm -rf dir_name/` - Forcefully remove a directory and all of its contents recursively.
`cp -r source/ dest/` - Copy a directory and its contents recursively.
`chmod +x script.sh` - Grant execution permissions to a file.
`find . -name "*.log"` - Search for files ending in `.log` within the current directory.
`grep -rnw '/path/' -e 'error'` - Recursively search for the exact word "error" inside files.
`tail -f /var/log/syslog` - Continuously output appended data as a file grows (essential for live log monitoring).
`tar -czvf archive.tar.gz /folder` - Compress a folder into a gzip archive.
⚙️ Process Management & System Resources
`top` - View an interactive, real-time list of running processes and system resource usage.
`ps aux` - Display a snapshot of all currently running processes across all users.
`kill -9 <PID>` - Forcefully terminate a process using its Process ID.
`df -h` - Show disk space usage across all mounted file systems in a human-readable format.
`free -m` - Display total, used, and free system memory (RAM and Swap) in megabytes.
`lsof -i :8080` - List processes bound to a specific port (e.g., port 8080).
`systemctl status nginx` - Check the current running status of a systemd service.
`uptime` - Show how long the system has been running and current load averages.
🌐 Networking Troubleshooting
`ping -c 4 google.com` - Test network connectivity by sending 4 ICMP echo requests to a host.
`ip addr` - Display all network interfaces and their assigned IP addresses.
`curl -I https://example.com` - Fetch only the HTTP headers of a URL to verify server response without downloading the payload.
`dig example.com` - Query DNS servers to troubleshoot domain resolution and view DNS records.
`netstat -tulnp` - List all active listening ports and their associated process IDs.
`traceroute google.com` - Trace the network path and measure transit delays of packets to a host.
