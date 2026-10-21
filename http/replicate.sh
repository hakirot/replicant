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

if [ -z ${CONTROL_PIPE+x} ] ; then
  CONTROL_PIPE="/tmp/load_pipe"
fi

endbar() {
  flashes=9
  while [ $flashes -gt 0 ]; do
    echo "0" > $CONTROL_PIPE
    sleep .05
    echo "100" > $CONTROL_PIPE
    sleep .05
    flashes=$((flashes - 1))
  done
  sleep .5
  while pgrep loading-bar >/dev/null ; do
    echo "PIPE_END" > $CONTROL_PIPE
    echo "Still Running"
    sleep .25
  done
  rm -f ${CONTROL_PIPE}
  touch ${HOME}/replicant_completed
}

echo "Replicant.sh installs and preps lightweight desktop environment" | tee -a ${CONTROL_PIPE}
echo "1" > ${CONTROL_PIPE}

echo "Awaiting for network restoration .." > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Short delay for NETWORK to reawaken${RESET}"

attempts=10
until ping -c 1 google.com
do
  echo "Failed to connect to network"
  echo "${attempts} attempts remaining"
  sleep 2
  attempts=$((attempts - 1))
done

if [ "$attempts" -eq "0" ]; then
  echo "-CRIT: REPLICANT: No network connection. Configure internet connection then retry by pressing Control+d" > ${CONTROL_PIPE}
  exit
fi
echo "Network Restored" | tee -a ${CONTROL_PIPE}
echo "5" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Restoring .bash_profile${RESET}" | tee -a ${CONTROL_PIPE}
echo "5" > ${CONTROL_PIPE}
rm -f $HOME/.bash_profile
cp $HOME/.bash_profile.bak $HOME/.bash_profile
echo "Bash profile restored" > ${CONTROL_PIPE}
echo "6" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Acquiring yay ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --clean
cd $HOME
rm -rf yay
echo "15" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Installing base environment packages (xorg packages, fonts, zsh, vim, etc)${RESET}" | tee -a  ${CONTROL_PIPE} 
yay --noconfirm -S \
  cairo            \
  dunst            \
  gdk-pixbuf2      \
  glib2            \
  imv              \
  libnotify        \
  libxft           \
  libxinerama      \
  linux-headers    \
  make             \
  ncurses          \
  networkmanager   \
  nftables         \
  pango            \
  perl-image-exiftool \
  picom            \
  python-pywal16   \
  polybar-dwm-git  \
  ranger           \
  tmux             \
  ttf-font-awesome \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-common \
  unzip            \
  vim              \
  wget             \
  xorg-fonts-encodings \
  xorg-server      \
  xorg-server-common \
  xorg-setxkbmap   \
  xorg-xauth       \
  xorg-xev         \
  xorg-xinit       \
  xorg-xkbcomp     \
  xorg-xmodmap     \
  xorg-xprop       \
  xorg-xrandr      \
  xorg-xrdb        \
  xorg-xset        \
  xorgproto        \
  xdotool          \
  xwallpaper       \
  zsh              \
  zsh-syntax-highlighting
echo "60" > ${CONTROL_PIPE}

# firewall
echo -e "${GREEN}REPLICANT: Activating NetworkManager${RESET}" | tee -a ${CONTROL_PIPE}
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
echo "65" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Activating Firewall${RESET}" | tee -a ${CONTROL_PIPE}
echo "Activating your firewall" > ${CONTROL_PIPE}
sudo nft --file $HOME/nftables.conf
sudo cp $HOME/nftables.conf /etc/
sudo systemctl enable nftables
sudo systemctl start nftables
echo "70" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Creating home directories ..${RESET}" | tee -a ${CONTROL_PIPE}
cd ${HOME}
mkdir dls Downloads dox git gmz lib mnt mzk pix
git clone https://github.com/hakirot/skps.git
sed -i "s|suckless-hakirot|suckless|g" ${HOME}/skps/reskin
echo "75" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Cloning suckless-hakirot ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME/git
git clone https://github.com/hakirot/suckless-hakirot.git
mv suckless-hakirot suckless
echo "79" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Building DWM, ST, DMENU ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME/git/suckless/dwm
sudo make clean install ; make clean
cd $HOME/git/suckless/st
sudo make clean install ; make clean
cd $HOME/git/suckless/dmenu
sudo make clean install ; make clean
echo "82" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Installing SARA ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME/git
curl -O https://www.hakipaks.org/sara/sara-latest.tar.gz
curl -O https://www.hakipaks.org/sara/sara-latest.tar.gz.sig
gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv 5E0041A715B872CDE3B2CE3365BDF6CF53412D61
gpg --verify sara-latest.tar.gz.sig sara-latest.tar.gz
tar -xf sara-latest.tar.gz
rm -rf sara-latest.tar.gz sara-latest.tar.gz.sig
mv sara* sara
cd sara
mkdir -p ${BINPATH}
make &> log
mkdir -p $HOME/.config/sara
echo "84" > ${CONTROL_PIPE}

