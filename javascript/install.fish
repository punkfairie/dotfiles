#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/node/node_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Javascript/Typescript

npm_install "gulp CLI" gulp-cli

if [ "$(uname)" = Darwin ]
    brew_install WebStorm webstorm --cask
else if [ "$(uname)" = Linux ] && cmd_exists snap
    execute "sudo snap install webstorm --classic" WebStorm
end
