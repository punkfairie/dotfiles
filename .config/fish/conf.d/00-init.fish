#!/usr/bin/env fish

# Base path.
set -Ux fish_user_paths "$HOME/.local/bin"

# Projects dir.
set -gx HACK "$HOME/hackin"

# Editor.
set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

# Use vi key bindings.
set -g fish_key_bindings fish_vi_key_bindings
