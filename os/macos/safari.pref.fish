#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Safari

execute "defaults write com.apple.Safari SuppressSearchSuggestions -bool true && \
         defaults write com.apple.Safari UniversalSearchEnabled -bool false" \
    "Don’t send search queries to Apple"

execute "defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true" \
    "Enable 'Do Not Track'"

killall Safari &>/dev/null
