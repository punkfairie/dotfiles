#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

polybar -c ~/.config/polybar/config.ini first 2>&1 | tee -a /tmp/polbar.log &
disown
polybar -c ~/.config/polybar/config.ini second 2>&1 | tee -a /tmp/polbar.log &
disown
polybar -c ~/.config/polybar/config.ini third 2>&1 | tee -a /tmp/polbar.log &
disown
polybar -c ~/.config/polybar/config.ini fourth 2>&1 | tee -a /tmp/polbar.log &
disown

echo "Polybar launched..."
