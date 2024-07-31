#!/bin/bash
TGTDEV="/dev/vdb"
# Use a here document to pass commands to fdisk
sed -e 's/\s*\([+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
d
g
n
1

+150M
Y
n
2

+300M
t

lvm
n
3

+300M
t

lvm
p
w
EOF

mkdir /data
sleep 2
mkdir /mnt/pcteam-storage
sleep 2
mkfs.ext4 /dev/vdb1
sleep 2
pvcreate /dev/vdb2 /dev/vdb3
sleep 2
vgcreate pcteam /dev/vdb2 /dev/vdb3
sleep 2
lvcreate -n sysadmin -L 500M pcteam
sleep 2
mkfs.ext4 /dev/pcteam/sysadmin
sleep 2
echo "/dev/vdb1 /data ext4 defaults 0 0" >> /etc/fstab
sleep 2
echo "/dev/pcteam/sysadmin /mnt/pcteam-storage ext4 defaults 0 0" >> /etc/fstab
sleep 2

udevadm settle
systemctl daemon-reload
sleep 5
mount -a
