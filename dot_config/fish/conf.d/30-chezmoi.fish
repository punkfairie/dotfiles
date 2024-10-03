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
end
