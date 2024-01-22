#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Shell aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias rl=". ~/.zshrc"
alias c="clear"
alias e="$EDITOR"

# Help alias
autoload -Uz run-help
autoload -Uz run-help-git
alias help=run-help

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Location alias
alias hack="cd ~/hackin"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Default command options

alias cp="cp -iv"
#             │└─ list copied files
#             └─ prompt before overwriting an existing file

alias mkdir="mkdir -pv"
#                   │└─ list created directories
#                   └─ create intermediate directories

alias mv="mv -iv"
#             │└─ list moved files
#             └─ prompt before overwriting an existing file

alias rm="rm -rf --"

# Colored grep output
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Recursively delete `.DS_Store` files
alias dscleanup="find . -type f -name '*.DS_Store' -ls -delete"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

shared_update_cmds="brew update && brew upgrade && brew cleanup; \
  npm install npm -g && npm update -g; \
  sudo gem update --system && sudo gem update && sudo gem cleanup"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Mac aliases

if [[ "$(uname)" == "Darwin" ]]; then

  alias clear-dns-cache="sudo dscacheutil -flushcache; \
    sudo killall -HUP mDNSResponder"

  alias o="open"

  alias u="sudo softwareupdate --install --all; $shared_update_cmds"

  # Show/hide hidden files in Finder
  alias showhid="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hidehid="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  # Merge PDF files, preserving hyperlinks
  # Usage: `mergepdf input{1,2,3}.pdf`
  alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ubuntu aliases

if [[ "$(uname)" == "Linux" ]]; then

  alias 0="xdg-open"

  alias u="sudo apt update && sudo apt upgrade; $shared_update_cmds"

fi
