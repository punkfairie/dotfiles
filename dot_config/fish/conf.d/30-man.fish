#!/usr/bin/env fish

if command -v most &>/dev/null
    set -gx MANPAGER "sh -c 'col -bx | most'"
end
