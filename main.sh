#!/bin/bash
echo "START"
sleep 1

function No1 () {
echo -e "No.1"
hostnamectl hostname machine1.pcteam.id
hostname
sleep 2
echo "DONE"
}

echo ""
sleep 1

function No2 () {
echo -e "No2"

for i in {kelvin,ruben}; do

	useradd  -m -s /bin/bash -p sysadmin -G pcteam $i
done
usermod -u 1999 ruben
useradd -m -s /sbin/nologin -p sysadmin fathur
echo "DONE"
}

echo ""
sleep 1

function No3 () {
echo "No. 3"
dir=/shared/pcteam
mkdir -p $dir
chown :pcteam $dir
chmod g+s $dir
chmod 770 $dir
ls -ld /shared/pcteam
echo "DONE"
}

echo ""
sleep 1

function No4 () {

echo "No.4"
echo "%pcteam ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pcteam
sleep 2
echo "DONE"
}

echo ""

function No5 () {

echo "No.5"
su - kelvin "
touch /shared/pcteam/lontong
"
ls -l /shared/pcteam
sleep 2
}

echo ""

function No6 () {
echo "No. 6"
echo "server time.cloudflare.com iburst" >> /etc/chrony/chrony.conf
systemctl restart chrony
sleep 15
chronyc sources
sleep 2
echo "DONE"
}

function No7 () {
echo ""
echo "No. 6"
touch search.txt
grep /bin/bash /etc/passwd > search.txt
sleep 2

find /usr/share -type f -iname *.txt -exec tar -czf /root/archive.tar.gz {} 2> /dev/null \;
sleep 7
echo "DONE"
}

function No8 () {
rm -rf /lib/systemd/system/nfs-common.service
sleep 5
systemctl enable --now nfs-common
systemctl start nfs-common
echo "/- /etc/auto.cyber-ranger" > /etc/auto.master.d/cyber-ranger.autofs
echo "/mnt/pcteam -rw,sync,fstype=nfs 192.168.100.10:/mnt/pcteam" > /etc/auto.cyber-ranger
systemctl restart autofs
echo "please Create the file if the directory not exist"
echo "DONE"
}

echo ""
sleep 2

echo "Finish"