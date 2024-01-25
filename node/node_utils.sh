#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && source "../script/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

npm_install()
{
  execute ". $DOT/node/path.zsh && npm install --global --silent $1" "$2"
}
