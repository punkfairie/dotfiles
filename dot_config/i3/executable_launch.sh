#!/usr/bin/env bash

"$HOME/.config/polybar/colorblocks/scripts/pywal.sh" "$HOME/data/photos/wallpaper/girl.jpg"

picom --config "$HOME/.config/picom/i3" &
"$HOME/.config/fehbg/i3"

sleep 2
"$HOME/.config/polybar/launch.sh" --colorblocks &
