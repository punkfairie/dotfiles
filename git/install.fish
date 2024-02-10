#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Git

brew_install "Github CLI" gh

execute \
    "ln -f -s ~/dotfiles/git/gitmoji-fuzzy-hook/bin/gitmoji-fuzzy-hook-init.sh $HOME/bin/gitmoji-fuzzy-hook-init" \
    gitmoji-fuzzy-hook

print_subtitle "Git GPG"

sudo -k

brew_install GnuPG gnupg
brew_install "Pinentry for Mac" pinentry-mac

if ! [ -e "$HOME/.gnupg" ]
    mkdir "$HOME/.gnupg" &>/dev/null
end

if ! [ -e "$HOME/.gnupg/gpg.conf" ]
    echo use-agent >"$HOME/.gnupg/gpg.conf"
end

if ! [ -e "$HOME/.gnupg/gpg-agent.conf" ]
    printf '%b' \
        "default-cache-ttl 34560000\n" \
        "max-cache-ttl 34560000\n" \
        "pinentry-program $(brew --prefix)/bin/pinentry-mac" >"$HOME/.gnupg/gpg-agent.conf"
end

if ! [ -e "$HOME/.gnupg/pubring.kbx" ]
    print_warning "No GPG keys exist! Please run $DOT/git/gpg-key.fish"
end
