# Day 10 Challenge – File Permissions & File Operations

## Files Created

* devops.txt
* notes.txt
* script.sh
* project/ (directory)

---

## Permission Changes

### Before

```bash
-rw-rw-r-- devops.txt
-rw-rw-r-- notes.txt
-rw-rw-r-- script.sh
```

### After

```bash
-r--r--r-- devops.txt
-rw-r----- notes.txt
-rwxrwxr-x script.sh
drwxr-xr-x project/
```

---

## Commands Used

### Create Files

```bash
touch devops.txt

echo "Linux file permissions practice" > notes.txt

vim script.sh
```

Content of script.sh:

```bash
echo "Hello DevOps"
```

### Read Files

```bash
cat notes.txt

vim -R script.sh

head -n 5 /etc/passwd

tail -n 5 /etc/passwd
```

### Check Permissions

```bash
ls -l devops.txt notes.txt script.sh
```

### Modify Permissions

```bash
chmod +x script.sh

chmod a-w devops.txt

chmod 640 notes.txt

mkdir project

chmod 755 project
```

### Verify Changes

```bash
ls -l

ls -ld project
```

### Execute Script

```bash
./script.sh
```

Output:

```bash
Hello DevOps
```

---

## Permission Testing

### Writing to Read-Only File

```bash
echo "test" >> devops.txt
```

Error:

```bash
Permission denied
```

### Executing Without Execute Permission

```bash
chmod -x script.sh

./script.sh
```

Error:

```bash
Permission denied
```

---

## What I Learned

1. Linux permissions control who can read, write, and execute files.
2. chmod can be used to modify permissions using symbolic or numeric modes.
3. Execute permission is required to run scripts, while directory permissions control access to folders.

