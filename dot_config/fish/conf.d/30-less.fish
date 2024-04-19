#!/usr/bin/env fish

set -gx LESS -R

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

abbr -a L --position anywhere --set-cursor "% | less"

function lessv
    /usr/share/nvim/runtime/macros/less.sh $argv
end
