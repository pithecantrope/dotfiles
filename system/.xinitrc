#!/bin/sh

while true; do
	if [ -f /sys/class/power_supply/BAT0/capacity ]; then
		capacity=$(< /sys/class/power_supply/BAT0/capacity)%
	else
		capacity='N/A'
	fi
	time=$(date +"%H:%M")
	
	xprop -root -set WM_NAME "$capacity $time"
	sleep 1m
done &

setxkbmap -layout us,ru -option grp:alt_caps_toggle &
unclutter --timeout 1 --start-hidden &
ciadpi --disorder 1 &

st &
chromium &

exec dwm
