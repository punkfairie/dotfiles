#!/usr/bin/env fish

function nvidia-settings --wraps nvidia-settings
    command nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
end
