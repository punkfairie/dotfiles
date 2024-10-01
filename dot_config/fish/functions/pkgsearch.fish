#!/usr/bin/env fish

function pkgsearch -d "Search the core/extra/AUR repos for a package" -a search
    set -f query ""

    if set -q search
        set query "--query=$search"
    end

    set -f res (yay -Slq | command fzf --multi --preview 'yay -Si {}' --height=90% --layout=reverse "$query")

    if test $status -eq 0
        set -l pkgs (string join ' ' $res)
        commandline --current-token --replace -- "yay -S $res"
    end

    commandline --function repaint
end
