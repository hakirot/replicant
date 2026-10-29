#!/usr/bin/env bash

set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

BINPATH=/home/${USER}/.local/bin
PATH=${BINPATH}:$PATH

export DISPLAY=:0

CONTROL_PIPE=/tmp/replicant_pipe

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
}

echo "if { [ \"\$TERM\" = \"tmux-256color\" ] && [ ! -z \${TMUX+x} ] ; } then" >> ${HOME}/.zshrc
echo "./loading-bar -d -n replicant_pipe -E replicant.sh -H \"REPLICANT (3/3) FINALIZING\" -C \"replicant complete\" -l ${HOME}/replicant_log" >> ${HOME}/.zshrc
echo "else" >> ${HOME}/.zshrc
echo -e "  tmux" >> ${HOME}/.zshrc
echo "fi" >> ${HOME}/.zshrc


nohup notify-send --expire-time 1000 "Please wait" "ten" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "nine" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "eight" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "seven" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "six" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "five" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "four" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "three" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "two" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "one" &
sleep 1
nohup notify-send --expire-time 1000 "Final script" "Launching" &
sleep 1
nohup notify-send --expire-time 3600000 "Replicant is finishing up" "Please do not disturb" &


cd ${HOME}/pix/walls
#${HOME}/skps/reskin please_wait.png
wal -a 92 -f "${HOME}/skps/themes/detach.json"
cd ${HOME}

sleep 1
xdotool key super+space
sleep .5
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z

while [ ! -e "${HOME}/replicant_signal_1" ]; do
  sleep 5
done

send_pipe "+Subroutine Awakened .."
send_pipe "Clearning signal"
rm -f ${HOME}/replicant_signal_1
echo "nvim" > ${HOME}/.zshrc
sleep .2
xdotool key alt+minus
send_pipe "36"

send_pipe "Installing oh-my-zsh"
echo "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"; touch \${HOME}/replicant_signal_2" > ${HOME}/.zshrc
xdotool key alt+minus
xdotool key control+j
xdotool key E
send_pipe "44"
sleep 1

send_pipe "Waiting for oh-my-zsh.sh to complete .."
while [ ! -e "${HOME}/replicant_signal_2" ]; do
  xdotool key KP_Enter
  sleep 1
  xdotool key control+d
  sleep 1
done
echo "oh-my-zsh.sh completed"
send_pipe "48"

send_pipe "Patching oh-my-zsh"
cp ${HOME}/git/suckless/oh-my-zsh.diff ${HOME}/.oh-my-zsh/
cd ${HOME}/.oh-my-zsh
patch -i oh-my-zsh.diff -p1
send_pipe "52"
echo "oh-my-zsh patched"

send_pipe "Waiting for lualine neovim plugin to install .."
while [ ! -e "${HOME}/.local/share/nvim/lazy/lualine.nvim/README.md" ]; do
  sleep 5
done
echo "lualine detected"
send_pipe "56"

send_pipe "Patching lualine"
sleep .5
cp ${HOME}/git/suckless/lualine.diff ${HOME}/.local/share/nvim/lazy/lualine.nvim
cd ${HOME}/.local/share/nvim/lazy/lualine.nvim
patch -i lualine.diff -p1
send_pipe "60"
echo "lualine patched"

send_pipe "Exiting neovim"
sleep .5
xdotool key control+d
xdotool key control+j
xdotool key E
sleep 1
xdotool type ":qa!"
sleep .5
xdotool key KP_Enter
sleep .5
#sleep 500
xdotool key control+l
send_pipe "64"
echo "neovim exited"

send_pipe "Reinstating sudo password for ${USER}"
sleep .2
xdotool key control+l
xdotool type "sudo su - root"
sleep .2
xdotool key KP_Enter
sleep .2
xdotool key control+l
sleep .2
xdotool type "vim /etc/sudoers.d/00_"
sleep .2
xdotool key KP_Tab
sleep 1
xdotool key KP_Enter
sleep 1
xdotool key KP_Enter
xdotool key KP_Enter
xdotool key f
xdotool key N
xdotool key d
xdotool key t
xdotool key A
xdotool key period
xdotool key KP_Enter
xdotool key KP_Enter
sleep .5
xdotool key colon
xdotool key w
xdotool key exclam
xdotool key KP_Enter
sleep .5
xdotool key colon
xdotool key q
xdotool key KP_Enter
xdotool key KP_Enter
sleep .5
xdotool key control+d
sleep .25
xdotool key control+d
sleep .25
xdotool key control+d
echo "sudo password for ${USER} reinstated"
send_pipe "68"

