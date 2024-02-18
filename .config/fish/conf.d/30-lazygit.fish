#!/usr/bin/env fish

function lzg --wraps=lazygit
    set -f configs "$HOME/.config/lazygit/config.yml,$HOME/.themes/lazygit/catppuccin/themes-mergable/macchiato/pink.yml"

    if test "$(pwd)" = "$HOME"
        lazygit --use-config-file="$configs" --work-tree="$HOME" --git-dir="$HOME/.dot"
    else
        lazygit --use-config-file="$configs"
    end
end
