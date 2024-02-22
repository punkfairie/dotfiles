#!/usr/bin/env fish

function cat --wraps cat
    bat $argv
end
