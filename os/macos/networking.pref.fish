#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Networking

execute "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true" \
    "Allow AirDrop over Ethernet"
