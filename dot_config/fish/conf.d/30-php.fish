#!/usr/bin/env fish

if command -v composer &>/dev/null
    fish_add_path "$HOME/.config/composer/vendor/bin"
end

if command -v php &>/dev/null
    abbr -a p --position command php
    abbr -a pa --position command "php artisan"
    abbr -a a --position command "php artisan"
end
