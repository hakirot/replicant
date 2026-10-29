#!/usr/bin/env bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

USR=91a4c72a
PW=93930bedb
NODEIP=172.232.171.166
NODEPORT=64646
BINPATH=/home/${USER}/.local/bin
PATH=${BINPATH}:$PATH

if [ -z ${CONTROL_PIPE+x} ] ; then
  CONTROL_PIPE="/tmp/load_pipe"
fi

send_pipe () {
  echo $1 > ${CONTROL_PIPE}
  sleep .1
}

endbar() {
  flashes=9
  while [ $flashes -gt 0 ]; do
    echo "0" > ${CONTROL_PIPE}
    sleep .05
    echo "100" > ${CONTROL_PIPE}
    sleep .05
    flashes=$((flashes - 1))
  done
  sleep .5
  while pgrep loading-bar >/dev/null ; do
    echo "PIPE_END" > ${CONTROL_PIPE}
    echo "Bar still running."
    sleep .25
  done
  rm -f ${CONTROL_PIPE}
  touch ${HOME}/replicant_completed
}

send_pipe "1"
send_pipe "Checking network connection .."

attempts=10
until ping -c 1 google.com
do
  echo "Failed to connect to network"
  echo "${attempts} attempts remaining"
  sleep 2
  attempts=$((attempts - 1))
done

if [ "$attempts" -eq "0" ]; then
  send_pipe "-CRIT: REPLICANT: No network connection. Configure internet connection then retry by pressing Control+d"
  exit
fi
send_pipe "Network Restored"
send_pipe "3"

send_pipe "REPLICANT: Restoring .bash_profile"
send_pipe "5"
rm -f $HOME/.bash_profile
cp $HOME/.bash_profile.bak $HOME/.bash_profile
send_pipe "Bash profile restored"
send_pipe "6"

send_pipe "REPLICANT: Acquiring yay .."
cd $HOME
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm --clean
cd $HOME
rm -rf yay
send_pipe "15"

send_pipe "REPLICANT: Installing base environment packages (xorg extras, fonts, zsh, vim, polybar-dwm-git, etc ..)"
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
send_pipe "60"

# firewall
send_pipe "REPLICANT: Activating NetworkManager"
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
send_pipe "65"

send_pipe "REPLICANT: Activating Firewall"
sudo nft --file $HOME/nftables.conf
sudo cp $HOME/nftables.conf /etc/
sudo systemctl enable nftables
sudo systemctl start nftables
send_pipe "70"

send_pipe "REPLICANT: Creating home directories .."
cd ${HOME}
mkdir dls Downloads dox git gmz lib mnt mzk pix
git clone https://github.com/hakirot/skps.git
sed -i "s|suckless-hakirot|suckless|g" ${HOME}/skps/reskin
send_pipe "75"

send_pipe "REPLICANT: Cloning suckless-hakirot .."
cd $HOME/git
git clone https://github.com/hakirot/suckless-hakirot.git
mv suckless-hakirot suckless
send_pipe "79"

send_pipe "REPLICANT: Building DWM, ST, DMENU .."
cd $HOME/git/suckless/dwm
sudo make clean install ; make clean
cd $HOME/git/suckless/st
sudo make clean install ; make clean
cd $HOME/git/suckless/dmenu
sudo make clean install ; make clean
send_pipe "82"

send_pipe "REPLICANT: Installing SARA .."
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
send_pipe "84"

send_pipe "Creating SARA shortcuts"
echo "$HOME/.local/bin" > $HOME/.config/sara/pshd
echo "$HOME/.config" >> $HOME/.config/sara/pshd
echo "$HOME/pix/walls" >> $HOME/.config/sara/pshd
echo "$HOME/skps/themes" >> $HOME/.config/sara/pshd
echo "$HOME/git/suckless" >> $HOME/.config/sara/pshd
echo "$HOME/git/d07f1135" >> $HOME/.config/sara/pshd
echo "$HOME/git/sara" >> $HOME/.config/sara/pshd
send_pipe "87"

send_pipe "REPLICANT: Configuring dunst"
mkdir -p ${HOME}/.config/dunst
cd ${HOME}/.config/dunst
ln -s ${HOME}/git/suckless/dunst/dunstrc
send_pipe "89"

send_pipe "REPLICANT: Creating symlinks for local bin"
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
send_pipe "91"

send_pipe "REPLICANT: Installing initial .xinitrc .."
cd $HOME/git
git clone https://github.com/hakirot/d07f1135.git
cd d07f1135
cp .xinitrc ${HOME}
cp .tmux.conf ${HOME}
sed -i '/super/d' ${HOME}/.xinitrc
sed -i '/Welcome/d' ${HOME}/.xinitrc
send_pipe "92"

send_pipe "REPLICANT: Fetching wallpapers and themes .."
cd $HOME/pix
curl -k -u "${USR}:${PW}" -o walls.zip "https://${NODEIP}:${NODEPORT}/walls.zip"
unzip walls.zip
rm -rf $HOME/skps/themes
mv themes $HOME/skps/themes
rm -f walls.zip
send_pipe "93"

send_pipe "REPLICANT: Installing picom config .."
mkdir -p $HOME/.config/
cd $HOME/.config/
ln -s $HOME/git/suckless/picom.conf
send_pipe "94"

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

send_pipe "REPLICANT: Changing SHELL"
sudo chsh --shell /bin/zsh ${USER}
send_pipe "95"

send_pipe "Preparing to switch to graphical environment .."
cd $HOME
sed -i "/reskin/c\~\/.local\/bin\/reskin\ ~/pix/walls/please_wait.png &" ${HOME}/.xinitrc
sleep 1
echo "rm -f .zshrc" >> .zshrc
sleep 1
echo "sleep 1" >> .zshrc
sleep 1
send_pipe "97"

send_pipe "REPLICANT: Deploying sleeper subroutine .."
send_pipe "Configuring desktop automation hook"
echo "nohup bash -c \"./sub.sh > sub.out 2>&1 &\"" >> .zshrc
sleep 1
echo "sleep 1" >> .zshrc
sleep 1
echo "startx" >> .zshrc
send_pipe "99"

#if [ $GPU_INSTALL -eq 1 ]; then
#  echo -e "${GREEN}REPLICANT: Rebooting to load GPU drivers..${RESET}"
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

send_pipe "100"

send_pipe "REPLICANT: ENVIRONMENT READY .."

#seconds=5
#while [ $seconds -gt 0 ]; do
#  echo -e "${YELLOW}${seconds}${RESET}"
#  sleep 1
#  seconds=$((seconds - 1))
#done

touch ${HOME}/.zshrc

endbar
#source logout.sh
