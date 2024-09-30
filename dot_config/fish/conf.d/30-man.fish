#!/usr/bin/env fish

if command -v bat &>/dev/null
    set batcmd bat
else if command -v batcat &>/dev/null
    set batcmd batcat
end

if set -q batcmd
    set -gx MANPAGER "sh -c 'col -bx | $batcmd -l man -p'"
end
