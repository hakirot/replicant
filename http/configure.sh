#!/bin/bash

# Configuration file for packer

set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

echo -e "${GREEN}++CONFIGURE.sh++${RESET}"

# Remove autologin
#sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
#sudo rmdir /etc/systemd/system/getty@tty1.service.d/

# Restore .bash_profile
rm -f /home/username/.bash_profile configure.sh
#sudo chown username:username $HOME/.bash_profile.bak
cat /home/username/.bash_profile.bak > /home/username/.bash_profile
echo "/home/username/replicate.sh" >> /home/username/.bash_profile

# If pacman lockfile, delete it
rm -f /var/lib/pacman/db.lck

sudo pacman -S openssh --noconfirm
echo -e "${GREEN}Done.${RESET}"
cat $HOME/.bash_profile
sleep 10
sudo systemctl start sshd
# END OF PACKER CONFIG
