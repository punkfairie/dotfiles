#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && source "../script/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

print_title "Volta & Node.js"

execute "curl https://get.volta.sh | bash -s -- --skip-setup" "Volta"

execute ". $DOT/node/path.zsh && volta install node" "Node.js LTS"
