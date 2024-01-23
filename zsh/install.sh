#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && . "../homebrew/brew_utils.sh"

brew_install "Starship Prompt" "starship"
