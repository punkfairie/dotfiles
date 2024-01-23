#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && . "../homebrew/brew_utils.sh"

brew_install "Git" "git"
brew_install "Github CLI" "gh"
brew_install "Gitmoji" "gitmoji"
