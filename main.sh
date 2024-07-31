#!/bin/bash
apt install sudo -y

sleep 30
echo "START"
sleep 1

function No1 () {
echo -e "No.1"
hostnamectl hostname machine1.pcteam.id
hostname
sleep 2
echo "DONE"
}

function No2 () {
echo -e "No2"

for i in {kelvin,ruben}; do

	useradd  -m -s /bin/bash -p sysadmin -G pcteam $i
done
usermod -u 1999 ruben
useradd -m -s /sbin/nologin -p sysadmin fathur
echo "DONE"
}

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

function No4 () {

echo "No.4"
echo "%pcteam ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pcteam
sleep 2
echo "DONE"
}

function No5 () {

echo "No.5"
su - kelvin "
touch /shared/pcteam/lontong
"
ls -l /shared/pcteam
sleep 2
}

function No6 () {
echo "No. 6"
echo "server time.cloudflare.com iburst" >> /etc/chrony/chrony.conf
sed -i 's/pool 2.debian.pool.ntp.org iburst/#pool 2.debian.pool.ntp.org iburst/g' filename
systemctl restart chrony
systemctl restart chronyd
sleep 15
systemctl restart chrony
chronyc sources
sleep 2
echo "DONE"
}

function No7 () {
echo ""
echo "No. 7"
touch search.txt
grep /bin/bash /etc/passwd > search.txt
sleep 2

find /usr/share -type f -iname "*.txt" -exec tar -czf /root/archive.tar.gz {} 2> /dev/null \;
sleep 7
echo "DONE"
}

function No8 () {
rm -rf /lib/systemd/system/nfs-common.service
sleep 5
systemctl enable --now nfs-common
systemctl start nfs-common
echo "/- /etc/auto.cyber-ranger" > /etc/auto.master.d/cyber-ranger.autofs
echo "/mnt/pcteam -rw,sync,fstype=nfs4 192.168.100.10:/mnt/pcteam" > /etc/auto.cyber-ranger
systemctl restart autofs
usermod -p sysadmin cyber-ranger
echo "please Create the file if the directory not exist"
echo "DONE"
}

function Docker () {
mkdir /opt/pcteamwebapp/templates
cat << EOF > /opt/pcteamwebapp/main.py
from flask import Flask
from flask import request
from flask import render_template
sample = Flask(__name__)
@sample.route("/")
def main():
	return render_template("index.html", hostname=request.remote_addr)
if __name__ == "__main__":
	sample.run(host="0.0.0.0", port=8080, debug=False)
EOF

cat << EOF > /opt/pcteamwebapp/templates/index.html
<html>
<head>
	<title>PCTeam WebAPP</title>
</head>
<body>
	<h1>You are calling me from {{hostname}}</h1>
</body>
</html>
EOF

cd /opt/pcteamwebapp
docker build . -t pcteam:latest
sleep 60
docker container rm pcteamwebapp
sleep 60
docker docker run -d -p 80:8080 --name pcteamwebapp --restart always pcteam:latest
sleep 60
docker tag pcteam:latest localhost:5000/pcteam:2.0
sleep 60
docker push localhost:5000/pcteam:2.0
sleep 60
}

echo ""
sleep 2

No1
sleep 5
No2
sleep 5
No3
sleep 5
No4
sleep 5
No5
sleep 5
No6
sleep 5
No7
sleep 5
No8
sleep 5
Docker
echo "Finish"

cat << EOF
su - cyber-ranger
touch fieshare
exit
EOF

echo "Need check NO. 9, crontab, and create file in cyber-ranger"
