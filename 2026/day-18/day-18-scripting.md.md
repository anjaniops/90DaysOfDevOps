# Day 18 – Shell Scripting: Functions & Intermediate Concepts

## Task 1: Basic Functions

### functions.sh

```bash
#!/bin/bash

greet() {
    echo "Hello, $1!"
}

add() {
    echo $(($1 + $2))
}

greet "Anjani"
echo "Sum: $(add 10 20)"
```

### Output

```text
Hello, Anjani!
Sum: 30
```

---

## Task 2: Functions with Return Values

### disk_check.sh

```bash
#!/bin/bash

check_disk() {
    echo "Disk Usage:"
    df -h /
}

check_memory() {
    echo "Memory Usage:"
    free -h
}

check_disk
echo
check_memory
```

---

## Task 3: Strict Mode

### strict_demo.sh

```bash
#!/bin/bash

set -euo pipefail

echo $UNDEFINED_VAR
```

### Understanding Strict Mode

* `set -e` → Exit immediately if a command fails.
* `set -u` → Exit when using an undefined variable.
* `set -o pipefail` → Return failure if any command in a pipeline fails.

Why it matters:

Strict mode helps catch errors early and makes scripts more reliable in production environments.

---

## Task 4: Local Variables

### local_demo.sh

```bash
#!/bin/bash

demo_local() {
    local NAME="LocalUser"
    echo "Inside Function: $NAME"
}

demo_global() {
    GLOBAL_NAME="GlobalUser"
}

demo_local
echo "Outside Function: $NAME"

demo_global
echo "Global Variable: $GLOBAL_NAME"
```

### Output

```text
Inside Function: LocalUser
Outside Function:
Global Variable: GlobalUser
```

Observation:

Local variables stay within the function scope, while global variables remain accessible throughout the script.

---

## Task 5: System Info Reporter

### system_info.sh

```bash
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
```

---

## Commands Used

```bash
chmod +x script.sh
./script.sh
function_name()
local
set -euo pipefail
df -h
free -h
hostnamectl
uptime
ps
```

---

## What I Learned

1. Functions make scripts modular and reusable.
2. Local variables prevent unwanted changes outside a function.
3. `set -euo pipefail` helps create safer and more reliable automation scripts.

## Key Takeaway

As shell scripts grow larger, using functions and strict mode becomes essential for maintainability, readability, and production-grade automation.
