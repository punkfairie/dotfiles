#!/usr/bin/env fish

if command -v volta &>/dev/null
    fish_add_path "$HOME/.volta/bin"

    set -gx VOLTA_HOME "$HOME/.volta"
end
