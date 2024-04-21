#!/usr/bin/env fish

set -gx BATDIFF_USE_DELTA true
set -g batcmd

function cat --wraps bat
    if command -v bat &>/dev/null
        set -g batcmd bat
        bat $argv
    else if command -v batcat &>/dev/null
        set -g batcmd batcat
        batcat $argv
    end
end

abbr -a B --position anywhere --set-cursor "% | $batcmd"
abbr -a --position anywhere -- -h "-h 2>&1 | $batcmd --plain --language=help"
