#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Input Devices"

execute "defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1" \
    "Set click strength to 'medium'"

execute "defaults write -g com.apple.trackpad.forceClick -bool true" \
    "Enable force-click"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 && \
         defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true && \
         defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 && \
         defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0" \
    "Map 'click or tap with two fingers' to the secondary click"

execute "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
         defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1 && \
         defaults write -g com.apple.mouse.tapBehavior -int 1 && \
         defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1" \
    "Enable 'Tap to click'"

execute "defaults write -g com.apple.swipescrolldirection -bool true" \
    "Set scroll direction to 'natural'"

execute "defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true" \
    "Enable pinch-to-zoom"

execute "defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1" \
    "Enable smart zoom"

execute "defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true" \
    "Enable rotating"

execute "defaults write -g AppleEnableSwipeNavigateWithScrolls -bool true" \
    "Enable swiping between pages"

execute "defaults write -g AppleKeyboardUIMode -int 3" \
    "Allow tab-to-navigate in all windows"

execute "defaults write com.apple.HIToolbox AppleFnUsageType -int 2" \
    "Remap the emoji picker to the Fn key"

execute "defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true && \
    defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144" \
    "Use <ctrl-scroll> to zoom"

execute "defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true" \
    "Follow the keyboard focus while zoomed in"
