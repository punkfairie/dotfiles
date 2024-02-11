#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "CLI Tools"

brew_install "GNU Core Utilities" coreutils
execute "ln -sf '$(brew --prefix)/bin/gsha256sum' '$(brew --prefix)/bin/sha256sum'" \
    "Use brew installed GNU Core Utils by default"

brew_install wget wget --with-iri
brew_install cURL curl
brew_install grep grep
brew_install OpenSSH openssh
brew_install ImageMagick imagemagick
brew_install ssh-copy-id ssh-copy-id

brew_install "FiraCode Nerd Font" font-fira-code-nerd-font "" homebrew/cask-fonts
brew_install "Starship Prompt" starship
brew_install "The Fuck" thefuck
brew_install eza eza

brew_install neofetch neofetch

brew_install "Midnight Commander" midnight-commander

brew_install bat bat
execute "bat cache --build" "Rebuild bat cache"
