#!/bin/bash
set -eou pipefail

# Autologged in, clean up
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/

mv $HOME/.bash_profile.bak $HOME/.bash_profile
rm -f $HOME/configure.sh

# Remove pacman lockfile if it exists
rm -f /var/lib/pacman/db.lck

# install/enable sshd (Packer test builds only)
sudo pacman -S openssh --noconfirm
sudo systemctl enable sshd
sudo systemctl start sshd

# Either run the entire config script 
# here or exit and let packer run

# yay
# firewall
# speedrun desktop env with suckess project mods
# grab walls.zip and install
# sara dynamic config
# lualine patch (not patchable until lazy is run)
#   . /home/$USER/.local/share/nvim/lazy/lualine.nvim/lua/lualine/config.lua
#   | > theme = '16color',
#   | > section_separators = { left = '', right = '' },
#   . Install 16color.lua to /home/username/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes/
# oh-my-zsh
# backupConfs
# polybar
# skps
#   - inotifytools

# launch dwm last
# replicate.sh
