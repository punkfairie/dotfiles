#!/usr/bin/env fish

function fm --wraps fm
    fm --syntax-theme=rose-pine --pretty-markdown=true --show-icons=true $argv
end
