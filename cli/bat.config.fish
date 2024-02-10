#!/usr/bin/env fish

set -gx BAT_CONFIG_PATH "$DOT/cli-tools/bat/bat.conf"
set -gx BAT_CONFIG_DIR "$DOT/cli-tools/bat"

function cat --wraps cat
    bat $argv
end
