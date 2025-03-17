#!/bin/bash
set -eou pipefail

# Reset autologin
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/

# install/enable sshd
sudo pacman -S openssh --no-confirm
sudo systemctl enable sshd
sudo systemctl start sshd

mv $HOME/.bash_profile.bak $HOME/.bash_profile
rm -f $HOME/configure.sh
logout
