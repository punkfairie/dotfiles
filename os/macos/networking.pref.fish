#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Networking

execute "defaults write -g com.apple.NetworkBrowser BrowseAllInterfaces 1" \
    "Allow AirDrop over Ethernet"
