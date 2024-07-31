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

mkidr /data
mkfs.ext4 /dev/vdb1
sleep 1
pvcreate /dev/vdb2 /dev/vdb3
sleep 1
vgcreate pcteam /dev/vdb2 /dev/vdb3
sleep 1
lvcreate -n sysadmin -L 500M pcteam