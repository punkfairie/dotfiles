#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/node/node_utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Javascript/Typescript

npm_install "gulp CLI" gulp-cli

if [ "$(uname)" = Darwin ]
    brew_install WebStorm webstorm --cask
end
