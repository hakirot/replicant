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
xdotool key Y
xdotool key KP_Enter
sleep 3

xdotool type "cp ${HOME}/git/suckless-hakirot/oh-my-zsh.diff ${HOME}/.oh-my-zsh/"
xdotool key KP_Enter
xdotool type "cd ${HOME}/.oh-my-zsh/"
xdotool key KP_Enter
xdotool type "patch -i oh-my-zsh.diff"
xdotool key KP_Enter
sleep 1
xdotool type "./plugins/git/git.plugin.zsh"
xdotool key KP_Enter

# rustup
# ------ SCREEN 3 ------
xdotool key alt+minus
sleep 1
xdotool key control+j
xdotool key E
xdotool type "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
xdotool key KP_Enter
sleep 10
xdotool key KP_Enter
sleep 1

# lualine patch
# ------ SCREEN 4 ------
xdotool key alt+minus
xdotool key control+j
xdotool key E
xdotool type "cp ${HOME}/git/suckless-hakirot/sarax_lualine.diff ${HOME}/.local/share/nvim/lazy/lualine.nvim"
xdotool key KP_Enter
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

#sleeping longer to check progress
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

# Copy in zshrc
cp $HOME/git/d07f1135/.zshrc $HOME

xdotool type "tmux"
xdotool key KP_Enter
sleep 1
xdotool key q
xdotool type "cd"
xdotool key KP_Enter

xdotool type "mkdir $HOME/.ssh"
xdotool key KP_Enter
xdotool type "cd $HOME/.ssh"
xdotool key KP_Enter
xdotool type "ssh-keygen -t rsa -b 4096"
xdotool key KP_Enter
xdotool type "hub"
xdotool key KP_Enter
xdotool type "asdf"
xdotool key KP_Enter
xdotool type "asdf"
xdotool key KP_Enter
xdotool type "cd"
xdotool key KP_Enter

xdotool type "./finalize.sh"
xdotool key KP_Enter
