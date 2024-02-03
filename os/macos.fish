#!/usr/bin/env fish

"$DOT/os/macos/close_prefs.applescript"

find "$DOT/os/macos/" -name "*.pref.fish" | while read file
    fish -c "$file"
end
