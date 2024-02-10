#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Vim

brew_install Vim vim
brew_install Neovim neovim

brew_install fzf fzf
brew_install Ripgrep ripgrep
brew_install GCC gcc
brew_install Make make
