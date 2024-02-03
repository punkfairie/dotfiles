#!/usr/bin/env fish

source "$DOT/script/utils.fish"
source "$DOT/homebrew/brew_utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_subtitle Git

brew_install "Github CLI" gh
execute \
    "git clone https://gitlab.com/raabf/gitmoji-fuzzy-hook.git ~/.local/share/gitmoji-fuzzy-hook && \
     ln -f -s ~/.local/share/gitmoji-fuzzy-hook/bin/gitmoji-fuzzy-hook-init.sh $HOME/bin/gitmoji-fuzzy-hook-init" \
    gitmoji-fuzzy-hook
