#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ "$(uname)" = "Darwin" ]
  brew_install "Laravel Herd" "herd" "--cask"
  brew_install "PhpStorm" "phpstorm" "--cask"
else if [ "$(uname)" = "Linux" ] && cmd_exists snap
  execute "sudo snap install phpstorm --classic" "PhpStorm"
end
