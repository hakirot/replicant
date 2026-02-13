#!/bin/bash
set -eou pipefail

# Prompt for default username
#   Confirm

# TODO: Put this in curses. For fun.

#   |   > "Input a four-letter word [A-Z]"
#   |   > "Word not accepted."
#   |   > "Input a four-letter word [A-Z]"
#   |   > "Confirm [y/Y]"
#   |   > "Word accepted. The word is XXXX."
#   |
#   |     "Do not touch your system until you see this word again."

# Sleep 1

# Keep your hands off the system during execution
# You will know the system is ready when you see your word again

# There will need to be some checking to see if this is a live environment

# --SIM
curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/user_configuration.json
curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/user_credentials.json

archinstall --config user_configuration.json --creds user_credentials.json --silent

curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/autologin.conf
mkdir /mnt/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "username ALL=(ALL) NOPASSWD: ALL" > /mnt/etc/sudoers.d/00_username

curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/configure.sh
curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/replicate.sh
curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/replicant.sh
curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/sub.sh
mv configure.sh replicate.sh replicant.sh sub.sh /mnt/home/username/
cp /mnt/home/username/.bash_profile /mnt/home/username/.bash_profile.bak
echo "sudo chown username:username ./configure.sh replicate.sh replicant.sh sub.sh" >> /mnt/home/username/.bash_profile
echo "chmod +x /home/username/configure.sh replicate.sh replicant.sh sub.sh" >> /mnt/home/username/.bash_profile
echo "/home/username/configure.sh" >> /mnt/home/username/.bash_profile
shutdown -r now
