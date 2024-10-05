#!/usr/bin/env fish

if command -v chezmoi &>/dev/null
    abbr -a cz --position command chezmoi
    abbr -a czap --position command "chezmoi apply"
    abbr -a cza --position command "chezmoi add"
    abbr -a czc --position command "chezmoi cd"
    abbr -a cze --position command "chezmoi edit"
    abbr -a czu --position command "chezmoi update"

    abbr -a czct --position command "chezmoi chattr +t"

    abbr -a czcm --position command 'git aa && git c -m "$(chezmoi generate git-commit-message)" && git p'

    if command -v bat &>/dev/null
        abbr -a czd --position command "chezmoi data | bat --language=json"
    else if command -v batcat &>/dev/null
        abbr -a czd --position command "chezmoi data | batcat --language=json"
    end
end
