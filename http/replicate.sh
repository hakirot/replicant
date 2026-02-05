#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# --- Live.sh
#curl www.cachecoyotes.com/replicant/sara.zip
#unzip sara.zip
#chmod -x replicate.sh
#./replicate.sh

#archinstall --config user_configuration.json --creds user_credentials.json --silent

echo -e "${GREEN}++REPLICATE.sh++${RESET}"

echo -e "${GREEN}yay..${RESET}"
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --clean
cd ../

echo -e "${GREEN}Installing base packages..${RESET}"
yay --noconfirm -S \
  polybar-dwm-git \
  xorg-server \
  xorg-xrandr \
  xwallpaper \
  libxft \
  libxinerama \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-common \
  picom-git \
  python-pywal \
  xdotool \
  zsh

# xinit
# xrandr (interactive xrandr?)
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

# configure neovim (run Lazy inside the editor somehow)
#   exit
# Compile SARA
# Edit sara into zsh
# Run sara

# --SIM
#sudo systemctl start sshd
