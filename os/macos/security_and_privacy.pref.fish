#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Security & Privacy"

execute "defaults write com.apple.AdLib allowApplePersonalizedAdvertising -int 0" \
    "Disable personalized ads"
