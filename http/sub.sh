#!/usr/bin/env bash

set -eou pipefail

USER=$1

export DISPLAY=:0

sleep 5
nohup notify-send "Replicant" "ten seconds .." &
sleep 5
nohup notify-send "Replicant" "five seconds .." &
sleep 2
nohup notify-send "Replicant" "three .." &
sleep 1
nohup notify-send "Replicant" "two .." &
sleep 1
nohup notify-send "Replicant" "one .." &
sleep 1
nohup notify-send "Replicant" "Launching terminal" &

# Restore .xinitrc
sed -i "/newlook/c\~\/.local\/bin\/newlook\ &" ${HOME}/.xinitrc

xdotool key super+space

sleep 2

nohup pkill -9 dunst &

# zsh init menu
xdotool key q
xdotool key KP_Enter
xdotool key control+l

# dunst patch
xdotool type "cd $HOME/git/suckless-hakirot/dunst"
xdotool key KP_Enter
xdotool type "patch -i tiger_dunst.patch"
xdotool key KP_Enter

xdotool type "nohup $HOME/skps/newlook $HOME/pix/walls/walls/tiger &"
xdotool key KP_Enter
xdotool key KP_Enter
xdotool key KP_Enter
xdotool key super+q
xdotool key super+space

nohup dunst &
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

nohup notify-send "Replicant" "No touchy" &

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
