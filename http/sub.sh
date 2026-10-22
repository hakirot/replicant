#!/usr/bin/env bash

set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

export DISPLAY=:0

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


sleep 5
echo "if { [ \"\$TERM\" = \"tmux-256color\" ] && [ ! -z \${TMUX+x} ] ; } then" >> ${HOME}/.zshrc
#echo -e "  sara" >> ${HOME}/.zshrc
echo "./loading-bar -d -E replicant.sh -H \"REPLICANT.sh: Last script\" -C \"replicant complete\" -l /home/${USER}/replicant_log" >> ${HOME}/.zshrc
echo "else" >> ${HOME}/.zshrc
echo -e "  tmux" >> ${HOME}/.zshrc
echo "fi" >> ${HOME}/.zshrc

$HOME/skps/reskin $HOME/pix/walls/detach 2>&1 >/dev/null &


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
echo "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\" && touch \${HOME}/replicant_signal_2" > ${HOME}/.zshrc
#echo "touch ${HOME}/replicant_signal_2" >> ${HOME}/.zshrc
xdotool key alt+minus
xdotool key control+j
xdotool key E
send_pipe "44"

send_pipe "Waiting for oh-my-zsh.sh to complete .."
while [ ! -e "${HOME}/replicant_signal_2" ]; do
  xdotool key KP_Enter
  sleep 2
done
send_pipe "48"

send_pipe "Patching oh-my-zsh"
xdotool type "cp ${HOME}/git/suckless/oh-my-zsh.diff ${HOME}/.oh-my-zsh/"
xdotool key KP_Enter
xdotool type "cd ${HOME}/.oh-my-zsh/"
xdotool key KP_Enter
xdotool type "patch -i oh-my-zsh.diff"
xdotool key KP_Enter
xdotool type "./lib/grep.zsh"
xdotool key KP_Enter
xdotool type "./plugins/git/git.plugin.zsh"
xdotool key KP_Enter
xdotool type "./themes/fwalch.zsh-theme"
xdotool key KP_Enter
send_pipe "52"

send_pipe "Waiting for neovim plugins to install .."
while [ ! -e "${HOME}/.local/share/nvim/lazy/lualine.nvim/README.md" ]; do
  sleep 5
done
send_pipe "56"

send_pipe "Patching neovim lualine"
xdotool type "cp ${HOME}/git/suckless/sarax_lualine.diff ${HOME}/.local/share/nvim/lazy/lualine.nvim"
xdotool key KP_Enter
# TODO just copy these in
xdotool type "cd ${HOME}/.local/share/nvim/lazy/lualine.nvim"
xdotool key KP_Enter
xdotool type "patch -i sarax_lualine.diff"
xdotool key KP_Enter
sleep 1
xdotool type "./lua/lualine/config.lua"
xdotool key KP_Enter
sleep 1
xdotool type "./lua/lualine/themes/16color.lua"
xdotool key KP_Enter
send_pipe "60"

send_pipe "Closing .."
sleep .5
xdotool key control+d
sleep 1
xdotool type ":qa!"
sleep .2
xdotool key KP_Enter
sleep 1
send_pipe "64"

send_pipe "Reinstating password sudo for ${USER}"
# Restore sensible sudo user rule
xdotool type "sudo su - root"
xdotool key KP_Enter
sleep .25
xdotool type "vim /etc/sudoers.d/00"
xdotool key KP_Tab
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
send_pipe "68"

send_pipe "Installing .dotfiles"
cp ${HOME}/git/d07f1135/.zshrc ${HOME}
cp $HOME/git/d07f1135/.dircolors ${HOME}
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
send_pipe "76"

send_pipe "Installing polybar configs"
cd $HOME/git/suckless/polybar
mv install.sh.fresh install.sh
chmod +x install.sh
source install.sh
ln -s $HOME/git/suckless/polybar/bar.sh $HOME/.local/bin/bar
nohup /home/${USER}/git/suckless/polybar/bar.sh
send_pipe "80"

send_pipe "Installing rmpc and mpd configs"
mkdir -p $HOME/.config/mpd
mkdir -p $HOME/.config/rmpc
mkdir -p $HOME/.config/rmpc/themes
cp $HOME/git/suckless/mpd/mpd.conf $HOME/.config/mpd/
cp $HOME/git/suckless/mpd/config.ron $HOME/.config/rmpc/
cp $HOME/git/suckless/mpd/replicant.ron $HOME/.config/rmpc/themes
send_pipe "84"

send_pipe "Enabling pipewire & mpd"
systemctl enable pipewire --user
systemctl enable mpd --user
systemctl start mpd --user
send_pipe "88"

# CLEANUP
send_pipe "Cleaning up"
rm -rf $HOME/skps.bak \
  $HOME/nohup.out \
  $HOME/logout.sh \
  $HOME/sub.sh \
  $HOME/sub.out \
  $HOME/sub2.sh \
  $HOME/oh-my-zsh.sh \
  $HOME/replicant.sh \
  $HOME/replicate.sh \
  $HOME/nftables.conf \
  $HOME/.host.zsh
send_pipe "92"

rm -rf $HOME/git/suckless/.git
rm -rf $HOME/git/d07f1135/.git
rm -rf $HOME/git/sara/.git
rm -rf $HOME/skps/.git
rm -rf $HOME/.config/nvim/.git
send_pipe "96"

rm -f $HOME/pix/walls/please_wait.png \
      $HOME/pix/walls/tiger_no_touchy.jpeg
send_pipe "98"

send_pipe "Building SARA"
cd $HOME/git/sara
mv config.h config.h.replicant
cp config.final config.h
sed -i "s|HOME_DIR_PLS|${HOME}|g" config.h
sed -i "s|PATH_ME_PLS|${HOME}/git/sara/sara|g" config.h
make clean
make
send_pipe "99"

send_pipe "Clearing notification"
dunstctl close
endbar
xdotool key control+d
xdotool key control+d
xdotool key control+d
xdotool key super+space
nohup notify-send --expire-time 3600000 "Replicant" "Done" &
