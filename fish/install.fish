#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"
source "$DOT/node/node_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Fish

execute "fisher install catppuccin/fish" catppuccin/fish
execute "fisher install decors/fish-colored-man" fish-colored-man

brew_install "FiraCode Nerd Font" font-fira-code-nerd-font "" homebrew/cask-fonts
brew_install "Starship Prompt" starship
brew_install "The Fuck" thefuck
npm_install "tldr pages" tldr
brew_install exa exa
