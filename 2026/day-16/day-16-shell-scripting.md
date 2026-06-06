# Day 16 – Shell Scripting Basics

## Task 1: Your First Script

### hello.sh

```bash
#!/bin/bash

echo "Hello, DevOps!"
```

### Make Executable and Run

```bash
chmod +x hello.sh
./hello.sh
```

### Output

```text
Hello, DevOps!
```

### What Happens Without Shebang?

Without `#!/bin/bash`, the script may not know which interpreter to use. It can still work if executed through `bash hello.sh`, but running it directly may cause issues depending on the shell environment.

---

## Task 2: Variables

### variables.sh

```bash
#!/bin/bash

NAME="Anjani"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"
```

### Output

```text
Hello, I am Anjani and I am a DevOps Engineer
```

### Single Quotes vs Double Quotes

```bash
echo '$NAME'
echo "$NAME"
```

Output:

```text
$NAME
Anjani
```

* Single quotes treat variables as plain text.
* Double quotes expand variables.

---

## Task 3: User Input with read

### greet.sh

```bash
#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

### Example Output

```text
Enter your name: Anjani
Enter your favourite tool: Docker

Hello Anjani, your favourite tool is Docker
```

---

## Task 4: If-Else Conditions

### check_number.sh

```bash
#!/bin/bash

read -p "Enter a number: " NUM

if [ "$NUM" -gt 0 ]; then
    echo "Positive Number"
elif [ "$NUM" -lt 0 ]; then
    echo "Negative Number"
else
    echo "Zero"
fi
```

### file_check.sh

```bash
#!/bin/bash

read -p "Enter filename: " FILE

if [ -f "$FILE" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```

---

## Task 5: Combine It All

### server_check.sh

```bash
#!/bin/bash

SERVICE="ssh"

read -p "Do you want to check the status? (y/n): " CHOICE

if [ "$CHOICE" = "y" ]; then
    systemctl is-active --quiet $SERVICE

    if [ $? -eq 0 ]; then
        echo "$SERVICE is active"
    else
        echo "$SERVICE is not active"
    fi
else
    echo "Skipped."
fi
```

---

## Commands Used

```bash
chmod +x script.sh
./script.sh
read
echo
if
elif
else
systemctl
```

---

## What I Learned

1. The shebang defines which interpreter executes a script.
2. Variables and user input make scripts dynamic and reusable.
3. Conditional statements help automate decisions and system checks.

## Key Takeaway

Shell scripting is one of the most important skills for DevOps engineers because it enables automation, reduces manual effort, and simplifies repetitive operational tasks.

