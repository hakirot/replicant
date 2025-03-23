#!/bin/bash
set -eou pipefail

# Autologged in, clean up
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/

mv $HOME/.bash_profile.bak $HOME/.bash_profile
rm -f $HOME/configure.sh

# install/enable sshd (Packer test builds only)
sudo pacman -S openssh --noconfirm
sudo systemctl enable sshd
sudo systemctl start sshd

# Either run the entire config script 
# here or exit and let packer run

# replicate.sh
