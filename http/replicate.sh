#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'
SHLUB=-sara-
NODEIP=172.234.250.235
NODEPORT=64646
BINPATH=/home/username/.local/bin
PATH=${BINPATH}:$PATH

# --- Live.sh
#curl www.cachecoyotes.com/replicant/sara.zip
#unzip sara.zip
#chmod -x replicate.sh
#./replicate.sh

#archinstall --config user_configuration.json --creds user_credentials.json --silent

echo -e "${GREEN}++REPLICATE.sh++${RESET}"

echo -e "${GREEN}Building yay..${RESET}"
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --clean
cd ../
rm -rf yay

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
  xdotool \
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
  make \
  ncurses \
  dunst \
  tmux \
  vim \
  neovim \
  unzip \
  zsh

echo -e "${GREEN}REPLICANT: Provisioning home directories..${RESET}"
mkdir dls Downloads dox git gmz go lib mnt mzk pix test
git clone https://github.com/hakirot/skps.git

echo -e "${GREEN}REPLICANT: Cloning suckless-hakirot/SARA repos..${RESET}"
cd git
git clone https://github.com/hakirot/suckless-hakirot.git

echo -e "${GREEN}REPLICANT: Building DWM, ST, DMENU..${RESET}"
cd suckless-hakirot
cd dwm
sudo make clean install ; make clean
cd ../st
sudo make clean install ; make clean
cd ../dmenu
sudo make clean install ; make clean

echo -e "${GREEN}REPLICANT: Installing Polybar configs..${RESET}"
cd $HOME/git/suckless-hakirot/polybar
chmod +x install.sh
source install.sh

echo -e "${GREEN}REPLICANT: Cloning SARA..${RESET}"
cd git
git clone https://github.com/hakirot/sara.git

echo -e "${GREEN}REPLICANT: Building SARA..${RESET}"
cd $HOME/git/sara
make

echo -e "${GREEN}REPLICANT: Installing SARA configs..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/d07f1135.git
cd d07f1135
cp .tmux.conf .xinitrc $HOME

echo -e "${GREEN}REPLICANT: Fetching walls..${RESET}"
cd $HOME/pix
echo "curl -k -u download:${SHLUB} -O http://${NODEIP}:${NODEPORT}/walls.zip"
curl -k -u download:${SHLUB} -O https://${NODEIP}:${NODEPORT}/walls.zip
unzip walls.zip
rm -f walls.zip

echo -e "${GREEN}REPLICANT: Prepping X scripts..${RESET}"
mkdir -p ${BINPATH}
cd ${BINPATH}
ln -s $HOME/skps/newlook
#nohup bash -c 'sleep 10; xdotool key super+space' > /dev/null 2>&1 &
#startx

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
# yay -S zsh-syntax-highlighting
# backupConfs
# Grub?
# Rust and rust tools

# (launch dwm last)

# startx
# launch st

# configure neovim (run Lazy inside the editor somehow)
#   exit
# Compile SARA
# Edit sara into zsh
# Run sara

# --SIM
#sudo systemctl start sshd
