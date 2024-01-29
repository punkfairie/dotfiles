#!/usr/bin/env sh

DOT="${DOT:-$HOME/dotfiles}"

# shellcheck source=../homebrew/brew_utils.sh
. "$DOT/homebrew/brew_utils.sh"
# shellcheck source=../script/utils.sh
. "$DOT/script/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

brew_install "Fish Shell" "fish"

fish_path="$(which fish)"

if ! grep "$fish_path" < /etc/shells >/dev/null 2>&1; then
  execute \
    "printf '%s\n' '$fish_path' | sudo tee -a /etc/shells" \
    "Add '$fish_path' to '/etc/shells'"
fi

chsh -s "$fish_path" >/dev/null 2>&1
print_result $? "Make OS use Fish as the default shell"
