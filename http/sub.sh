#!/usr/bin/env bash

set -eou pipefail

USER=$1

export DISPLAY=:0

sleep 5
nohup notify-send --expire-time 1000 "Please wait" "ten seconds" &
sleep 7
nohup notify-send --expire-time 1000 "Please wait" "three" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "two" &
sleep 1
nohup notify-send --expire-time 1000 "Please wait" "one" &
sleep 1
nohup notify-send --expire-time 1000 "Replicant" "Launching terminal" &

# Restore .xinitrc
sed -i "/reskin/c\~\/.local\/bin\/reskin\ &" ${HOME}/.xinitrc

nohup pkill -9 dunst &

# zsh init menu
xdotool key q
xdotool key KP_Enter
xdotool key control+l

# dunst patch
xdotool type "cd $HOME/git/suckless/dunst"
xdotool key KP_Enter
xdotool type "patch -i tiger_dunst.patch"
xdotool key KP_Enter

xdotool type "nohup $HOME/skps/reskin $HOME/pix/walls/tiger 2>&1 >/dev/null &"
xdotool key KP_Enter
xdotool key KP_Enter
xdotool key KP_Enter
xdotool key super+q
xdotool key super+space

nohup dunst &

sleep 1
# zsh init menu
xdotool key q
xdotool key KP_Enter
xdotool key control+l

# tiger style :3
xdotool key super+BackSpace
sleep .5
xdotool type "imv $HOME/pix/walls/tiger_no_touchy.jpeg"
xdotool key KP_Enter
sleep 1
xdotool key super+f

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

nohup notify-send --expire-time 1000 "Replicant" "No touchy" &

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
