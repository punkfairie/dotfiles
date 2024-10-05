#!/usr/bin/env fish

set -Ux PYTHON_HISTORY "$XDG_STATE_HOME/python/history"

if command -v brew &>/dev/null
    fish_add_path "$(brew --prefix)/opt/python@3.12/libexec/bin"
end
