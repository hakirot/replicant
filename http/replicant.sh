#!/bin/bash
set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

if [ -z ${CONTROL_PIPE+x} ] ; then
  CONTROL_PIPE="/tmp/load_pipe"
fi

send_pipe () {
  echo $1 | tee -a ${CONTROL_PIPE}
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

sleep 4

echo -e "${GREEN}++REPLICANT.sh++${RESET}"

# Restore .xinitrc
send_pipe "Restoring .xinitrc"
cp $HOME/git/d07f1135/.xinitrc ${HOME}
send_pipe "5"

echo -e "${GREEN}REPLICANT: Restoring .bash_profile${RESET}"
send_pipe "Restoring .bash_profile"
rm -f ${HOME}/.bash_profile
cp ${HOME}/.bash_profile.bak ${HOME}/.bash_profile
send_pipe "6"

send_pipe "Installing apps"
echo -e "${GREEN}REPLICANT: Installing a whole lotta packages${RESET}"
yay --noconfirm -S \
  adwaita-cursors \
  adwaita-fonts \
  adwaita-icon-theme \
  adwaita-icon-theme-legacy \
  bottom \
  cava \
  dysk \
  fastfetch \
  ffmpegthumbnailer \
  figlet \
  file \
  firefox \
  fontconfig \
  fuse2 \
  gnu-free-fonts \
  gzip \
  jq \
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
  polkit \
  ripgrep \
  rmpc \
  scrot \
  tldr \
  tree \
  tree \
  tree-sitter \
  tree-sitter-c \
  tree-sitter-cli \
  tree-sitter-lua \
  tree-sitter-markdown \
  tree-sitter-query \
  tree-sitter-vim \
  tree-sitter-vimdoc \
  ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-common \
  ttf-nerd-fonts-symbols-mono \
  ttf-noto-nerd \
  ueberzugpp \
  vlc \
  wireplumber \
  woff2 \
  woff2-font-awesome \
  xcolor \
  xsel \
  zathura \
  zathura-pdf-mupdf \
  zip

send_pipe "25"

send_pipe "Configuring RANGER"
echo -e "${GREEN}REPLICANT: Configuring RANGER${RESET}"
mkdir -p ${HOME}/.config/ranger
cd ${HOME}/git/suckless/ranger
cp commands_full.py commands.py rifle.conf rc.conf scope.sh ${HOME}/.config/ranger/
send_pipe "27"

send_pipe "Dropping in hakirot's neovim config"
echo -e "${GREEN}REPLICANT: Configuring NEOVIM${RESET}"
cd ${HOME}
git clone https://github.com/hakirot/neovim-config.git
mv neovim-config ${HOME}/.config/nvim
send_pipe "30"

send_pipe "Removing autologin config"
echo -e "${GREEN}REPLICANT: Removing autologin config${RESET}"
sudo rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
sudo rmdir /etc/systemd/system/getty@tty1.service.d/
send_pipe "32"

send_pipe "Installing TMUX config"
echo -e "${GREEN}REPLICANT: Installing TMUX config ..${RESET}"
cp ${HOME}/git/d07f1135/.tmux.conf ${HOME}
send_pipe "33"

send_pipe "Waiting for subroutine .."
echo -e "${GREEN}REPLICANT: Handing control to subroutine ..${RESET}"
touch ${HOME}/replicant_signal_1
cd ${HOME}
