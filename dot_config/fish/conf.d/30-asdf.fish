#!/usr/bin/env fish

set file /opt/asdf-vm/asdf.fish

if test -e "$file"
    source "$file"
end
