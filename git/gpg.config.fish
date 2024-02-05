#!/usr/bin/env fish

if [ -e "~/.gnupg/gpg-agent.conf" ]
    set -gx GPG_TTY (tty)
    gpgconf --launch gpg-agent
end
