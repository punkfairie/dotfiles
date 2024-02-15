#!/usr/bin/env fish

# Base path.
fish_add_path /usr/local/bin "$HOME/bin"

# Projects dir.
set -gx HACK "$HOME/hackin"

# Editor.
set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

# Use vi key bindings.
set -g fish_key_bindings fish_vi_key_bindings

# Local environment variables.
if test -e "$HOME/.local.env"
    source "~/.local.env"
end
