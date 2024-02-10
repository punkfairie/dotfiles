#!/usr/bin/env fish

# fish-colored-man
set -g man_blink -o f38ba8 red
set -g man_bold -o 94e2d5 cyan
set -g man_standout -o a6e3a1 green
set -g man_underline -u f5c2e7 magenta

# Starship
set -gx STARSHIP_CONFIG "$DOT/fish/starship.toml"
starship init fish | source

# fzf
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
