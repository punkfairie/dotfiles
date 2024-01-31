#!/usr/bin/env fish

# fish-colored-man
set -g man_blink -o f38ba8 red
set -g man_bold -o 94e2d5 cyan
set -g man_standout -b 11111b black
set -g man_underline -u 11111b black

# Starship
set -gx STARSHIP_CONFIG "$DOT/fish/starship.toml"
starship init fish | source
