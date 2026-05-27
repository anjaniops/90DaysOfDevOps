#Day 06 – File Read/Write Practice
Commands I Ran
1. Create the file
```bash
touch notes.txt
```
Creates an empty file named `notes.txt`. No output — just makes the file exist.
---
2. Write the first line (overwrite)
```bash
echo "Logs tell the story of every system." > notes.txt
```
`>` redirects output into the file. Overwrites anything already there.
---
3. Append second line
```bash
echo "Configs control how services behave." >> notes.txt
```
`>>` appends to the file without erasing existing content.
---
4. Append third line using tee
```bash
echo "Scripts automate what humans repeat." | tee -a notes.txt
```
`tee -a` does two things at once — appends to the file and prints to the terminal.
---
5. Read the full file
```bash
cat notes.txt
```
Output:
```
Logs tell the story of every system.
Configs control how services behave.
Scripts automate what humans repeat.
```
---
6. Read only the first 2 lines
```bash
head -n 2 notes.txt
```
Output:
```
Logs tell the story of every system.
Configs control how services behave.
```
---
7. Read only the last 2 lines
```bash
tail -n 2 notes.txt
```
Output:
```
Configs control how services behave.
Scripts automate what humans repeat.
```
---
What I Learned
Command	What it does
`touch`	Creates an empty file
`>`	Writes to a file (overwrites)
`>>`	Appends to a file
`cat`	Reads the full file
`head -n`	Reads the first N lines
`tail -n`	Reads the last N lines
`tee -a`	Writes to file AND displays output at the same time
Why This Matters for DevOps
In real environments, logs live in `/var/log/`, configs in `/etc/`.
Being fast with `cat`, `tail -f`, and `tee` means faster debugging and cleaner automation scripts.
