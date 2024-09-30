#!/usr/bin/env fish

set -gx LESS -R

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

abbr -a L --position anywhere --set-cursor "% | less"

function lessv
    if ! command -v nvim &>/dev/null
        return
    end

    if test -e "/usr/share/nvim/runtime/macros/less.sh"
        /usr/share/nvim/runtime/macros/less.sh $argv
    else if test -e "/usr/local/share/nvim/runtime/macros/less.sh"
        /usr/local/share/nvim/runtime/macros/less.sh $argv
    end
end
