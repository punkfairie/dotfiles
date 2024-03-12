#!/usr/bin/env fish

set -gx BATDIFF_USE_DELTA true

function cat --wraps bat
    bat $argv
end
