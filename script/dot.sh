#!/usr/bin/env bash
# vim:set ft=bash:

declare -r GITHUB_REPO="punkfairie/dotfiles"

declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPO.git"
declare -r DOTFILES_TARBALL="https://github.com/$GITHUB_REPO/tarball/main"
declare -r DOTFILES_UTILS="https://raw.githubusercontent.com/$GITHUB_REPO/main/scripts/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

declare dotfiles_dir="$HOME/dotfiles" # MUST HAVE NO LEADING SLASH!!
declare yes_to_all=false

################################################################################
#                              Download Dotfiles                               #
################################################################################

download()
{
  local url="$1"
  local output="$2"

  if command -v "curl" &> /dev/null; then
    curl \
      --location \
      --silent \
      --show-error \
      --output "$output" \
      "$url" \
      &> /dev/null

    return $?

  elif command -v "wget" &> /dev/null; then
    wget \
      --quiet \
      --output-document="$output" \
      "$url" \
      &> /dev/null

    return $?
  fi

  return 1
}

download_utils()
{
  local tmp_file=""

  tmp_file="$(mktemp /tmp/XXXXX)"

  download "$DOTFILES_UTILS" "$tmp_file" \
    && . "$tmp_file" \
    && rm -rf "$tmp_file" \
    && return 0

  return 1
}

extract()
{
  local archive="$1"
  local output_dir="$2"

  if command -v "tar" &> /dev/null; then
    tar \
      --extract \
      --gzip \
      --file "$archive" \
      --strip-components 1 \
      --directory "$output_dir"

    return $?
  fi

  return 1
}

download_dotfiles()
{
  local tmp_file=""

  print_title "Download and extract dotfiles archive"

  tmp_file="$(mktemp /tmp/XXXXX)"

  download "$DOTFILES_TARBALL" "$tmp_file"
  print_result $? "Download archive" "true"
  printf "\n"

  if ! $yes_to_all; then

    while [[ -e $dotfiles_dir ]]; do
      ask "'$dotfiles_dir' already exists, do you want to (o)verwrite or (b)ackup the existing directory?"
      answer="$(get_answer)"

      case $answer in
        o ) rm -rf "$dotfiles_dir"; break;;
        b ) mv "$dotfiles_dir" "$dotfiles_dir.bak"; break;;
        * ) print_warning "Please enter a valid option."
      esac

    done

  else
    rm -rf "$dotfiles_dir" &> /dev/null
  fi

  mkdir -p "$dotfiles_dir"
  print_result $? "Create '$dotfiles_dir'" "true"

  # Extract archive.
  extract "$tmp_file" "$dotfiles_dir"
  print_result $? "Extract archive" "true"

  rm -rf "$tmp_file"
  print_result $? "Remove archive"

  cd "$dotfiles_dir/script" \
    || return 1
}

################################################################################
#                                    Xcode                                     #
################################################################################

are_xcode_cli_tools_installed()
{
  xcode-select --print-path &> /dev/null
}

install_xcode_cli_toools()
{
  if [[ "$(uname)" == "Darwin" ]]; then

    print_title "Xcode"

    xcode-select --install &> /dev/null

    execute \
      "until are_xcode_cli_tools_installed; do sleep 5; done" \
      "Install Xcode Command Line Tools"

    sudo xcodebuild -license accept &> /dev/null
    print_result $? "Agree to the terms of the Xcode license"
  fi
}

################################################################################
#                               Setup Gitconfig                                #
################################################################################

setup_gitconfig()
{
  cd "$dotfiles_dir"

  if ! [[ -f $dotfiles_dir/git/.gitconfig.local.symlink ]]; then
    print_title "Set up gitconfig"

    git_credential="cache"

    if [[ "$(uname)" == "Darwin" ]]; then
      git_credential="osxkeychain"
    fi

    print_question "What is your Github author name?"
    read -e git_authorname

    print_question "What is your Github author email?"
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" \
      -e "s/AUTHOREMAIL/$git_authoremail/g" \
      -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
      $dotfiles_dir/git/.gitconfig.local.symlink.example > $dotfiles_dir/.gitconfig.local.symlink

    print_result $? "gitconfig"
  fi
}

