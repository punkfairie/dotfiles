#!/usr/bin/env fish

# Projects dir.
set -gx HACK "$HOME/hackin"

# Neovim dirs.
set -gx NVIM "$HOME/.config/nvim"
set -gx NVLUA "$HOME/.config/nvim/lua"
set -gx NVCUSTOM "$HOME/.config/nvim/lua/custom"

# Editor.
set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Use vi key bindings.
set -g fish_key_bindings fish_vi_key_bindings
