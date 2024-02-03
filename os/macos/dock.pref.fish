#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Dock

execute "defaults write com.apple.dock autohide -bool true" \
    "Automatically hide/show the dock"

execute "defaults write com.apple.dock autohide-delay -float 0" \
    "Disable the hide dock delay"

execute "defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true" \
    "Enable spring loading for all dock items"

execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
    "Make all mission control animations faster"

execute "defaults write com.apple.dock mineffect -string 'scale'" \
    "Change minimize/maximize window animation to 'scale'"

execute "defaults write com.apple.dock mru-spaces -bool false" \
    "Do not automatically rearrange spaces based on most recent use"

execute "defaults write com.apple.dock show-recents -bool false" \
    "Do not show recent applications in dock"

killall Dock &>/dev/null
