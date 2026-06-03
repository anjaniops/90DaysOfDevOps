# Day 13 – Linux Volume Management (LVM)

## Objective

Learned the fundamentals of Linux Volume Management (LVM) and how it provides flexible storage management compared to traditional disk partitioning.

---

## Commands Used

### Check Current Storage

```bash
lsblk
pvs
vgs
lvs
df -h
```

### Create Physical Volume

```bash
pvcreate /dev/sdb
pvs
```

### Create Volume Group

```bash
vgcreate devops-vg /dev/sdb
vgs
```

### Create Logical Volume

```bash
lvcreate -L 500M -n app-data devops-vg
lvs
```

### Format and Mount

```bash
mkfs.ext4 /dev/devops-vg/app-data

mkdir -p /mnt/app-data

mount /dev/devops-vg/app-data /mnt/app-data

df -h /mnt/app-data
```

### Extend Logical Volume

```bash
lvextend -L +200M /dev/devops-vg/app-data

resize2fs /dev/devops-vg/app-data

df -h /mnt/app-data
```

---

## Verification

```bash
pvs
vgs
lvs
df -h
```

---

## What I Learned

1. LVM provides flexible storage management by abstracting physical storage into logical volumes.
2. Storage can be extended without repartitioning disks, making capacity management easier.
3. Physical Volumes (PV), Volume Groups (VG), and Logical Volumes (LV) work together to provide scalable storage.

---

## Key Takeaway

LVM is widely used in Linux servers because it allows administrators to resize storage dynamically and manage disk space more efficiently.

---

## Screenshots

* lsblk output
* pvs, vgs, lvs output
* Mounted filesystem output
* Volume extension output

