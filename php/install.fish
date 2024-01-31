#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ "$(uname)" = "Darwin" ]
  brew_install "Laravel Herd" "herd" "--cask"
  brew_install "PhpStorm" "phpstorm" "--cask"
end
