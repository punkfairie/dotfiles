#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && source "../homebrew/brew_utils.sh" \
  && source "../script/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

brew_install "Fish Shell" "fish"

fish_path="$(which fish)"

if ! grep "$fish_path" < /etc/shells &> /dev/null; then
  execute \
    "printf '%s\n' '$fish_path' | sudo tee -a /etc/shells" \
    "Add '$fish_path' to '/etc/shells'"
fi

chsh -s "$fish_path" &> /dev/null
print_result $? "Make OS use Fish as the default shell"

execute \
  "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher" \
  "Fisher"
