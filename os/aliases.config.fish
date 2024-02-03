#!/usr/bin/env fish

if [ "$(uname)" = Darwin ]
    abbr -a afk --position command "osascript -e 'tell application \"System Events\" to sleep'"
    abbr -a o --position command open

else if [ "$(uname)" = Linux ]
    abbr -a o --position command xdg-open
end
