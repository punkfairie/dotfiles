#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# https://gist.github.com/phortuin/cf24b1cca3258720c71ad42977e1ba57

print_title "GPG Key Setup for Git & Github"

if ! [ -e "$HOME/.gnupg/pubring.kbx" ]
    print_warning "Please run gpg --full-gen-key with the following answers:"
    print_warning "Kind of key   - 4 (RSA, sign only)"
    print_warning "Keysize       - 4096"
    print_warning "Expiration    - 0"
    print_warning "Real name     - <your GitHub username>"
    print_warning "Email address - <private email>@users.noreply.github.com"
    print_warning "Re-run this script when finished!"

    exit
end

# https://gist.github.com/oseme-techguy/bae2e309c084d93b75a9b25f49718f85
sudo -k
chown -R $(whoami) "$HOME/.gnupg/"
find ~/.gnupg -type f -exec chmod 600 {} \;
find ~/.gnupg -type d -exec chmod 700 {} \;

set key (
    gpg --list-secret-keys --keyid-format SHORT\
    | grep 'rsa4096'\
    | sed 's/sec   rsa4096\///'\
    | awk '{print $1}'
)

sed -i '' "s/# GPGKEY/signingkey = $key/g" "$DOT/git/.gitconfig.local.symlink" \
    && print_success "Added key to .gitconfig.local"

gpg --armor --export $key | pbcopy \
    && print_success "Copied key to clipboard" \
    && print_warning "Please go to https://github.com/settings/keys" \
    && print_warning "and add your copied GPG key to your GitHub account!"
