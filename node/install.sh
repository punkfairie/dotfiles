#!/usr/bin/env zsh

cd "$(dirname ${(%):-%x})" \
  && source "../script/utils.sh"

execute \
  "if ! [ -d \"$HOME/.zsh-plugins/zsh-nvm\" ]; then git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh-plugins/zsh-nvm; fi" \
  "zsh-nvm"

source "./nvm.zsh"

execute "nvm install lts/iron" "Node.js 20.x"

execute "nvm install lts/hydrogen" "Node.js 18.x"
