#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"
source "$DOT/node/node_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Fish

brew_install "GNU Core Utilities" coreutils
execute "ln -sf '$(brew --prefix)/bin/gsha256sum' '$(brew --prefix)/bin/sha256sum'" \
    "Use brew installed GNU Core Utils by default"

brew_install wget wget --with-iri
brew_install cURL curl
brew_install grep grep
brew_install OpenSSH openssh
brew_install ImageMagick imagemagick
brew_install ssh-copy-id ssh-copy-id

execute "fisher install catppuccin/fish" catppuccin/fish
execute "fisher install decors/fish-colored-man" fish-colored-man

brew_install "FiraCode Nerd Font" font-fira-code-nerd-font "" homebrew/cask-fonts
brew_install "Starship Prompt" starship
brew_install "The Fuck" thefuck
npm_install "tldr pages" tldr
brew_install eza eza
