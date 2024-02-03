#!/usr/bin/env fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Shell aliases.
abbr -a rl --position command "source ~/.config/fish/config.fish"
abbr -a c --position command clear
abbr -a e --position command "$EDITOR"
abbr -a v --position command "$EDITOR"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Location aliases.
abbr -a hack --position command "cd ~/hackin"

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