send_pipe "Installing .dotfiles"
cp ${HOME}/git/d07f1135/.zshrc ${HOME}
cp $HOME/git/d07f1135/.dircolors ${HOME}
echo ".dotfiles installed"
send_pipe "72"

send_pipe "Fetching custom sara configs from hakipaks.org"
cd $HOME/git/sara
wget www.hakipaks.org/replicant/sara --output-document config.h
sed -i "s|PATH_ME_PLS|${HOME}/git/sara/sara|g" config.h
sed -i "s|HOME_DIR_PLS|${HOME}|g" config.h
wget www.hakipaks.org/replicant/sarafinal --output-document config.final
PATH=$HOME/.local/bin:$PATH
make clean
make
echo "Fetched custom sara configs from hakipaks"
send_pipe "76"

send_pipe "Installing polybar configs"
cd $HOME/git/suckless/polybar
mv install.sh.fresh install.sh
chmod +x install.sh
source install.sh
ln -s $HOME/git/suckless/polybar/bar.sh $HOME/.local/bin/bar
#nohup /home/${USER}/git/suckless/polybar/bar.sh
echo "Installed polybar configs"
send_pipe "80"

send_pipe "Installing rmpc and mpd configs"
mkdir -p $HOME/.config/mpd
mkdir -p $HOME/.config/rmpc
mkdir -p $HOME/.config/rmpc/themes
cp $HOME/git/suckless/mpd/mpd.conf $HOME/.config/mpd/
sed -i "s|PATH_ME_PLS|${HOME}/mzk/|g" config.h
cp $HOME/git/suckless/mpd/config.ron $HOME/.config/rmpc/
cp $HOME/git/suckless/mpd/replicant.ron $HOME/.config/rmpc/themes
echo "Installed rmpc and mpd configs"
send_pipe "84"

send_pipe "Enabling pipewire & mpd"
systemctl enable pipewire --user
systemctl enable mpd --user
systemctl start mpd --user
send_pipe "88"
echo "Enabling pipewire & mpd"

# CLEANUP
send_pipe "Cleaning up"
rm -rf $HOME/skps.bak \
  $HOME/nohup.out \
  $HOME/logout.sh \
  $HOME/sub.sh \
  $HOME/replicant.sh \
  $HOME/replicate.sh \
  $HOME/nftables.conf \
  $HOME/loading-bar \
  $HOME/ncurses-loading-bar \
  $HOME/.host.zsh
echo "Cleaned"
send_pipe "92"

send_pipe "Clearing git histories"
rm -rf $HOME/git/suckless/.git
rm -rf $HOME/git/d07f1135/.git
rm -rf $HOME/skps/.git
rm -rf $HOME/.config/nvim/.git
echo "Cleared git histories"
send_pipe "96"

rm -f $HOME/pix/walls/please_wait.png \
      $HOME/pix/walls/tiger_no_touchy.jpeg

cd ${HOME}/git/sara
make
cd ${HOME}
send_pipe "100"

send_pipe "Clearing notification"
dunstctl close

endbar
xdotool key control+d
xdotool key control+d
xdotool key control+d

${HOME}/skps/reskin
xdotool key super+space
# no idea why this isn't starting
# sara:1: command not found: sara
# sara launches just fine in any spawn after
# bizzare
sleep .5
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
#if pgrep sara >/dev/null ; then
#  xdotool type "sara"
#  xdotool key KP_Enter
#fi
nohup notify-send --expire-time 3000 "Replicant" "Done" &

cd $HOME/git/sara
mv config.h config.h.replicant
cp config.final config.h
sed -i "s|HOME_DIR_PLS|${HOME}|g" config.h
sed -i "s|PATH_ME_PLS|${HOME}/git/sara/sara|g" config.h
make clean
make

cd ${HOME}
mv replicant_log replicate_log sub.out skadoosh_log /tmp
rm -f ${HOME}/replicant_signal_2

# SARA -> replicant doc
xdotool key alt+f

touch /tmp/replicant_completed
