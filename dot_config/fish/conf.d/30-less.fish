#!/usr/bin/env fish

if command -v less &>/dev/null
    set -gx LESS -R

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    abbr -a L --position anywhere --set-cursor "% | less"

    if command -v nvim &>/dev/null
        function lessv
            if test -e "/usr/share/nvim/runtime/macros/less.sh"
                /usr/share/nvim/runtime/macros/less.sh $argv
            else if test -e "/usr/local/share/nvim/runtime/macros/less.sh"
                /usr/local/share/nvim/runtime/macros/less.sh $argv
            end
        end
    end
end
