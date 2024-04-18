#!/usr/bin/env fish

function lzg --wraps=lazygit
    set -f configs "$XDG_CONFIG_HOME/lazygit/config.yml,$HOME/.themes/lazygit/catppuccin/themes-mergable/macchiato/pink.yml"

    lazygit --use-config-file="$configs"
end
