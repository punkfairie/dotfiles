#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"
source "$DOT/os/apt_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle OS

brew_install Bash bash
brew_install Zsh zsh

if [ "$(uname)" = Darwin ]
    # brew_install mas-cli mas

    # Window management.
    brew_install Rectangle rectangle --cask

    # Networking.
    brew_install Windscribe windscribe --cask
    brew_install Firefox firefox --cask
    brew_install qBittorrent qbittorrent --cask

    # Social.
    brew_install Discord discord --cask
    brew_install BetterDiscord betterdiscord-installer --cask

    # Productivity.
    brew_install Obsidian obsidian --cask
    brew_install Fantastical fantastical --cask

    # Hacking.
    brew_install iTerm2 iterm2 --cask
    brew_install DBngin dbngin --cask

    # Utilities.
    brew_install "The Unarchiver" the-unarchiver --cask
end
