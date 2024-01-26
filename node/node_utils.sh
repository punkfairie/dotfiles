#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && source "../script/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

npm_install()
{
  local -r MSG="$1"
  local -r PKG="$2"

  execute ". $DOT/node/path.zsh && npm install --global --silent $PKG" "$MSG"
}
