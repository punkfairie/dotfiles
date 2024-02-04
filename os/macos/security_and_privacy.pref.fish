#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Security & Privacy"

execute "defaults write com.apple.AdLib allowApplePersonalizedAdvertising -int 0" \
    "Disable personalized ads"

execute "defaults write com.apple.screensaver askForPassword -int 1 && \
    defaults write com.apple.screensaver askForPasswordDelay -int 0" \
    "Require password immediately after sleep or screensaver begins"
