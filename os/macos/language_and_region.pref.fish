#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "Language & Region"

execute "defaults write -g AppleLanguages -array 'en'" \
    "Set language"

execute "defaults write -g AppleICUDateFormatStrings -dict '{2 = 'd MMM y'; 3 = 'd MMMM y'; 4 = 'EEEE, d MMMM y'}'" \
    "Set date formats"
