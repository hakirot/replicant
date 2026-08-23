#!/bin/bash

export DISPLAY=:0

# ------ SCREEN 1 ------
sleep 3
xdotool type tmux
xdotool key KP_Enter
xdotool type cd
xdotool key KP_Enter
sleep 1

# starting neovim for the plugins
xdotool type nvim
xdotool key KP_Enter

# oh-my-zsh
# ------ SCREEN 2 ------
xdotool key alt+minus
sleep 1
xdotool type "./oh-my-zsh.sh"
xdotool key KP_Enter
sleep 3
xdotool key KP_Enter
sleep 3

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

# rustup
# ------ SCREEN 3 ------
xdotool key alt+minus
sleep 1
xdotool key control+j
xdotool key E
xdotool type "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
xdotool key KP_Enter
sleep 8
xdotool key KP_Enter
sleep 1

# lualine patch
# ------ SCREEN 4 ------
xdotool key alt+minus
xdotool key control+j
xdotool key E
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

sleep 1

xdotool type "tmux kill-pane"
xdotool key KP_Enter
sleep 1
xdotool type "tmux kill-pane"
xdotool key KP_Enter
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
sleep 1

xdotool type "bar"
xdotool key KP_Enter
xdotool type "waiting.."
sleep 8
xdotool key control+u
xdotool key KP_Enter

xdotool type "cd $HOME/git/sara"
xdotool key KP_Enter
xdotool type "wget www.hakipaks.org/replicant/sara --output-document config.h"
xdotool key KP_Enter
xdotool type "waiting.."
sleep 8
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

xdotool type "newlook"
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

# Clear replicant completion message and set sara to default
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
   ${HOME}/skps.bak/newlook \
   ${HOME}/skps/

# CLEANUP
rm -f $HOME/finalize.sh \
  $HOME/nohup.out \
  $HOME/logout.sh \
  $HOME/sub.out \
  $HOME/sub2.sh \
  $HOME/sub2.out \
  $HOME/oh-my-zsh.sh

sudo echo "${USER} ALL=(ALL) ALL" > /etc/sudoers.d/00_${USER}
