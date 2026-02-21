#!/usr/bin/env bash

set -eou pipefail

USER=$1

export DISPLAY=:0

sleep 15

xdotool key super+space
sleep 3

# tiger
xdotool key super+BackSpace
sleep 1
xdotool type "imv $HOME/pix/walls/tiger"
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

xdotool key super+l

sleep 1

xdotool type cd
xdotool key KP_Enter
sleep 1
xdotool type "./replicant.sh ${USER}"
xdotool key KP_Enter
