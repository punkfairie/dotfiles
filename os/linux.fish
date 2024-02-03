#!/usr/bin/env fish

find "$DOT/os/linux/" -name "*.pref.fish" | while read file
    fish -c "$file"
end
