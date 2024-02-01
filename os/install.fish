#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"
source "$DOT/os/apt_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle "OS"

if [ "$(uname)" = "Darwin" ]
  brew_install "mas-cli" "mas"

  # Window management.
  brew_install "Rectangle" "rectangle" "--cask"
  execute "mas install 1563735522" "Charmstone"

  # Networking.
  brew_install "Windscribe" "windscribe" "--cask"
  brew_install "Firefox" "firefox" "--cask"
  brew_install "qBittorrent" "qbittorrent" "--cask"

  # Social.
  brew_install "Discord" "discord" "--cask"
  brew_install "BetterDiscord" "betterdiscord-installer" "--cask"

  # Productivity.
  brew_install "Obsidian" "obsidian" "--cask"
  brew_install "Fantastical" "fantastical" "--cask"

  # Hacking.
  brew_install "iTerm2" "iterm2" "--cask"
  brew_install "DBngin" "dbngin" "--cask"

  # Utilities.
  brew_install "The Unarchiver" "the-unarchiver" "--cask"

else if [ "$(uname)" = "Linux" ] && cmd_exists snap
  apt_install "wget" "wget"
  apt_install "curl" "cURL"

  # Networking.
  if ! cmd_exists windscribe
    execute "sudo wget https://github.com/Windscribe/Desktop-App/releases/download/v2.8.6/windscribe_2.8.6_amd64.deb -O /tmp/ws.deb \
      && sudo apt install /tmp/ws.deb" \
      "Windscribe"
  end

  execute "sudo snap install firefox" "Firefox"
  execute "sudo snap install qbittorrent-arnatious" "qBittorrent"

  # Social.
  execute "sudo snap install discord" "Discord"
  # TODO: add check for already installed.
  execute "sudo wget https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage -O /tmp/bd.AppImage \
    && sudo chmod u+x /tmp/bd.AppImage \
    && /tmp/bd.AppImage" \
    "BetterDiscord"

  # Productivity.
  execute "sudo snap install obsidian --classic" "Obsidian"

  # Media.
  execute "sudo snap install vlc" "VLC"
end
