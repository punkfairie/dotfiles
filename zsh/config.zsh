#!/usr/bin/env zsh

export EDITOR=nvim
export VISUAL="$EDITOR"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# https://linux.die.net/man/1/zshoptions
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS   # allow functions to have local traps

setopt PROMPT_SUBST # perform expansion & subsitution in prompts

setopt HIST_VERIFY          # perform history expansion (see man page linked above)
setopt HIST_IGNORE_ALL_DUPS # delete older duplicates
setopt HIST_REDUCE_BLANKS   # remove superfluous blanks
setopt SHARE_HISTORY        # share history between sessions via the $HISTFILE

setopt COMPLETE_ALIASES # don't expand aliases before attempting completion
