#!/bin/bash

export DISPLAY=:0

sleep 20
xdotool key super+space
sleep 3
xdotool type cd
xdotool key KP_Enter
xdotool type ./replicant.sh
xdotool key KP_Enter
