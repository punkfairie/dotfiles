#!/usr/bin/env fish

set -Ux WGETRC "$XDG_CONFIG_HOME/wgetrc"

if command -v wget &>/dev/null

    function wget --wraps wget
        command wget --hsts-file="$XDG_CACHE_HOME/wget-hsts" $argv
    end
end
