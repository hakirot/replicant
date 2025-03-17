#!/bin/bash
set -eou pipefail

curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/user_configuration.json
curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/user_credentials.json
archinstall --config user_configuration.json --creds user_credentials.json --silent

curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/autologin.conf
mkdir /mnt/archinstall/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/archinstall/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "username ALL=(ALL) NOPASSWD: ALL" > /mnt/archinstall/etc/sudoers.d/00_username

curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/configure.sh
mv configure.sh /mnt/archinstall/home/username/
cp /mnt/archinstall/home/username/.bash_profile /mnt/archinstall/home/username/.bash_profile.bak
echo "sudo chown username:username ./configure.sh" >> /mnt/archinstall/home/username/.bash_profile
echo "chmod +x /home/username/configure.sh" >> /mnt/archinstall/home/username/.bash_profile
echo "/home/username/configure.sh" >> /mnt/archinstall/home/username/.bash_profile
shutdown now -r
