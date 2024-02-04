#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Activity Monitor"

execute "defaults write com.apple.ActivityMonitor OpenMainWindow -bool true" \
    "Show the main window on launch"

execute "defaults write com.apple.ActivityMonitor IconType -int 5" \
    "Show CPU usage as the dock icon"

execute "defaults write com.apple.ActivityMonitor ShowCategory -int 0" \
    "Show all processes"

execute "defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage' && \
         defaults write com.apple.ActivityMonitor SortDirection -int 0" \
    "Sort results by CPU usage"

killall "Activity Monitor" &>/dev/null
