# Day 11 Challenge – File Ownership

## Files & Directories Created

### Files

* devops-file.txt
* team-notes.txt
* project-config.yaml
* heist-project/vault/gold.txt
* heist-project/plans/strategy.conf
* bank-heist/access-codes.txt
* bank-heist/blueprints.pdf
* bank-heist/escape-plan.txt

### Directories

* app-logs/
* heist-project/
* heist-project/vault/
* heist-project/plans/
* bank-heist/

---

## Ownership Changes

### Basic Owner Changes

* devops-file.txt: anjani:anjani → tokyo:tokyo
* devops-file.txt: tokyo:tokyo → berlin:berlin

### Group Changes

* team-notes.txt: anjani → heist-team

### Owner & Group Together

* project-config.yaml: anjani:anjani → professor:heist-team
* app-logs/: anjani:anjani → berlin:heist-team

### Recursive Ownership

* heist-project/: anjani:anjani → professor:planners
* All files and subdirectories inherited the new ownership

### Practice Challenge

* access-codes.txt → tokyo:vault-team
* blueprints.pdf → berlin:tech-team
* escape-plan.txt → nairobi:vault-team

---

## Commands Used

### View Ownership

```bash
ls -l
ls -ld app-logs
```

### Create Files

```bash
touch devops-file.txt
touch team-notes.txt
touch project-config.yaml
```

### Create Groups

```bash
sudo groupadd heist-team
sudo groupadd planners
sudo groupadd vault-team
sudo groupadd tech-team
```

### Change Owner

```bash
sudo chown tokyo devops-file.txt
sudo chown berlin devops-file.txt
```

### Change Group

```bash
sudo chgrp heist-team team-notes.txt
```

### Change Owner & Group Together

```bash
sudo chown professor:heist-team project-config.yaml

mkdir app-logs

sudo chown berlin:heist-team app-logs
```

### Recursive Ownership

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

sudo chown -R professor:planners heist-project/
```

### Practice Challenge

```bash
mkdir bank-heist

touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt

sudo chown tokyo:vault-team bank-heist/access-codes.txt

sudo chown berlin:tech-team bank-heist/blueprints.pdf

sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

### Verification

```bash
ls -l devops-file.txt
ls -l team-notes.txt
ls -l project-config.yaml

ls -ld app-logs

ls -lR heist-project

ls -l bank-heist
```

---

## What I Learned

1. Every Linux file has an owner and a group that control access.
2. chown can change both owner and group in a single command.
3. Recursive ownership changes are useful when managing application directories and deployment files.

---

## Why This Matters in DevOps

* Managing application ownership during deployments
* Securing log and configuration files
* Handling shared team directories
* Managing CI/CD generated artifacts
* Working with container file permissions

