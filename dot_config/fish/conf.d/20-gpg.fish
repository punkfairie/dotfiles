#!/usr/bin/env fish

if command -v gpgconf &>/dev/null
    set -gx GPG_TTY (tty)
    gpgconf --launch gpg-agent
end
