#!/usr/bin/env fish

set -gx BAT_CONFIG_PATH "$DOT/bat/bat.conf"
set -gx BAT_CONFIG_DIR "$DOT/bat"

function cat --wraps cat
    bat $argv
end
