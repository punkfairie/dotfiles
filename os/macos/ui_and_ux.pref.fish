#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "UI & UX"

execute "defaults write -g AppleAccentColor -int 6" \
    "Set accent color to pink"

execute "defaults write -g AppleHighlightColor -string '1.000000 0.749020 0.823529 Pink'" \
    "Set highlight color to pink"

execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true && \
         defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true" \
    "Avoid creating '.DS_Store' files on network or USB volumes"

execute "defaults write com.apple.menuextra.battery ShowPercent -string 'YES'" \
    "Show battery percentage in the menu bar"

execute "defaults write com.apple.CrashReporter UseUNC 1" \
    "Make crash reports appear as notifications"

execute "defaults write com.apple.LaunchServices LSQuarantine -bool false" \
    "Disable 'Are you sure you want to open this application?' dialog"

execute "defaults write com.apple.screencapture location -string '$HOME/Desktop'" \
    "Save screenshots to the Desktop"

execute "defaults write com.apple.screencapture type -string 'png'" \
    "Save screenshots as PNGs"

execute "defaults write -g AppleFontSmoothing -int 2" \
    "Enable subpixel font rendering on non-Apple LCDs"

execute "defaults write -g NSNavPanelExpandedStateForSaveMode -bool true; \
         defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true" \
    "Expand save panel by default"

execute "defaults write -g PMPrintingExpandedStateForPrint -bool true && \
         defaults write -g PMPrintingExpandedStateForPrint2 -bool true" \
    "Expand print panel by default"

execute "defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true" \
    "Automatically quite printer app once print jobs complete"

execute "defaults write -g NSAutomaticCapitalizationEnabled -bool false" \
    "Disable automatic capitalization"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable automatic spelling correction"
