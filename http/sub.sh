#!/usr/bin/env bash

set -eou pipefail

USER=$1

export DISPLAY=:0

sleep 15
sed -i "/newlook/c\~\/.local\/bin\/newlook\ &" ${HOME}/.xinitrc

xdotool key super+space

sleep 2

# zsh init menu
xdotool key q
xdotool key KP_Enter
xdotool key control+l

xdotool type "nohup $HOME/skps/newlook $HOME/pix/walls/walls/tiger &"
xdotool key KP_Enter
#sleep 1
xdotool key KP_Enter
xdotool key KP_Enter
xdotool key super+q
xdotool key super+space
sleep 2

# zsh init menu
xdotool key q
xdotool key KP_Enter
xdotool key control+l

# tiger style :3
xdotool key super+BackSpace
sleep 1
xdotool type "imv $HOME/pix/walls/walls/tiger_no_touchy.jpeg"
xdotool key KP_Enter
sleep 1
xdotool key super+f

xdotool key super+j
xdotool key super+j
xdotool key super+j
xdotool key super+j
xdotool key super+j

xdotool key plus
xdotool key plus
xdotool key plus
xdotool key plus
xdotool key plus
xdotool key plus
xdotool key plus
xdotool key plus
xdotool key plus

xdotool key j
xdotool key j

xdotool key super+l

xdotool key alt+z
xdotool key alt+z
xdotool key alt+z
xdotool key alt+z

xdotool type cd
xdotool key KP_Enter
sleep 1
xdotool type "./replicant.sh"
xdotool key KP_Enter
