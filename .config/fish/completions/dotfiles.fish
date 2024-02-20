#!/usr/bin/env fish

set -l commands init clone ignore attributes readme

complete --command dotfiles --wraps git

# init
complete --command dotfiles \
    --condition "not __fish_seen_subcommand_from $commands" \
    --arguments init \
    --description "Create a new bare repo with the git folder specified"

complete --command dotfiles \
    --condition "__fish_seen_subcommand_from init; and not __fish_seen_subcommand_from (__fish_complete_directories)" \
    --arguments "(__fish_complete_directories)"

# clone
complete --command dotfiles \
    --condition "not __fish_seen_subcommand_from $commands" \
    --arguments clone \
    --description "Clone your dotfiles from remote and install them"

complete --command dotfiles \
    --condition "__fish_seen_subcommand_from clone; and not __fish_seen_subcommand_from (__fish_complete_directories)" \
    --arguments "(__fish_complete_directories)"

# ignore
complete --command dotfiles \
    --condition "not __fish_seen_subcommand_from $commands" \
    --arguments ignore \
    --description "Add a pattern to gitignore, or edit file if none given"

# attributes
complete -f --command dotfiles \
    --condition "not __fish_seen_subcommand_from $commands" \
    --arguments attributes \
    --description "Add a pattern to gitattributes, or edit file if none given"

# readme
complete -f --command dotfiles \
    --condition "not __fish_seen_subcommand_from $commands" \
    --arguments readme \
    --description "Edit the README.md file"
