#!/usr/bin/env fish

set -gx BAT_CONFIG_PATH "$DOT/cli/bat/bat.conf"
set -gx BAT_CONFIG_DIR "$DOT/cli/bat"

function cat --wraps cat
    bat $argv
end
