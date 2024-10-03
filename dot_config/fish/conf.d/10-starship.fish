#!/usr/bin/env fish

if command -v starship &>/dev/null
    function starship_transient_prompt_func
        starship module character
    end

    if status is-interactive
        starship init fish | source
        enable_transience
    end
end
