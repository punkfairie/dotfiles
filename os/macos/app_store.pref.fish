#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "App Store"

execute "defaults write com.apple.commerce AutoUpdate -bool true" \
  "Turn on auto-update"

execute "defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true" \
  "Enable automatic update check"

execute "defaults write come.apple.SoftwareUpdate AutomaticDownload -int 1" \
  "Download newly available updates in background"

execute "defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1" \
  "Install system data files and security updates"

killall "App Store" &>/dev/null
