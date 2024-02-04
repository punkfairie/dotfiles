#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function npm_install -a msg pkg
    set -f cmd "npm install --global --silent $pkg"

    if ! cmd_exists volta
        set cmd "source $DOT/node/path.config.fish; $cmd"
    end

    execute "$cmd" "$msg"
end
