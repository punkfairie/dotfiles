#!/usr/bin/env fish

set -q DOT || set -gx DOT "$HOME/dotfiles"

set -g yes_to_all false

source "$DOT/script/utils.fish"

################################################################################
#                                OS Preferences                                #
################################################################################

function set_os_prefs
    print_title "OS Preferences"

    set -f os $(uname | string lower)
    set -f file "$DOT/os/$os.fish"

    if [ -e "$file" -a -x "$file" ]
        "$file"
    end
end

################################################################################
#                               Symlink Dotfiles                               #
################################################################################

function link_file -a src dst
    set -f action

    set -f overwrite ""
    set -f backup ""
    set -f skip ""

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]

        if ! $overwrite_all && ! $backup_all && ! $skip_all
            set -f current_src (readlink "$dst")

            if [ "$current_src" = "$src" ]
                set -f skip true
            else
                print_question "File already exists: $dst ($(basename $src)), what do you want to do?"
                print_question "([s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all)"
                read -n 1 action

                switch $action
                    case o
                        set overwrite true
                    case O
                        set overwrite_all true
                    case b
                        set backup true
                    case B
                        set backup_all true
                    case s
                        set skip true
                    case S
                        set skip_all true
                end
            end
        end

        if [ -z "$overwrite" ]
            set overwrite $overwrite_all
        end

        if [ -z "$backup" ]
            set backup $backup_all
        end

        if [ -z $skip ]
            set skip $skip_all
        end

        if $overwrite
            rm -rf "$dst"
            print_success "Removed $dst"
        end

        if $backup
            mv "$dst" "{$dst}.bak"
            print_success "Moved $dst to {$dst}.bak"
        end

        if $skip
            print_success "Skipped $src"
        end
    end

    if [ -z $skip ] || ! $skip
        # See of any directories need to be created.
        if echo "$dst" | grep -q / 2>/dev/null
            mkdir -p (string replace -r '\/[^\/]+$' '' "$dst")
        end

        if string match -e '.hardlink' "$src" &>/dev/null
            ln "$src" "$dst" &>/dev/null
        else
            ln -s "$src" "$dst" &>/dev/null
        end

        print_success "Linked $src to $dst"
    end
end

function install_dotfiles
    print_title "Installing Dotfiles"

    set -g skip_all false
    set -g overwrite_all false
    set -g backup_all false

    if set -q yes_to_all && $yes_to_all
        set skip_all true
    else if set -q _flag_s
        set skip_all true
    end

    if set -q _flag_o
        set overwrite_all true
    end

    if set -q _flag_b
        set backup_all true
    end

    set -l path (string replace -a '/' '\/' "$DOT")
    set -l regex (string join '' '^' "$path" '\/[a-zA-Z]+\/(.+)\.(sym|hard)link$')

    for src in (find -H "$DOT" -name "*.symlink" -or -name "*.hardlink" -not -path ".git")
        link_file $src "$HOME/$(string replace -r $regex '$1' "$src")"
    end
end

################################################################################
#                                     Main                                     #
################################################################################

argparse y/yes-to-all s/skip o/overwrite b/backup -- $argv

if set -q _flag_y
    set yes_to_all true
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ensure npm is available.

"$DOT/node/volta.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_os_prefs

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_title Installers
find . -name install.fish | while read installer
    fish -c "$installer"
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dotfiles
