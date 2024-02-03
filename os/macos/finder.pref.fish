#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Finder

execute "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" \
    "Use full POSIX path as window title"

execute "defaults write com.apple.finder WarnOnEmptyTrash -bool false" \
    "Disable the warning before emptying the trash"

execute "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'" \
    "Search the current directory by default"

execute "defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false" \
    "Disable warning when changing a file extension"

execute "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true && \
         defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true && \
         defaults write com.apple.finder ShowMountedServersOnDesktop -bool true && \
         defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true" \
    "Show icons for hard drives, servers, and removable media on the desktop"

execute "defaults write -g AppleShowAllExtensions -bool true" \
    "Show all filename extensions"

execute "defaults write com.apple.finder AppleShowAllFiles -bool true" \
    "Show hidden files"

execute "defaults write com.apple.finder _FXSortFoldersFirst -bool true" \
    "Keep folders on top when sorting by name"

execute "defaults write com.apple.finder FXRemoveOldTrashItems -bool true" \
    "Delete trash items after 30 days"

execute "defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true" \
    "Show folder icons in the title bar"


execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy name' ~/Library/Preferences/com.apple.finder.plist && \
         /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy name' ~/Library/Preferences/com.apple.finder.plist" \
    "Set sort method"

killall Finder &>/dev/null
killall cfprefsd &>/dev/null
