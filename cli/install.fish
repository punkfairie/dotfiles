#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "CLI Tools"

brew_install "Midnight Commander" midnight-commander

brew_install bat bat
execute "bat cache --build" "Rebuild bat cache"
