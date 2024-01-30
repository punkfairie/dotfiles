#!/usr/bin/env fish
# vim:set ft=fish :

set -q DOT || set -gx DOT "$HOME/dotfiles"

source "$DOT/script/utils.fish"

################################################################################
#                                OS Preferences                                #
################################################################################

function set_os_prefs
  print_title "OS Preferences"

  set os $(uname | string lower)

  "$DOT/os/$os.fish"
end

################################################################################
#                               Symlink Dotfiles                               #
################################################################################

function link_file -a $src $dst
  set -f action

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
    
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
            set -f overwrite true
          case O
            set -f overwrite_all true
          case b
            set -f backup true
          case B
            set -f backup_all true
          case s
            set -f skip true
          case S
            set -f skip_all true
        end
      end
    end

    set -q overwrite || set overwrite $overwrite_all
    set -q backup || set backup $backup_all
    set -q skip || set skip $skip_all

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

  if ! $skip
    # See of any directories need to be created.
    if echo "$dst" | grep -q '/' 2> /dev/null
      mkdir -p (string replace -r '\/[^\/]+$' '' "$dst")
    end

    if string match -e '.hardlink' "$src" &> /dev/null
      ln "$src" "$dst" &> /dev/null
    else
      ls -s "$src" "$dst" &> /dev/null
    end

    print_success "Linked $src to $dst"
  end
end

function make_dst -a $src
  set -l path (string replace -a '/' '\/' "$DOT")
  set -l regex (string join '' '^' "$path" '\/[a-zA-Z]+\/(.+)\.symlink$')
  set -l dst (string replace -r $regex '$1' "$src")

  printf '%s' "$HOME/$dst"
end

function install_dotfiles
  print_title "Installing Dotfiles"

  set -g overwrite_all false
  set -g backup_all false
  set -g skip_all false

  for src in (find -H "$DOT" -name "*.symlink" -not -path ".git")
    link_file $src (make_dst $src)
  end
end

################################################################################
#                                     Main                                     # 
################################################################################

# Ensure npm is available.

"$DOT/node/volta.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_os_prefs

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_title "Installers"
find . -name install.fish | while read installer; fish -c "$installer"; end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_dotfiles
