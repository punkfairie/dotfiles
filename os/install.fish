#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "OS"

if [ "$(uname)" = "Darwin" ]
  brew_install "mas-cli" "mas"

  brew_install "Rectangle" "rectangle" "--cask"
  execute "mas install 1563735522" "Charmstone"

  brew_install "Windscribe" "windscribe" "--cask"
  brew_install "Firefox" "firefox" "--cask"
  brew_install "qBittorrent" "qbittorrent" "--cask"

  brew_install "Discord" "discord" "--cask"
  brew_install "BetterDiscord" "betterdiscord-installer" "--cask"

  brew_install "Obsidian" "obsidian" "--cask"
  brew_install "Fantastical" "fantastical" "--cask"

  brew_install "iTerm2" "iterm2" "--cask"
  brew_install "Laravel Herd" "herd" "--cask"
  brew_install "DBngin" "dbngin" "--cask"
  brew_install "PhpStorm" "phpstorm" "--cask"
  brew_install "WebStorm" "webstorm" "--cask"
end
