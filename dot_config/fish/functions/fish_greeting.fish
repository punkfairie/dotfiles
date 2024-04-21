#!/usr/bin/env fish

function fish_greeting
    set -f cmd

    if command -v fortune &>/dev/null
        set -a cmd fortune
    end

    if command -v cowsay &>/dev/null
        set -a cmd cowsay
    end

    if command -v lolcat &>/dev/null
        set -a cmd "lolcat -t"
    end

    fish -c (string join ' | ' $cmd)
end
