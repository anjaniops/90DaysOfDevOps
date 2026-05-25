# Day 02 – Linux Architecture, Processes, and systemd

## Core Components of Linux

Linux mainly has two parts:

- Kernel → This is the core part of OS. It directly interacts with hardware like CPU, memory, disk etc. It manages processes, memory, and devices.
- User Space → This is where applications like nginx, docker, bash run. These programs cannot directly access hardware, they go through kernel using system calls.
- systemd (init) → This is the first process started when system boots (PID 1). It starts and manages all services.

---

## Process Management

A process is simply a running program.

Each process has a PID (Process ID).

### How process is created:
- First `fork()` happens → creates a copy of parent process
- Then `exec()` → loads new program into that process

---

## Process States

- Running (R) → currently executing
- Sleeping (S) → waiting (like for input/output)
- Stopped (T) → paused
- Zombie (Z) → process finished but parent didn’t clean it

---

## systemd

systemd is used to manage services in Linux.

Why it is important:
- Starts services during boot
- Can restart services automatically if they fail
- Helps in checking logs
- Manages dependencies between services

---

## Useful Commands (daily use)

- `ps aux` → check running processes
- `top` → see CPU/memory usage
- `kill -9 PID` → stop a process
- `systemctl status nginx` → check service status
- `journalctl -u nginx` → check logs of service

---

## My Understanding

Earlier I was just running commands without knowing what happens in background.

Now I understand:
- How processes are created
- Why zombie processes happen
- How systemd manages services

If any service fails, first step is:
check status → check logs → restart if needed

This will help a lot in real production issues.
