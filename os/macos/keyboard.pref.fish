#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Keyboard

execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Enable full keyboard access for all controls"

execute "defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false" \
    "Disable automatic capitalization"

execute "defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false" \
    "Disable automatic correction"

execute "defaults write com.apple.HIToolbox AppleFnUsageType -int 2" \
    "Remap the emoji picker to the Fn key"
