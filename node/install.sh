#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && source "../script/utils.sh"

if ! [[ -d "~/.zsh-plugins/zsh-nvm" ]]; then
  execute \
    "git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-plugins/zsh-nvm" \
    "zsh-nvm"
fi

execute "nvm install lts/iron" "Node.js 20.x"

execute "nvm install lts/hydrogen" "Node.js 18.x"
