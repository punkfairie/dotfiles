#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

function npm_install -a msg pkg
  execute \
    "source $DOT/node/path.config.fish && npm install --global --silent $pkg" \
    "$msg"
end
