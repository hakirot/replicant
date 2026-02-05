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

echo -e "${GREEN}REPLICANT: Installing base packages..${RESET}"
yay --noconfirm -S \
  polybar-dwm-git \
  xorg-fonts-encodings \
  xorg-server \
  xorg-server-common \
  xorg-setxkbmap \
  xorg-xauth \
  xorg-xev \
  xorg-xinit \
  xorg-xkbcomp \
  xorg-xmodmap \
  xorg-xprop \
  xorg-xrandr \
  xorg-xrdb \
  xorg-xset \
  xorgproto \
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

echo -e "${GREEN}REPLICANT: Provisioning home directories..${RESET}"
mkdir dls Downloads dox git gmz go lib mnt mzk pix skps test

echo -e "${GREEN}REPLICANT: Cloning SARA projects..${RESET}"
cd git
git clone https://github.com/hakirot/suckless-hakirot.git
git clone https://github.com/hakirot/sara.git

echo -e "${GREEN}REPLICANT: Installing SARA configs..${RESET}"
cd git
git clone https://github.com/hakirot/d07f1135.git

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
