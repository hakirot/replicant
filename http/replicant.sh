#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

echo -e "${GREEN}++REPLICANT.sh++${RESET}"

echo -e "${GREEN}Restoring .bash_profile${RESET}"
rm -f $HOME/.bash_profile
cp $HOME/.bash_profile.bak $HOME/.bash_profile

yay --noconfirm -S \
  cava \
  discord \
  fastfetch \
  figlet \
  figlet-fonts \
  figlet-fonts-extra \
  file \
  firefox \
  gzip \
  heroku-cli-bin \
  inotify-tools \
  jq \
  kitty \
  mpd \
  nftables \
  nodejs \
  nodejs-nodemon \
  neovim \
  packer \
  polychromatic \
  ranger \
  rmpc \
  rtorrent \
  ticker \
  tldr \
  termdown \
  tmux \
  tmatrix \
  ueberzugpp \
  vlc \
  wireplumber \
  xcolor \
  xsel \
  zathura \
  zathura-pdf-mupdf \
  yt-dlp \
  zsh \
  zip

# ranger
# dunstrc

# firewall

# oh-my-zsh
# yay -S zsh-syntax-highlighting
# Grub?
# Rust and rust tools

# change SHELL

# Installing Neovim config

# lualine patch (not patchable until lazy is run)
#   . /home/$USER/.local/share/nvim/lazy/lualine.nvim/lua/lualine/config.lua
#   | > theme = '16color',
#   | > section_separators = { left = '', right = '' },
#   . Install 16color.lua to /home/username/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes/

# Remove autologin
#sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
#sudo rmdir /etc/systemd/system/getty@tty1.service.d/

# Remove/rewrite sudo file for username
# sudo rm -f /etc/sudoers.d/00_username
# echo "username ALL=(ALL) ALL" > /etc/sudoers.d/00_username

#rm -f $HOME/replicant.sh $HOME/replicate.sh

# --SIM
#sudo systemctl start sshd
