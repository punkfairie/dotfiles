#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Dock

execute "defaults write com.apple.dock tilesize -int 50" \
    "Set icon size"

execute "defaults write com.apple.dock magnification -bool true" \
    "Enable magnification"

execute "defaults write com.apple.dock largesize -int 75" \
    "Set magnification icon size"

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

execute "defaults write com.apple.dock show-process-indicators -bool true" \
    "Show indicator lights for open applications"

execute "defaults write com.apple.dashboard mcx-disabled -bool false" \
    "Disable dashboard"

execute "defaults write com.apple.dock dashboard-in-overlay -bool true" \
    "Don't show dashboard as a space"

execute "defaults write com.apple.dock showhidden -bool true" \
    "Show hidden applications in dock"

print_subtitle "Hot Corners"

execute "defaults write com.apple.dock wvous-tl-corner -int 4 && \
         defaults write com.apple.dock wvous-tl-modifier -int 0" \
    "Set top left corner -> show desktop"

execute "defaults write com.apple.dock wvous-bl-corner -int 11 && \
         defaults write com.apple.dock wvous-bl-modifier -int 0" \
    "Set bottom left corner -> show launchpad"

execute "defaults write com.apple.dock wvous-tr-corner -int 0 && \
         defaults write com.apple.dock wvous-tr-modifier -int 0" \
    "Set top right corner -> do nothing"

execute "defaults write com.apple.dock wvous-br-corner -int 0 && \
         defaults write com.apple.dock wvous-br-modifier -int 0" \
    "Set bottom right corner -> do nothing"

killall Dock &>/dev/null
