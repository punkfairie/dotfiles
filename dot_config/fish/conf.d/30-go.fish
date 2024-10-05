#!/usr/bin/env fish

set -Ux GOPATH "$XDG_DATA_HOME/go"
set -Ux GOMODCACHE "$XDG_CACHE_HOME/go/mod"

if command -v go &>/dev/null
    fish_add_path "$XDG_DATA_HOME/go/bin"
end
