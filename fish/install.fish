#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"
source "$DOT/node/node_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Fish

execute "fisher install catppuccin/fish" catppuccin/fish
execute "fisher install decors/fish-colored-man" fish-colored-man
