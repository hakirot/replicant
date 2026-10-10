#!/bin/bash

set -eou pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

export DISPLAY=:0

# ------ SCREEN 1 ------
sleep 3
xdotool type tmux
xdotool key KP_Enter
sleep 1
xdotool key KP_Enter
xdotool type cd
xdotool key KP_Enter
sleep 1

nohup notify-send --expire-time 1000 "Replicant" "Installing neovim plugins .." &
# starting neovim for the plugins
xdotool type nvim
xdotool key KP_Enter

# oh-my-zsh
nohup notify-send --expire-time 1000 "Replicant" "Installing oh-my-zsh .." &
# ------ SCREEN 2 ------
xdotool key alt+minus
sleep 1
xdotool key q
xdotool key KP_Enter
xdotool type "./oh-my-zsh.sh"
xdotool key KP_Enter
sleep 20
xdotool key KP_Enter
xdotool key KP_Enter

nohup notify-send --expire-time 1000 "Replicant" "Applying zsh config patches .." &
xdotool type "cp ${HOME}/git/suckless/oh-my-zsh.diff ${HOME}/.oh-my-zsh/"
xdotool key KP_Enter
xdotool type "cd ${HOME}/.oh-my-zsh/"
xdotool key KP_Enter
xdotool type "patch -i oh-my-zsh.diff"
xdotool key KP_Enter
sleep 1
xdotool type "./lib/grep.zsh"
xdotool key KP_Enter
sleep 1
xdotool type "./plugins/git/git.plugin.zsh"
xdotool key KP_Enter
sleep 1
xdotool type "./themes/fwalch.zsh-theme"
xdotool key KP_Enter
sleep 1

xdotool key alt+k
xdotool key KP_Enter
xdotool key alt+j

# lualine patch
nohup notify-send --expire-time 1000 "Replicant" "Applying neovim patches .." &
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

sleep 1
xdotool type "tmux kill-pane"
xdotool key KP_Enter
sleep 1
xdotool type ":qa!"
sleep .25
xdotool key KP_Enter
sleep 1
xdotool type "tmux kill-pane"
xdotool key KP_Enter

# Copy in zshrc and dircolors
cp $HOME/git/d07f1135/.zshrc ${HOME}
cp $HOME/git/d07f1135/.dircolors ${HOME}

xdotool type "tmux"
xdotool key KP_Enter
sleep 1
xdotool type "q"
xdotool key KP_Enter
sleep 1

nohup notify-send --expire-time 1000 "Replicant" "Fetching custom SARA configs .." &
cd $HOME/git/sara
wget www.hakipaks.org/replicant/sara --output-document config.h
sed -i "s|PATH_ME_PLS|${HOME}/git/sara/sara|g" config.h
sed -i "s|HOME_DIR_PLS|${HOME}|g" config.h
wget www.hakipaks.org/replicant/sarafinal --output-document config.final
PATH=$HOME/.local/bin:$PATH
make clean
make

# Restore sensible sudo user rule
nohup notify-send --expire-time 1000 "Replicant" "Enforcing sudo pw for ${USER} .." &
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

xdotool type "reskin"
xdotool key KP_Enter
sleep 5
xdotool key KP_Enter
xdotool key KP_Enter

xdotool key control+d
sleep .5
xdotool key control+d
sleep .5
xdotool key q

xdotool key super+w
xdotool key super+space
sleep .5
xdotool key alt+z
xdotool key alt+z

nohup pkill -9 dunst &
cd $HOME/git/suckless/dunst
git checkout ./dunstrc
sleep 1
nohup dunst &
sleep 1

echo -e "${GREEN}REPLICANT: Installing Polybar configs ..${RESET}"
cd $HOME/git/suckless/polybar
mv install.sh.fresh install.sh
chmod +x install.sh
source install.sh
ln -s $HOME/git/suckless/polybar/bar.sh $HOME/.local/bin/bar
nohup /home/${USER}/git/suckless/polybar/bar.sh

nohup notify-send --expire-time 10000 "Replicant" "Done" &

cd $HOME/git/sara
mv config.h config.h.replicant
cp config.final config.h
sed -i "s|HOME_DIR_PLS|${HOME}|g" config.h
sed -i "s|PATH_ME_PLS|${HOME}/git/sara/sara|g" config.h
make clean
make

mkdir -p $HOME/.config/mpd
mkdir -p $HOME/.config/rmpc
mkdir -p $HOME/.config/rmpc/themes

cp $HOME/git/suckless/mpd/mpd.conf $HOME/.config/mpd/
cp $HOME/git/suckless/mpd/config.ron $HOME/.config/rmpc/
cp $HOME/git/suckless/mpd/replicant.ron $HOME/.config/rmpc/themes

systemctl enable pipewire --user
systemctl enable mpd --user
systemctl start mpd --user

# CLEANUP
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

rm -rf $HOME/git/suckless/.git
rm -rf $HOME/git/d07f1135/.git
rm -rf $HOME/git/sara/.git
rm -rf $HOME/skps/.git
rm -rf $HOME/.config/nvim/.git

rm -f $HOME/pix/walls/please_wait.png \
      $HOME/pix/walls/tiger_no_touchy.jpeg

rm -f $HOME/sub2.out
