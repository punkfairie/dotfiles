#!/usr/bin/env fish

if test "$(command -v gpgconf &>/dev/null)"
    set -gx GPG_TTY (tty)
    gpgconf --launch gpg-agent
end
