#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && . "../homebrew/brew_utils.sh"

brew_install "FiraCode Nerd Font" "font-fira-code-nerd-font" "" "homebrew/cask-fonts"
brew_install "Starship Prompt" "starship"
brew_install "Zsh Syntax Highlighting" "zsh-syntax-highlighting"
