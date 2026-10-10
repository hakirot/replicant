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

# zsh init menu
xdotool key 0
sleep 10
xdotool key KP_Enter
sleep 1
xdotool key control+d
sleep 1
xdotool key control+d
xdotool key super+q

# Restore .xinitrc
sed -i "/reskin/c\~\/.local\/bin\/reskin\ &" ${HOME}/.xinitrc

nohup pkill -9 dunst &

xdotool key super+space
sleep 1
xdotool key 0
xdotool key KP_Enter

# dunst patch
xdotool type "cd $HOME/git/suckless/dunst"
xdotool key KP_Enter
xdotool type "patch -i tiger_dunst.patch"
xdotool key KP_Enter
nohup $HOME/skps/reskin $HOME/pix/walls/tiger 2>&1 >/dev/null &
sleep 1
nohup dunst &

xdotool key super+q
sleep 1
xdotool key super+space
sleep 1
#xdotool key control+l
#sleep .25

# tiger style :3
xdotool key super+BackSpace
sleep .25
xdotool type "imv $HOME/pix/walls/tiger_no_touchy.jpeg"
xdotool key KP_Enter
sleep 1
xdotool key super+f

#xdotool key super+h

sleep 1
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

xdotool key alt+x
xdotool key alt+x
xdotool key alt+x
xdotool key alt+x

xdotool type cd
xdotool key KP_Enter
sleep 1
xdotool type "./replicant.sh"
xdotool key KP_Enter
