#!/usr/bin/env fish

# fish-colored-man
set -g man_blink -o f38ba8 red
set -g man_bold -o 94e2d5 cyan
set -g man_standout -o a6e3a1 green
set -g man_underline -u f5c2e7 magenta

# Starship
set -gx STARSHIP_CONFIG "$DOT/fish/starship.toml"
starship init fish | source
