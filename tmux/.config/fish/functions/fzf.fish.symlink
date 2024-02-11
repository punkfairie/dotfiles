#!/usr/bin/env fish

function fzf --wraps=fzf
    if test "$TERM_PROGRAM" = tmux
        fzf-tmux -p 90%,95% $argv
    else
        fzf $argv
    end
end
