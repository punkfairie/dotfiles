#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_title "Volta & Node.js"

execute "curl https://get.volta.sh | bash -s -- --skip-setup" Volta

execute "if ! cmd_exists 'volta'; source $DOT/node/path.config.fish; end && volta install node" \
    "Node.js LTS"
