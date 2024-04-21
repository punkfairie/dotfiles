#!/usr/bin/env fish

set -gx BATDIFF_USE_DELTA true

function cat --wraps bat
    if command -v bat &>/dev/null
        bat $argv
    else if command -v batcat &>/dev/null
        batcat $argv
    end
end

abbr -a B --position anywhere --set-cursor "% | bat"
abbr -a --position anywhere -- -h "-h 2>&1 | bat --plain --language=help"
