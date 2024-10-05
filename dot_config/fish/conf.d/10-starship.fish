#!/usr/bin/env fish

set -Ux STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship.toml"
set -Ux STARSHIP_CACHE "$XDG_CACHE_HOME/starship"

if command -v starship &>/dev/null
    function starship_transient_prompt_func
        starship module character
    end

    if status is-interactive
        starship init fish | source
        enable_transience
    end
end
