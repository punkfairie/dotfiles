#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Terminal

if ! grep -q "pam_tid.so" "/etc/pam.d/sudo"
    execute "sudo sh -c 'echo \"auth sufficient pam_tid.so\" >> /etc/pam.d/sudo'" \
        "Use Touch ID to authenticate sudo"
end
