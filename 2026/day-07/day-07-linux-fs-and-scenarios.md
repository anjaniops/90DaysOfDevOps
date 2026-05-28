# 🚀 Day 07 – Linux File System Hierarchy & Scenario-Based Practice

---

## 📁 Part 1: Linux File System Hierarchy

### 🔹 / (Root)
- The base of the entire Linux filesystem. Everything starts from here.
- Example: /home, /etc, /var
- I would use this when navigating the system from absolute paths.

---

### 🔹 /home
- Contains home directories for all users.
- Example: /home/anjani
- I would use this to access user files and personal scripts.

---

### 🔹 /root
- Home directory of the root (admin) user.
- Example: /root/.bashrc
- I would use this when working with administrative configurations.

---

### 🔹 /etc
- Stores system-wide configuration files.
- Example: /etc/hostname, /etc/passwd
- I would use this when modifying service or system configurations.

---

### 🔹 /var/log
- Contains system and application log files.
- Example: /var/log/syslog, /var/log/auth.log
- I would use this for debugging issues and checking logs.

---

### 🔹 /tmp
- Stores temporary files (auto-deleted after reboot).
- Example: temp scripts, cache files
- I would use this for temporary testing or storage.

---

### 🔹 /bin
- Essential system binaries (commands).
- Example: ls, cp, mv
- I would use this to understand where core commands reside.

---

### 🔹 /usr/bin
- Contains user-level command binaries.
- Example: python, git
- I would use this when working with installed applications.

---

### 🔹 /opt
- Used for third-party or optional software.
- Example: /opt/docker, /opt/custom-app
- I would use this for manually installed tools or applications.

---

## 🛠️ Hands-On Commands

### 🔍 Find largest log files
```bash
du -sh /var/log/* 2>/dev/null | sort -h | tail -5
