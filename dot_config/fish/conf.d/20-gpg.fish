#!/usr/bin/env fish

if test "$(command -v gpgconf &>/dev/null)"
    set -Ux GPG_TTY (tty)
    gpgconf --launch gpg-agent
end
