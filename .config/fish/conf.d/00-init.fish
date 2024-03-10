#!/usr/bin/env fish

# Base path.
set -Ux fish_user_paths "$HOME/.local/bin"

# Config files.
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_STATE_HOME "$HOME/.local/state"

# Projects dir.
set -gx HACK "$HOME/hackin"

# Editor.
set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

# Use vi key bindings.
set -g fish_key_bindings fish_vi_key_bindings
