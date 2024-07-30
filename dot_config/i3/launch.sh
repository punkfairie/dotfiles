#!/usr/bin/env bash

"$HOME/.config/fehbg/i3"
picom --config "$HOME/.config/picom/i3" &

"$HOME/.config/polybar/colorblocks/scripts/pywal.sh" "$HOME/data/photos/wallpaper/cloud.png"
"$HOME/.config/polybar/launch.sh --colorblocks"
