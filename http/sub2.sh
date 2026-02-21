#!/bin/bash

export DISPLAY=:0

sleep 3
xdotool type tmux
xdotool key KP_Enter
sleep 1
xdotool key q
xdotool type cd
xdotool key KP_Enter
sleep 1

# starting neovim for the plugins
xdotool type nvim
xdotool key KP_Enter
sleep 1

# oh-my-zsh
xdotool key alt+minus
sleep 1
# move this to separate script
xdotool type "sh -c \"\$\(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh\)\""
xdotool key KP_Enter
sleep 1

# rustup
xdotool key alt+minus
sleep 1
xdotool key control+j
xdotool key E
xdotool type "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
xdotool key KP_Enter

sleep 2
# lualine patch
xdotool key alt+minus
xdotool key control+j
xdotool key E
xdotool type "cp ${HOME}/git/suckless-hakirot/sarax_lualine.diff ${HOME}/.local/share/nvim/lazy/lualine.nvim"
xdotool key KP_Enter
xdotool type "cd ${HOME}/.local/share/nvim/lazy/lualine.nvim"
xdotool key KP_Enter
xdotool type "patch -i sarax_lualine.diff"
sleep 1

# Copy in zshrc
xdotool key alt+minus
xdotool key control+j
xdotool key E
xdotool type "cp $HOME/git/d07f1135/.zshrc $HOME"
xdotool key KP_Enter
sleep 1

# mark finish
xdotool key alt+minus
xdotool key control+j
xdotool key E
