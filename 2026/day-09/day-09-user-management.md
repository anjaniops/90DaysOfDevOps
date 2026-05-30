# Day 09 Challenge – Linux User & Group Management

## Users & Groups Created

### Users

* tokyo
* berlin
* professor
* nairobi

### Groups

* developers
* admins
* project-team

---

## Group Assignments

| User      | Groups                   |
| --------- | ------------------------ |
| tokyo     | developers, project-team |
| berlin    | developers, admins       |
| professor | admins                   |
| nairobi   | project-team             |

---

## Directories Created

| Directory           | Group Owner  | Permissions |
| ------------------- | ------------ | ----------- |
| /opt/dev-project    | developers   | 775         |
| /opt/team-workspace | project-team | 775         |

---

## Commands Used

### Create Users

```bash
sudo useradd -m tokyo
sudo passwd tokyo

sudo useradd -m berlin
sudo passwd berlin

sudo useradd -m professor
sudo passwd professor

sudo useradd -m nairobi
sudo passwd nairobi
```

### Create Groups

```bash
sudo groupadd developers
sudo groupadd admins
sudo groupadd project-team
```

### Assign Users to Groups

```bash
sudo usermod -aG developers tokyo

sudo usermod -aG developers,admins berlin

sudo usermod -aG admins professor

sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```

### Verification Commands

```bash
cat /etc/passwd
cat /etc/group

groups tokyo
groups berlin
groups professor
groups nairobi
```

### Shared Directory Setup

```bash
sudo mkdir -p /opt/dev-project
sudo chgrp developers /opt/dev-project
sudo chmod 775 /opt/dev-project
```

### Team Workspace Setup

```bash
sudo mkdir -p /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace
```

### Test Access

```bash
sudo -u tokyo touch /opt/dev-project/tokyo.txt
sudo -u berlin touch /opt/dev-project/berlin.txt

sudo -u nairobi touch /opt/team-workspace/nairobi.txt
```

### Check Permissions

```bash
ls -ld /opt/dev-project
ls -ld /opt/team-workspace
```

---

## What I Learned

1. Linux users and groups provide structured access control.
2. Group permissions allow teams to collaborate securely on shared directories.
3. Ownership and permissions are fundamental for Linux security and DevOps administration.

---

## Screenshots

Add screenshots of:

* User creation
* Group creation
* Group membership verification
* Directory permissions
* File creation tests

