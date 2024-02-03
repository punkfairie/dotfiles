#!/usr/bin/env fish

if [ "$(uname)" = Darwin ]
    abbr -a afk --position command "osascript -e 'tell application \"System Events\" to sleep'"
    abbr -a o --position command open

else if [ "$(uname)" = Linux ]
    abbr -a afk --position command "gnome-screensaver-command --lock"
    abbr -a o --position command xdg-open

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # APT.

    abbr -a apti --position command "sudo apt install"
    abbr -a aptr --position command "sudo apt remove"
    abbr -a aptu --position command "sudo apt update && sudo apt upgrade"
end
