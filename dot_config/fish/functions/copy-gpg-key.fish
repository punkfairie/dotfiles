#!/usr/bin/env fish

function copy-gpg-key
    set -f key (\
        gpg --list-secret-keys --keyid-format SHORT\
        | grep 'rsa4096' \
        | sed 's/sec   rsa4096\///'\
        | awk '{print $1}'\
    )

    copyq copy "$key" && return 0

    return 1
end
