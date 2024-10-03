#!/usr/bin/env fish

if command -v yay
    abbr -a y --position command yay
    abbr -a yi --position command "yay -S"
    abbr -a yr --position command "yay -R"
    abbr -a yc --position command "yay -Sc"
    abbr -a yu --position command "yay -Syu"
    abbr -a ys --position command "yay -Ss"
    abbr -a ysi --position command "yay -Qs"

    function yay-group-missing --argument-names group
        comm -23 <(yay -Sg $group | awk '{print $2}' | sort) <(yay -Qq | sort)
    end
end
