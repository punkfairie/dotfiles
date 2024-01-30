#!/usr/bin/env fish

source "$DOT/homebrew/brew_utils.fish"
source "$DOT/node/node_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install "FiraCode Nerd Font" "font-fira-code-nerd-font" "" "homebrew/cask-fonts"
brew_install "Starship Prompt" "starship"
brew_install "Zsh Syntax Highlighting" "zsh-syntax-highlighting"
brew_install "Zsh Autosuggestions" "zsh-autosuggestions"
brew_install "The Fuck" "thefuck"
npm_install "tldr pages" "tldr"
