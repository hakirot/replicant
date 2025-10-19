#!/bin/bash
set -eou pipefail

# Remove autologin
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/

# Restore .bash_profile
mv $HOME/.bash_profile.bak $HOME/.bash_profile
rm -f $HOME/configure.sh

# If pacman lockfile, delete it
rm -f /var/lib/pacman/db.lck

# install/enable sshd (Packer test builds only, for live, will remote in from site)
sudo pacman -S openssh --noconfirm
sudo systemctl enable sshd
sudo systemctl start sshd

# Either run the entire config script 
# here or exit and let packer run

# xinit
# xrandr (interactive xrandr?)
# yay
# firewall
# speedrun desktop env with suckless project mods
# grab walls.zip and install
# sara dynamic config (?)
# Neovim
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
# Grub?
# Rust and rust tools

# (launch dwm last)

# startx
# launch st
# replicate.sh
