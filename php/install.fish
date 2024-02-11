#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle PHP

brew_install MailHog mailhog "" "" true
brew_install Meilisearch meilisearch "" "" true

if [ "$(uname)" = Darwin ]
    brew_install "Laravel Herd" herd --cask
    brew_install PhpStorm phpstorm --cask
end
