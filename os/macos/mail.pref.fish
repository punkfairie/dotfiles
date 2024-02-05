#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Mail

execute "defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false" \
    "Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>`"

killall Mail &>/dev/null
