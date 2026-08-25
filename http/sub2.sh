#!/bin/bash

export DISPLAY=:0

# ------ SCREEN 1 ------
sleep 3
xdotool type tmux
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
xdotool type "./oh-my-zsh.sh"
xdotool key KP_Enter
sleep 3
xdotool key KP_Enter

nohup notify-send --expire-time 1000 "Replicant" "Applying oh-my-zsh patches .." &
xdotool type "cp ${HOME}/git/suckless-hakirot/oh-my-zsh.diff ${HOME}/.oh-my-zsh/"
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
# rustup
# ------ SCREEN 3 ------
#xdotool key alt+minus
#sleep 1
#xdotool key control+j
#xdotool key E
#xdotool type "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
#xdotool key KP_Enter
#sleep 8
#xdotool key KP_Enter
#sleep 1

# lualine patch
nohup notify-send --expire-time 1000 "Replicant" "Applying neovim patches .." &
# ------ SCREEN 3 ------
#xdotool key alt+minus
#xdotool key control+j
#xdotool key E
xdotool type "cp ${HOME}/git/suckless-hakirot/sarax_lualine.diff ${HOME}/.local/share/nvim/lazy/lualine.nvim"
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

#sleep 1
#xdotool type "tmux kill-pane"
#xdotool key KP_Enter
sleep 1
xdotool type "tmux kill-pane"
xdotool key KP_Enter
sleep 1
xdotool type ":qa!"
sleep 1
xdotool key KP_Enter
sleep 1
xdotool type "tmux kill-pane"
xdotool key KP_Enter

# Copy in zshrc and dircolors
cp $HOME/git/d07f1135/.zshrc $HOME
cp $HOME/git/d07f1135/.dircolors $HOME

xdotool type "tmux"
xdotool key KP_Enter
sleep 1
xdotool type "q"
xdotool key KP_Enter
sleep 1

xdotool type "ln -s $HOME/git/suckless-hakirot/polybar/bar.sh $HOME/.local/bin/bar"
xdotool key KP_Enter
sleep .5

#xdotool type "bar"
#xdotool key KP_Enter
#xdotool type "waiting.."
#sleep 8
xdotool key control+u
xdotool key KP_Enter

nohup notify-send --expire-time 1000 "Replicant" "Fetching custom SARA configs .." &
xdotool type "cd $HOME/git/sara"
xdotool key KP_Enter
xdotool type "wget www.hakipaks.org/replicant/sara --output-document config.h"
xdotool key KP_Enter
xdotool type "waiting.."
sleep 4
xdotool key control+u
xdotool type "wget www.hakipaks.org/replicant/sarafinal --output-document config.final"
xdotool key KP_Enter
xdotool type "waiting.."
sleep 4
xdotool key control+u
xdotool type "sed -i \"s|PATH_ME_PLS|${HOME}/git/sara/sara|g\" config.h"
xdotool key KP_Enter
sleep 1
xdotool type "make clean"
xdotool key KP_Enter
sleep 1
xdotool type "make"
xdotool key KP_Enter
sleep 2

# Restore sensible sudo user rule
nohup notify-send --expire-time 1000 "Replicant" "Enforcing sudo pw for ${USER} .." &
xdotool type "sudo su - root"
xdotool key KP_Enter
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
sleep 1

xdotool key control+d
sleep 1

xdotool key q

xdotool key super+w
xdotool key super+space
sleep .5
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z

nohup pkill -9 dunst &
cd $HOME/git/suckless-hakirot/dunst
git checkout ./dunstrc
sleep 1
nohup dunst &
sleep 1
nohup notify-send --expire-time 10000 "Replicant" "Done" &

cd ${HOME}/git/sara/
mv config.h config.h.replicant
make
cd ${HOME}

mv ${HOME}/skps ${HOME}/skps.bak

mkdir ${HOME}/skps

cp ${HOME}/skps.bak/colortest \
   ${HOME}/skps.bak/shutdown.sh \
   ${HOME}/skps.bak/wifi \
   ${HOME}/skps.bak/respawn.sh \
   ${HOME}/skps.bak/kill-session.sh \
   ${HOME}/skps.bak/reskin \
   ${HOME}/skps/

cp -r ${HOME}/skps.bak/custom_walz ${HOME}/skps/

mv $HOME/git/suckless-hakirot $HOME/git/suckless
rm -rf $HOME/git/suckless-hakirot/.git
rm -rf $HOME/git/d07f1135/.git
rm -rf $HOME/git/sara/.git
rm -rf $HOME/.config/nvim/.git

# CLEANUP
rm -rf $HOME/skps.bak \
  $HOME/nohup.out \
  $HOME/logout.sh \
  $HOME/sub.sh \
  $HOME/sub.out \
  $HOME/sub2.sh \
  $HOME/sub2.out \
  $HOME/oh-my-zsh.sh \
  $HOME/replicant.sh \
  $HOME/replicate.sh \
  $HOME/nftables.conf

cd $HOME/git/sara
mv config.final config.h
make
