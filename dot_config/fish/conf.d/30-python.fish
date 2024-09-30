#!/usr/bin/env fish

if command -v brew &>/dev/null
    fish_add_path "$(brew --prefix)/opt/python@3.12/libexec/bin"
end
