# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## Task 1: For Loop

### for_loop.sh

```bash
#!/bin/bash

for fruit in Apple Mango Banana Orange Grapes
do
    echo $fruit
done
```

### count.sh

```bash
#!/bin/bash

for i in {1..10}
do
    echo $i
done
```

---

## Task 2: While Loop

### countdown.sh

```bash
#!/bin/bash

read -p "Enter a number: " num

while [ $num -ge 0 ]
do
    echo $num
    ((num--))
done

echo "Done!"
```

---

## Task 3: Command-Line Arguments

### greet.sh

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi
```

### args_demo.sh

```bash
#!/bin/bash

echo "Script Name: $0"
echo "Total Arguments: $#"
echo "Arguments: $@"
```

---

## Task 4: Install Packages via Script

### install_packages.sh

```bash
#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

packages=("nginx" "curl" "wget")

for pkg in "${packages[@]}"
do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "$pkg is already installed."
    else
        echo "Installing $pkg..."
        apt-get install -y "$pkg"
    fi
done
```

---

## Task 5: Error Handling

### safe_script.sh

```bash
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || {
    echo "Failed to enter directory"
    exit 1
}

touch demo.txt || echo "Failed to create file"

echo "Script completed successfully."
```

---

## Example Outputs

### greet.sh

```bash
./greet.sh Anjani
```

Output:

```text
Hello, Anjani!
```

### args_demo.sh

```bash
./args_demo.sh DevOps AWS Docker
```

Output:

```text
Script Name: ./args_demo.sh
Total Arguments: 3
Arguments: DevOps AWS Docker
```

---

## Commands Used

```bash
chmod +x script.sh
./script.sh
for
while
read
if
dpkg
apt-get
set -e
```

---

## What I Learned

1. Loops help automate repetitive tasks efficiently.
2. Command-line arguments make scripts reusable and flexible.
3. Error handling improves script reliability and prevents unexpected failures.

## Key Takeaway

Shell scripting becomes much more powerful when combined with loops, arguments, and error handling. These concepts are commonly used in automation, system administration, and DevOps workflows.

