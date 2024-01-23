#!/user/bin/env bash
# vim:set ft=bash:

install_once()
{
  if brew ls --versions "$1"; then
    brew upgrade "$1"
  else
    brew install "$1"
  fi
}
