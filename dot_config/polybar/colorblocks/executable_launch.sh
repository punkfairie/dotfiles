#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/colorblocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

sleep 10

# Launch the bar
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		"$m" >>~/.scratch
		MONITOR=$m polybar -q main -c "$DIR"/config.ini &
	done
else
	polybar -q main -c "$DIR"/config.ini &
fi
