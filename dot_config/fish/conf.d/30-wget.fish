#!/usr/bin/env fish

if command -v wget &>/dev/null
    set -gx WGETRC "$XDG_CONFIG_HOME/wgetrc"

    function wget --wraps wget
        command wget --hsts-file="$XDG_CACHE_HOME/wget-hsts" $argv
    end
end
