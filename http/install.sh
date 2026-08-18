#!/bin/bash
set -eou pipefail

USER=$1
USER_HOME=/mnt/home/${USER}

pacman -Sy
pacman -S --noconfirm archinstall archlinux-keyring

archinstall --config user_configuration.json --creds user_credentials.json --silent

mkdir /mnt/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /mnt/etc/sudoers.d/00_${USER}

mv replicate.sh replicant.sh sub.sh sub2.sh nftables.conf finalize.sh oh-my-zsh.sh /mnt/home/${USER}/
cp /mnt/home/${USER}/.bash_profile /mnt/home/${USER}/.bash_profile.bak
echo "sudo chown ${USER}:${USER} replicate.sh replicant.sh sub.sh sub2.sh nftables.conf oh-my-zsh.sh finalize.sh" >> ${USER_HOME}/.bash_profile
echo "chmod +x replicate.sh replicant.sh sub.sh sub2.sh oh-my-zsh.sh finalize.sh" >> ${USER_HOME}/.bash_profile
echo "./replicate.sh" >> ${USER_HOME}/.bash_profile
shutdown -r now
