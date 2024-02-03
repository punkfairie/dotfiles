#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_title "Volta & Node.js"

execute "curl https://get.volta.sh | bash -s -- --skip-setup" Volta

execute ". $DOT/node/path.config.fish && volta install node" "Node.js LTS"