################################################################################
#                               Install Dotfiles                               #
################################################################################

link_file()
{
  local src=$1
  local dst=$2

  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
    
    if ! $overwrite_all && ! $backup_all && ! $skip_all; then
      local current_src="$(readlink $dst)"

      if [[ "$current_src" == "$src" ]]; then
        skip=true

      else
        print_question "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
          [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o ) overwrite=true ;;
          O ) overwrite_all=true ;;
          b ) backup=true ;;
          B ) backup_all=true ;;
          s ) skip=true ;;
          S ) skip_all=true ;;
          * ) ;;
        esac
      fi
    
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}
    
    if $overwrite; then
      rm -rf "$dst"
      print_success "Removed $dst"
    fi

    if $backup; then
      mv "$dst" "${dst}.bak"
      print_success "Moved $dst to ${dst}.bak"
    fi

    if $skip; then
      print_success "Skipped $src"
    fi

  fi

  if [[ $skip != "true" ]]; then # "false" or empty

    # See if any directories need to be created
    if [[ "$dst" =~ '/' ]]; then
      mkdir -p "${dst%/*}"
    fi

    ln -s "$src" "$dst"
    print_success "Linked $src to $dst"
  fi
}

install_dotfiles()
{
  print_title "Installing dotfiles"

  local overwrite_all=false
  local backup_all=false
  local skip_all=false

  for src in $(find -H "$dotfiles_dir" -maxdepth 5 -name "*.symlink" -not -path ".git"); do
    dst="${src%.*}"
    dst="${dst#$dotfiles_dir/}"
    dst="${dst#*/}"
    dst="$HOME/$dst"
    link_file "$src" "$dst"
  done
}

################################################################################
#                             Initialize Git Repo                              #
################################################################################

git_init()
{
  print_title "Initialize Git repository"

  if [[ -z "$DOTFILES_ORIGIN" ]]; then
    print_error "Please provide a URL for the Git origin"
    return 1
  fi

  if ! is_git_repository; then
    cd $dotfiles_dir || print_error "Failed to cd $dotfiles_dir"

    execute \
      "git init && git remote add origin $DOTFILES_ORIGIN" \
      "Initialize the dotfiles Git repository"
  fi
}

################################################################################
#                                  Restart OS                                  #
################################################################################

restart_os()
{
  print_title "Restart"

  ask_for_confirmation "Do you want to restart?"
  printf "\n"

  if answer_is_yes; then
    sudo shutdown -r now &> /dev/null
  fi
}

################################################################################
#                                     Main                                     #
################################################################################

main()
{
  if [[ "$(uname)" != "Linux" ]] && [[ "$(uname)" != "Darwin" ]]; then
    printf "Sorry, this script is intended only for macOS and Ubuntu!"
    return 1
  fi

  # Load utils.

  if [[ -x "${dotfiles_dir}/script/utils.sh" ]]; then
    . "${dotfiles_dir}/script/utils.sh" || exit 1
  else
    download_utils || exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  skip_questions "$@" \
    && yes_to_all=true

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  ask_for_sudo

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  # Check if this script was run directly, and if not, dotfiles will need to be
  # downloaded.

  printf "%s" "${BASH_SOURCE[0]}" | grep "dot.sh" &> /dev/null \
    || download_dotfiles

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  setup_gitconfig

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  install_dotfiles

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  $dotfiles_dir/os/pref.sh

  install_xcode_cli_toools

  $dotfiles_dir/homebrew/brew.sh

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  print_title "Installers"
  find . -name install.sh | while read installer ; do sh -c "${installer}" ; done

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  if cmd_exists "git"; then
    if [[ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]]; then
      git_init
    fi
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  
  if ! $yes_to_all; then
    restart_os
  fi
}

main "$@"
