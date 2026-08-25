#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

echo -e "${GREEN}++REPLICANT.sh++${RESET}"

nohup notify-send --expire-time 1000 "Replicant" "Restoring .bash_profile .." &
echo -e "${GREEN}REPLICANT: Restoring .bash_profile${RESET}"
rm -f ${HOME}/.bash_profile
cp ${HOME}/.bash_profile.bak ${HOME}/.bash_profile

nohup notify-send --expire-time 1000 "Replicant" "Installing more packages .." &
echo -e "${GREEN}REPLICANT: Installing a whole lotta packages${RESET}"
yay --noconfirm -S \
  bottom \
  cava \
  dysk \
  fastfetch \
  ffmpegthumbnailer \
  figlet \
  figlet-fonts \
  figlet-fonts-extra \
  file \
  firefox \
  fuse2 \
  gnu-free-fonts \
  gzip \
  jq \
  libnotify \
  kitty \
  mpd \
  mpc \
  ncdu \
  nftables \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra \
  neovim \
  ntfs-3g \
  openssh \
  packer \
  polkit \
  ranger \
  ripgrep \
  rmpc \
  tldr \
  tmux \
  tmatrix \
  tree \
  ueberzugpp \
  vlc \
  wireplumber \
  xcolor \
  xsel \
  zathura \
  zathura-pdf-mupdf \
  zip

nohup notify-send --expire-time 1000 "Replicant" "Configuring RANGER .." &
echo -e "${GREEN}REPLICANT: Configuring RANGER${RESET}"
mkdir -p ${HOME}/.config/ranger
cd ${HOME}/git/suckless-hakirot/ranger
cp commands_full.py commands.py rifle.conf rc.conf scope.sh ${HOME}/.config/ranger/

nohup notify-send --expire-time 1000 "Replicant" "Configuring NEOVIM .." &
echo -e "${GREEN}REPLICANT: Configuring NEOVIM${RESET}"
cd ${HOME}
git clone https://github.com/hakirot/neovim-config.git
mv neovim-config ${HOME}/.config/nvim

nohup notify-send --expire-time 1000 "Replicant" "Removing autologin config .." &
echo -e "${GREEN}REPLICANT: Removing autologin config${RESET}"
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/

#echo -e "${GREEN}REPLICANT: Downgrading sudo perm{RESET}"
#sudo echo "${USER} ALL=(ALL) ALL" > /etc/sudoers.d/00_${USER}

nohup notify-send --expire-time 1000 "Replicant" "Installing TMUX config .." &
echo -e "${GREEN}REPLICANT: Installing TMUX config ..${RESET}"
cp ${HOME}/git/d07f1135/.tmux.conf ${HOME}

nohup notify-send --expire-time 1000 "Replicant" "Deploying final stage .." &
echo -e "${GREEN}REPLICANT: Deploying final stage ..${RESET}"
cd ${HOME}
nohup bash -c "./sub2.sh ${USER} > sub2.out 2>&1 &"

echo -e "${GREEN}REPLICANT: WAITING..${RESET}"
