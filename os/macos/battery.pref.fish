#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute "sudo pmset -a lidwake 1" \
    "Enable lid wakeup"

execute "sudo systemsetup -setrestartfreeze on" \
    "Restart automatically if the computer freezes"

execute "sudo pmset -a displaysleep 15" \
    "Display sleep after 15 minutes"

execute "sudo pmset -c sleep 30" \
    "Machine sleep after 30 minutes while charging"

execute "sudo pmset -b sleep 10" \
    "Machine sleep after 10 minutes on battery"
