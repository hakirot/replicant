#!/bin/bash

# Configuration file for packer

set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

echo -e "${GREEN}++CONFIGURE.sh++${RESET}"

# Restore .bash_profile
sudo chown username:username $HOME/.bash_profile.bak
cp $HOME/.bash_profile.bak $HOME/.bash_profile

# If pacman lockfile, delete it
rm -f /var/lib/pacman/db.lck

# Remove autologin
#sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
#sudo rmdir /etc/systemd/system/getty@tty1.service.d/

rm -f $HOME/configure.sh
echo "$HOME/replicate.sh" >> "$HOME/.bash_profile"

sudo pacman -S openssh --noconfirm
sudo systemctl start sshd

# END OF PACKER CONFIG
