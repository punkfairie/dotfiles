#!/usr/bin/env fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Shell aliases.
abbr -a rl --position command "source ~/.config/fish/config.fish"
abbr -a c --position command clear
abbr -a e --position command "$EDITOR"
abbr -a v --position command "$EDITOR"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Location aliases.
abbr -a hack --position command "cd $HACK"
abbr -a dotf --position command "cd $DOT"
abbr -a dote --position command "cd $DOT && $EDITOR"

abbr -a nvdir --position command "cd $NVIM"
abbr -a nved --position command "cd $NVIM && $EDITOR"
abbr -a nvl --position command "cd $NVLUA"
abbr -a nvled --position command "cd $NVLUA && $EDITOR"
abbr -a nvc --position command "cd $NVCUSTOM"
abbr -a nvced --position command "cd $NVCUSTOM && $EDITOR"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Default command options.

abbr -a cp --position command "cp -iv"
#                                  │└─ list copied files
#                                  └─ prompt before overwriting an existing file

abbr -a mkdir --position command "mkdir -pv"
#                                        │└─ list created directories
#                                        └─ create intermediate directories

abbr -a mv --position command "mv -iv"
#                                  │└─ list moved files
#                                  └─ prompt before overwriting an existing file

abbr -a rm --position command "rm -rf"
#                                  │└─ do not ask for confirmation
#                                  └─ recursively remove directories and files

# Colored grep output.
abbr -a grep --position command "grep  --color=auto"
abbr -a fgrep --position command "fgrep --color=auto"
abbr -a egrep --position command "egrep --color=auto"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Combinations.

function mkcd -d "Make a directory and CD into it"
    mkdir "$argv" && cd "$argv"
end

function cdls -d "CD into a directory and list its contents"
    cd "$argv" && ls
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# eza.

function ls --wraps eza
    eza --all --icons=auto --sort=name --group-directories-first $argv
end

function lsl --wraps eza
    eza --all --icons=auto --sort=name --group-directories-first --grid --long \
        --git --header $argv
end
