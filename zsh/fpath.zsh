#!/usr/bin/env zsh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

if [[ -d "$DOT/functions" ]]; then
  fpath=($DOT/functions $fpath)
  { autoload -U $DOT/functions/*(:t); } &> /dev/null
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Add each topic folder to fpath so that they can
# add functions and completion scripts.
for topic_folder ($DOT/*) if [ -d $topic_folder ]; then
  fpath=($topic_folder $fpath)
fi
