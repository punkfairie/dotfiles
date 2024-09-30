#!/usr/bin/env fish

if command -v nvim &>/dev/null
    set -gx MANPAGER "nvim +Man!"
end
