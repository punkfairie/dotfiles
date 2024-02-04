#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Photos

execute "defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true" \
    "Prevent Photos from opening automatically when devices are plugged in"

killall Photos &>/dev/null
