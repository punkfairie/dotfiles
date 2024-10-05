#!/usr/bin/env fish

function figlet --wraps figlet
    command figlet -f "ANSI Shadow" $argv
end
