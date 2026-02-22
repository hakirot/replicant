#!/bin/bash
set -eou pipefail

USER=$1
USER_HOME=/mnt/home/${USER}

# Set user information from arg

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

# if [--SIM]; do
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/user_configuration.json
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/user_credentials.json
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/autologin.conf
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/configure.sh
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/replicate.sh
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/replicant.sh
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/sub.sh
#curl -O $PACKER_HTTP_IP:$PACKER_HTTP_PORT/sub2.sh

pacman -Sy
pacman -S --noconfirm archinstall archlinux-keyring

archinstall --config user_configuration.json --creds user_credentials.json --silent

mkdir /mnt/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /mnt/etc/sudoers.d/00_${USER}

mv replicate.sh replicant.sh sub.sh sub2.sh nftables.conf /mnt/home/${USER}/
cp /mnt/home/${USER}/.bash_profile /mnt/home/${USER}/.bash_profile.bak
echo "sudo chown ${USER}:${USER} replicate.sh replicant.sh sub.sh sub2.sh nftables.conf oh-my-zsh.sh" >> ${USER_HOME}/.bash_profile
echo "chmod +x replicate.sh replicant.sh sub.sh sub2.sh oh-my-zsh.sh" >> ${USER_HOME}/.bash_profile
echo "./replicate.sh ${USER}" >> ${USER_HOME}/.bash_profile
shutdown -r now
