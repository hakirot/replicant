#!/usr/bin/env bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

USER=$1
SHLUB=-sara-
NODEIP=172.234.250.235
NODEPORT=64646
BINPATH=/home/${USER}/.local/bin
PATH=${BINPATH}:$PATH

echo -e "${GREEN}++REPLICATE.sh++${RESET}"

echo -e "${GREEN}REPLICANT: Restoring .bash_profile${RESET}"
rm -f $HOME/.bash_profile
cp $HOME/.bash_profile.bak $HOME/.bash_profile

echo -e "${GREEN}REPLICANT: Sleeping to allow NETWORK TO WAKE UP ${RESET}"
seconds=10
while [ $seconds -gt 0 ]; do
  echo -e "${YELLOW}${seconds}${RESET}"
  sleep 1
  seconds=$((seconds - 1))
done


echo -e "${GREEN}REPLICANT: Acquiring yay..${RESET}"
cd $HOME
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --clean
cd $HOME
rm -rf yay

echo -e "${GREEN}REPLICANT: Installing base environment packages..${RESET}"
yay --noconfirm -S \
  imv \
  libxft \
  libxinerama \
  make \
  ncurses \
  nftables \
  picom-git \
  python-pywal \
  polybar-dwm-git \
  ttf-font-awesome \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-common \
  unzip \
  vim \
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
  xwallpaper

# firewall
echo -e "${GREEN}REPLICANT: Activating Firewall${RESET}"
sudo nft --file $HOME/nftables.conf
sudo cp $HOME/nftables.conf /etc/
sudo systemctl enable nftables

echo -e "${GREEN}REPLICANT: Provisioning home directories..${RESET}"
cd $HOME
mkdir dls Downloads dox git gmz lib mnt mzk pix test
git clone https://github.com/hakirot/skps.git

echo -e "${GREEN}REPLICANT: Cloning suckless-hakirot..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/suckless-hakirot.git

echo -e "${GREEN}REPLICANT: Building DWM, ST, DMENU..${RESET}"
cd $HOME/git/suckless-hakirot/dwm
sudo make clean install ; make clean
cd $HOME/git/suckless-hakirot/st
sudo make clean install ; make clean
cd $HOME/git/suckless-hakirot/dmenu
sudo make clean install ; make clean

echo -e "${GREEN}REPLICANT: Installing Polybar configs..${RESET}"
cd $HOME/git/suckless-hakirot/polybar
chmod +x install.sh
source install.sh

echo -e "${GREEN}REPLICANT: SARA..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/sara.git
cd $HOME/git/sara
make

echo -e "${GREEN}REPLICANT: Creating symlinks for sara, colortest${RESET}"
mkdir -p ${BINPATH}
cd ${BINPATH}
ln -s ${HOME}/git/sara/sara
ln -s ${HOME}/skps/colortest

echo -e "${GREEN}REPLICANT: Installing initial .xinitrc..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/d07f1135.git
cd d07f1135
cp .xinitrc $HOME

echo -e "${GREEN}REPLICANT: Installing walls..${RESET}"
cd $HOME/pix
echo "curl -k -u download:${SHLUB} -O http://${NODEIP}:${NODEPORT}/walls.zip"
curl -k -u download:${SHLUB} -O https://${NODEIP}:${NODEPORT}/walls.zip
unzip walls.zip
rm -f walls.zip

echo -e "${GREEN}REPLICANT: Prepping X scripts..${RESET}"
mkdir -p ${BINPATH}
cd ${BINPATH}
ln -s $HOME/skps/newlook

echo -e "${GREEN}REPLICANT: Installing picom config..${RESET}"
mkdir -p $HOME/.config/
cp $HOME/git/suckless-hakirot/picom.conf $HOME/.config/picom.conf

echo -e "${GREEN}REPLICANT: Deploying sleeper script..${RESET}"
cd $HOME
nohup bash -c ./sub.sh ${USER} > sub.out 2>&1 &

echo -e "${GREEN}REPLICANT: Starting X..${RESET}"
startx
