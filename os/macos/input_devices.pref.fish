#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Input Devices"


execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1 && \
         defaults write -g com.apple.mouse.tapBehavior -int 1 && \
         defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1" \
    "Enable 'Tap to click'"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 && \
         defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true && \
         defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0" \
    "Map 'click or tap with two fingers' to the secondary click"

execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Allow tab-to-navigate in all windows"

execute "defaults write com.apple.HIToolbox AppleFnUsageType -int 2" \
    "Remap the emoji picker to the Fn key"

execute "defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true && \
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144" \
    "Use <ctrl-scroll> to zoom"

execute "defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true" \
    "Follow the keyboard focus while zoomed in"
