#!/usr/bin/env fish

function fman --wraps fm
    fm --syntax-theme=rose-pine --pretty-markdown=true --show-icons=true $argv
end