echo "Creating SARA shortcuts" | tee -a ${CONTROL_PIPE}
echo "$HOME/.local/bin" > $HOME/.config/sara/pshd
echo "$HOME/.config" >> $HOME/.config/sara/pshd
echo "$HOME/pix/walls" >> $HOME/.config/sara/pshd
echo "$HOME/skps/themes" >> $HOME/.config/sara/pshd
echo "$HOME/git/suckless" >> $HOME/.config/sara/pshd
echo "$HOME/git/d07f1135" >> $HOME/.config/sara/pshd
echo "$HOME/git/sara" >> $HOME/.config/sara/pshd
echo "87" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Configuring dunst${RESET}" | tee -a ${CONTROL_PIPE}
mkdir -p ${HOME}/.config/dunst
cd ${HOME}/.config/dunst
ln -s ${HOME}/git/suckless/dunst/dunstrc
echo "89" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Creating symlinks for local bin${RESET}" | tee -a ${CONTROL_PIPE}
cd ${BINPATH}
ln -s ${HOME}/git/sara/sara
ln -s ${HOME}/skps/colortest
ln -s ${HOME}/skps/dunst_restart
ln -s ${HOME}/skps/song-notify.sh
ln -s ${HOME}/skps/wifi
ln -s ${HOME}/skps/respawn.sh
ln -s ${HOME}/skps/kill-session.sh ${HOME}/.local/bin/kill-session
ln -s ${HOME}/skps/reskin
ln -s ${HOME}/skps/sudo_askpass
echo "91" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Installing initial .xinitrc ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME/git
git clone https://github.com/hakirot/d07f1135.git
cd d07f1135
cp .xinitrc $HOME
echo "92" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Fetching wallpapers and themes ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME/pix
curl -k -u ${USR}:${PW} -O https://${NODEIP}:${NODEPORT}/walls.zip
unzip walls.zip
rm -rf $HOME/skps/themes
mv themes $HOME/skps/themes
rm -f walls.zip
echo "93" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Installing picom config ..${RESET}" | tee -a ${CONTROL_PIPE}
mkdir -p $HOME/.config/
cd $HOME/.config/
ln -s $HOME/git/suckless/picom.conf
echo "94" > ${CONTROL_PIPE}

#GPU_INSTALL=0
#lspci | grep -i nvidia && GPU_INSTALL=1
#if [ $GPU_INSTALL -eq 1 ]; then
#  echo -e "${GREEN}REPLICANT: NVIDIA GPU DETECTED..${RESET}"
#  echo -e "${GREEN}REPLICANT: INSTALLING NVIDIA DRIVERS..${RESET}"
#
#  yay --noconfirm -S \
#    nvidia-open-dkms \
#    nvidia-settings  \
#    nvidia-utils
#fi
#
#lspci | grep -i amd && GPU_INSTALL=2
#if [ GPU_INSTALL -eq 2 ]; then
#  echo "implement AMD"
#  GPU_INSTALL=1
#fi

echo -e "${GREEN}REPLICANT: Changing SHELL${RESET}" | tee -a ${CONTROL_PIPE}
sudo chsh --shell /bin/zsh ${USER}
echo "95" > ${CONTROL_PIPE}

echo -e "${GREEN}Preparing to switch to graphical environment ..${RESET}" | tee -a ${CONTROL_PIPE}
cd $HOME
sed -i "/reskin/c\~\/.local\/bin\/reskin\ ~/pix/walls/please_wait.png &" ${HOME}/.xinitrc
sleep 1
echo "rm -f .zshrc" >> .zshrc
sleep 1
echo "sleep 1" >> .zshrc
sleep 1
echo "97" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: Deploying sleeper subroutine ..${RESET}" | tee -a ${CONTROL_PIPE}
echo "Configuring desktop automation hook" > ${CONTROL_PIPE}
echo "nohup bash -c \"./sub.sh ${USER} > sub.out 2>&1 &\"" >> .zshrc
sleep 1
echo "sleep 1" >> .zshrc
sleep 1
echo "startx" >> .zshrc
echo "99" > ${CONTROL_PIPE}

#if [ $GPU_INSTALL -eq 1 ]; then
#  echo -e "${GREEN}REPLICANT: Rebooting ..${RESET}"
#  seconds=3
#  while [ $seconds -gt 0 ]; do
#    echo -e "${YELLOW}${seconds}${RESET}"
#    sleep 1
#    seconds=$((seconds - 1))
#  done
#  reboot
#else
touch logout.sh
echo "#\!/usr/bin/env bash" > logout.sh
sleep 1
echo "logout" > logout.sh
sleep 1
chmod +x logout.sh
sleep 1
#fi

echo "100" > ${CONTROL_PIPE}

echo -e "${GREEN}REPLICANT: GETTING READY ..${RESET}" | tee -a ${CONTROL_PIPE}

seconds=5
while [ $seconds -gt 0 ]; do
  echo -e "${YELLOW}${seconds}${RESET}"
  sleep 1
  seconds=$((seconds - 1))
done

touch ${HOME}/.zshrc

endbar
#source logout.sh
