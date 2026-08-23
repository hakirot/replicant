#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

USER=$1
USER_HOME=/mnt/home/${USER}

pacman -Sy
pacman -S --noconfirm archinstall archlinux-keyring

archinstall --config user_configuration.json --creds user_credentials.json --silent
echo -e "${GREEN}REPLICANT: ARCH LINUX INSTALLED.${RESET}"

echo -e "${GREEN}REPLICANT: Configuring autologin and permissions for ${USER} ..${RESET}"
mkdir /mnt/etc/systemd/system/getty@tty1.service.d/
mv autologin.conf /mnt/etc/systemd/system/getty@tty1.service.d/autologin.conf
echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /mnt/etc/sudoers.d/00_${USER}

echo -e "${GREEN}REPLICANT: Installing automated build files ..${RESET}"
mv replicate.sh replicant.sh sub.sh sub2.sh nftables.conf finalize.sh oh-my-zsh.sh /mnt/home/${USER}/
cp /mnt/home/${USER}/.bash_profile /mnt/home/${USER}/.bash_profile.bak
echo "sudo chown ${USER}:${USER} replicate.sh replicant.sh sub.sh sub2.sh nftables.conf oh-my-zsh.sh finalize.sh" >> ${USER_HOME}/.bash_profile
echo "chmod +x replicate.sh replicant.sh sub.sh sub2.sh oh-my-zsh.sh finalize.sh" >> ${USER_HOME}/.bash_profile
echo "source ./replicate.sh" >> ${USER_HOME}/.bash_profile

sleep 1
echo -e "${GREEN}REPLICANT: REBOOTING INTO ARCH..${RESET}"

seconds=6
while [ $seconds -gt 0 ]; do
  echo -e "${YELLOW}${seconds}${RESET}"
  sleep 1
  seconds=$((seconds - 1))
done
shutdown -r now
