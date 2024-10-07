#!/usr/bin/env fish

if command -v gpgconf &>/dev/null
    set -gx GPG_TTY (tty)

    if status --is-interactive
        gpgconf --launch gpg-agent
    end
end
