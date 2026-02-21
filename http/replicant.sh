#!/bin/bash
set -eou pipefail

USER=$1

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

echo -e "${GREEN}++REPLICANT.sh++${RESET}"

echo -e "${GREEN}Restoring .bash_profile${RESET}"
rm -f $HOME/.bash_profile
cp $HOME/.bash_profile.bak $HOME/.bash_profile

echo -e "${GREEN}Installing a whole lotta packages${RESET}"
yay --noconfirm -S \
  cava \
  discord \
  dunst \
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
  ripgrep \
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
  zip \
  zsh \
  zsh-syntax-highlighting

echo -e "${GREEN}Configuring ranger${RESET}"
mkdir -p $HOME/.config/ranger
cd $HOME/git/suckless-hakirot/ranger
cp commands_full.py commands.py rifle.conf rc.conf scope.sh $HOME/.config/ranger

echo -e "${GREEN}Configuring dunst${RESET}"
mkdir -p $HOME/.config/dunst
cd $HOME/git/suckless-hakirot/
cp dunstrc $HOME/.config/dunst

# firewall

# oh-my-zsh
# Grub?
# Rust and rust tools

# change SHELL
chsh -s /usr/bin/zsh ${USER}

# Installing Neovim config

# lualine patch (not patchable until lazy is run)
#   . /home/$USER/.local/share/nvim/lazy/lualine.nvim/lua/lualine/config.lua
#   | > theme = '16color',
#   | > section_separators = { left = '', right = '' },
#   . Install 16color.lua to /home/${USER}/.local/share/nvim/lazy/lualine.nvim/lua/lualine/themes/

# Remove autologin
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/

# Remove/rewrite sudo file for USER
sudo rm -f /etc/sudoers.d/00_${USER}
echo "${USER} ALL=(ALL) ALL" > /etc/sudoers.d/00_${USER}

rm -f $HOME/replicant.sh $HOME/replicate.sh
