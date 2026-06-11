# Day 21 – Shell Scripting Cheat Sheet

## Quick Reference

| Topic        | Syntax              | Example                        |
| ------------ | ------------------- | ------------------------------ |
| Variable     | `VAR="value"`       | `NAME="Anjani"`                |
| Argument     | `$1`, `$2`          | `./script.sh file.txt`         |
| If Statement | `if [ condition ]`  | `if [ -f file ]`               |
| For Loop     | `for i in list`     | `for i in 1 2 3`               |
| Function     | `name() {}`         | `greet() {}`                   |
| Grep         | `grep pattern file` | `grep error app.log`           |
| Awk          | `awk '{print $1}'`  | `awk -F: '{print $1}' file`    |
| Sed          | `sed 's/old/new/g'` | `sed -i 's/http/https/g' file` |

---

# 1. Basics

## Shebang

```bash
#!/bin/bash
```

Defines the interpreter used to run the script.

## Running Scripts

```bash
chmod +x script.sh
./script.sh

bash script.sh
```

## Comments

```bash
# Single line comment

echo "Hello" # Inline comment
```

## Variables

```bash
NAME="Anjani"

echo $NAME
echo "$NAME"
echo '$NAME'
```

## User Input

```bash
read -p "Enter Name: " NAME
echo $NAME
```

## Command Line Arguments

```bash
$0  # Script Name
$1  # First Argument
$2  # Second Argument
$#  # Number of Arguments
$@  # All Arguments
$?  # Exit Status
```

---

# 2. Conditionals & Operators

## String Comparison

```bash
[ "$A" = "$B" ]
[ "$A" != "$B" ]
[ -z "$VAR" ]
[ -n "$VAR" ]
```

## Integer Comparison

```bash
[ "$A" -eq "$B" ]
[ "$A" -ne "$B" ]
[ "$A" -gt "$B" ]
[ "$A" -lt "$B" ]
[ "$A" -ge "$B" ]
[ "$A" -le "$B" ]
```

## File Tests

```bash
-f file
-d directory
-e file
-r file
-w file
-x file
-s file
```

## If Else

```bash
if [ -f file ]; then
    echo "Exists"
elif [ -d dir ]; then
    echo "Directory"
else
    echo "Not Found"
fi
```

## Logical Operators

```bash
cmd1 && cmd2
cmd1 || cmd2
! cmd
```

## Case Statement

```bash
case $VAR in
  start) echo "Start";;
  stop) echo "Stop";;
  *) echo "Unknown";;
esac
```

---

# 3. Loops

## For Loop

```bash
for i in 1 2 3 4 5
do
  echo $i
done
```

## C-Style Loop

```bash
for ((i=1;i<=5;i++))
do
  echo $i
done
```

## While Loop

```bash
COUNT=1

while [ $COUNT -le 5 ]
do
  echo $COUNT
  COUNT=$((COUNT+1))
done
```

## Until Loop

```bash
COUNT=1

until [ $COUNT -gt 5 ]
do
  echo $COUNT
  COUNT=$((COUNT+1))
done
```

## Break & Continue

```bash
break
continue
```

## Loop Through Files

```bash
for file in *.log
do
  echo $file
done
```

---

# 4. Functions

## Function Definition

```bash
greet() {
  echo "Hello $1"
}
```

## Function Call

```bash
greet Anjani
```

## Return Value

```bash
add() {
  echo $(($1 + $2))
}
```

## Local Variables

```bash
test_func() {
  local NAME="DevOps"
  echo $NAME
}
```

---

# 5. Text Processing

## grep

```bash
grep error file.log
grep -i error file.log
grep -n error file.log
grep -c error file.log
grep -v error file.log
```

## awk

```bash
awk '{print $1}' file
awk -F: '{print $1}' /etc/passwd
```

## sed

```bash
sed 's/old/new/g' file
sed -i 's/http/https/g' config.txt
```

## cut

```bash
cut -d: -f1 /etc/passwd
```

## sort

```bash
sort file
sort -n file
sort -r file
```

## uniq

```bash
uniq file
uniq -c file
```

## tr

```bash
tr 'a-z' 'A-Z'
```

## wc

```bash
wc -l file
wc -w file
```

## head & tail

```bash
head -5 file
tail -5 file
tail -f app.log
```

---

# 6. Useful DevOps One-Liners

## Delete Files Older Than 7 Days

```bash
find /tmp -type f -mtime +7 -delete
```

## Count Lines in Log Files

```bash
wc -l *.log
```

## Follow Errors in Real Time

```bash
tail -f app.log | grep ERROR
```

## Check Service Status

```bash
systemctl is-active nginx
```

## Check Disk Usage

```bash
df -h
```

---

# 7. Error Handling & Debugging

## Exit Codes

```bash
exit 0
exit 1

echo $?
```

## Exit on Error

```bash
set -e
```

## Error on Undefined Variables

```bash
set -u
```

## Catch Pipe Errors

```bash
set -o pipefail
```

## Debug Mode

```bash
set -x
```

## Trap Cleanup

```bash
trap 'echo Cleanup' EXIT
```

---

# What I Learned

1. Shell scripting is a powerful way to automate repetitive Linux tasks.
2. grep, awk, sed, and sort are essential tools for text and log processing.
3. Functions and proper error handling make scripts more reliable and reusable.
