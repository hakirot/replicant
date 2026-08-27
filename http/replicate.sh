#!/usr/bin/env bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

USR=91a4c72a
PW=93930bedb
NODEIP=172.234.250.235
NODEPORT=64646
BINPATH=/home/${USER}/.local/bin
PATH=${BINPATH}:$PATH

echo -e "${GREEN}++REPLICATE.sh++${RESET}"

echo -e "${GREEN}REPLICANT: Restoring .bash_profile${RESET}"
rm -f $HOME/.bash_profile
cp $HOME/.bash_profile.bak $HOME/.bash_profile

echo -e "${GREEN}REPLICANT: 10 Second delay to restore NETWORK${RESET}"
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
  cairo \
  dunst \
  gdk-pixbuf2 \
  glib2 \
  imv \
  libnotify \
  libxft \
  libxinerama \
  make \
  ncurses \
  networkmanager \
  nftables \
  pango \
  picom \
  python-pywal \
  polybar-dwm-git \
  ttf-font-awesome \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-common \
  unzip \
  vim \
  wget \
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
  zsh \
  zsh-syntax-highlighting

# firewall
echo -e "${GREEN}REPLICANT: Activating NetworkManager${RESET}"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

echo -e "${GREEN}REPLICANT: Activating Firewall${RESET}"
sudo nft --file $HOME/nftables.conf
sudo cp $HOME/nftables.conf /etc/
sudo systemctl enable nftables
sudo systemctl start nftables

echo -e "${GREEN}REPLICANT: Provisioning home directories..${RESET}"
cd $HOME
mkdir dls Downloads dox git gmz lib mnt mzk pix
git clone https://github.com/hakirot/skps.git

echo -e "${GREEN}REPLICANT: Cloning suckless-hakirot..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/suckless-hakirot.git
mv suckless-hakirot suckless

echo -e "${GREEN}REPLICANT: Building DWM, ST, DMENU..${RESET}"
cd $HOME/git/suckless/dwm
sudo make clean install ; make clean
cd $HOME/git/suckless/st
sudo make clean install ; make clean
cd $HOME/git/suckless/dmenu
sudo make clean install ; make clean

echo -e "${GREEN}REPLICANT: Installing Polybar configs..${RESET}"
cd $HOME/git/suckless/polybar
chmod +x install.sh
source install.sh

echo -e "${GREEN}REPLICANT: Installing SARA..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/sara.git
cd $HOME/git/sara
make
mkdir -p $HOME/.config/sara

echo "$HOME/.config" > $HOME/.config/sara/pshd
echo "$HOME/pix/walls" >> $HOME/.config/sara/pshd
echo "$HOME/skps/custom_walz" >> $HOME/.config/sara/pshd
echo "$HOME/git/sara" >> $HOME/.config/sara/pshd
echo "$HOME/git/suckless" >> $HOME/.config/sara/pshd
echo "$HOME/git/d07f1135" >> $HOME/.config/sara/pshd
echo "$HOME/.local/bin" >> $HOME/.config/sara/pshd

echo -e "${GREEN}REPLICANT: Configuring dunst${RESET}"
mkdir -p ${HOME}/.config/dunst
cd ${HOME}/.config/dunst
ln -s ${HOME}/git/suckless/dunst/dunstrc

echo -e "${GREEN}REPLICANT: Creating symlinks for local bin${RESET}"
mkdir -p ${BINPATH}
cd ${BINPATH}
ln -s ${HOME}/git/sara/sara
ln -s ${HOME}/skps/colortest
ln -s ${HOME}/skps/dunst_restart.sh
ln -s ${HOME}/skps/song-notify.sh
ln -s ${HOME}/skps/wifi
ln -s ${HOME}/skps/respawn.sh
ln -s ${HOME}/skps/kill-session.sh ${HOME}/.local/bin/kill-session
ln -s ${HOME}/skps/reskin
sed -i "s|suckess-hakirot|suckless|g" reskin
ln -s ${HOME}/skps/sudo_askpass

echo -e "${GREEN}REPLICANT: Installing initial .xinitrc..${RESET}"
cd $HOME/git
git clone https://github.com/hakirot/d07f1135.git
cd d07f1135
cp .xinitrc $HOME

echo -e "${GREEN}REPLICANT: Fetching wallpapers..${RESET}"
cd $HOME/pix
mkdir walls
cd walls
echo "curl -k -u download:${PW} -O https://${NODEIP}:${NODEPORT}/walls.zip"
curl -k -u ${USR}:${PW} -O https://${NODEIP}:${NODEPORT}/walls.zip
unzip walls.zip
rm -f walls.zip

echo -e "${GREEN}REPLICANT: Installing picom config..${RESET}"
mkdir -p $HOME/.config/
cd $HOME/.config/
ln -s $HOME/git/suckless/picom.conf

echo -e "${GREEN}REPLICANT: Deploying sleeper script..${RESET}"
cd $HOME

echo -e "${GREEN}REPLICANT: Changing SHELL${RESET}"
sudo chsh --shell /bin/zsh ${USER}

echo -e "${GREEN}Preparing to switch to graphical environment..${RESET}"
sed -i "/reskin/c\~\/.local\/bin\/reskin\ ~/pix/walls/walls/please_wait.png &" ${HOME}/.xinitrc
sleep 1
touch logout.sh
echo "#\!/usr/bin/env bash" > logout.sh
sleep 1
echo "logout" > logout.sh
sleep 1
chmod +x logout.sh

sleep 1
echo "rm -f .zshrc" >> .zshrc
sleep 1
echo "sleep 1" >> .zshrc
sleep 1
echo "nohup bash -c \"./sub.sh ${USER} > sub.out 2>&1 &\"" >> .zshrc
sleep 1
echo "sleep 1" >> .zshrc
sleep 1
echo "startx" >> .zshrc

echo -e "${GREEN}REPLICANT: GET READY ..${RESET}"
sleep 1
echo -e "${RED}HANDS OFF !!${RESET}"

seconds=5
while [ $seconds -gt 0 ]; do
  echo -e "${YELLOW}${seconds}${RESET}"
  sleep 1
  seconds=$((seconds - 1))
done

source logout.sh
