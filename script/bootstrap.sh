#!/usr/bin/env sh

readonly GITHUB_REPO="punkfairie/dotfiles"

readonly DOTFILES_ORIGIN="git@github.com:$GITHUB_REPO.git"
readonly DOTFILES_TARBALL="https://github.com/$GITHUB_REPO/tarball/main"
readonly DOTFILES_UTILS="https://raw.githubusercontent.com/$GITHUB_REPO/main/scripts/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

export DOT="$HOME/dotfiles" # MUST HAVE NO TRAILING SLASH!!
yes_to_all=false

################################################################################
#                              Download Dotfiles                               #
################################################################################

download() {
  url="$1"
  output="$2"

  if command -v "curl" >/dev/null 2>&1; then
    curl \
      --location \
      --silent \
      --show-error \
      --output "$output" \
      "$url" \
      >/dev/null 2>&1

    return $?

  elif command -v "wget" >/dev/null 2>&1; then
    wget \
      --quiet \
      --output-document="$output" \
      "$url" \
      >/dev/null 2>&1

    return $?
  fi

  return 1
}

download_utils() {
  tmp_file="$(mktemp /tmp/XXXXX)"

  # shellcheck source=/dev/null
  download "$DOTFILES_UTILS" "$tmp_file" &&
    . "$tmp_file" &&
    rm -rf "$tmp_file" &&
    return 0

  return 1
}

extract() {
  archive="$1"
  output_dir="$2"

  if command -v "tar" >/dev/null 2>&1; then
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

download_dotfiles() {
  print_title "Download and extract dotfiles archive"

  tmp_file="$(mktemp /tmp/XXXXX)"

  download "$DOTFILES_TARBALL" "$tmp_file"
  print_result $? "Download archive" "true"
  printf "\n"

  if ! $yes_to_all; then

    while [ -e "$DOT" ]; do
      ask "'$DOT' already exists, do you want to (o)verwrite or (b)ackup the existing directory?"
      answer="$(get_answer)"

      case $answer in
      o)
        rm -rf "$DOT"
        break
        ;;
      b)
        mv "$DOT" "$DOT.bak"
        break
        ;;
      *) print_warning "Please enter a valid option." ;;
      esac

    done

  else
    rm -rf "$DOT" >/dev/null 2>&1
  fi

  mkdir -p "$DOT"
  print_result $? "Create '$DOT'" "true"

  # Extract archive.
  extract "$tmp_file" "$DOT"
  print_result $? "Extract archive" "true"

  rm -rf "$tmp_file"
  print_result $? "Remove archive"

  cd "$DOT/script" ||
    return 1
}

################################################################################
#                                    Xcode                                     #
################################################################################

are_xcode_cli_tools_installed() {
  xcode-select --print-path >/dev/null 2>&1
}

install_xcode_cli_toools() {
  if [ "$(uname)" = "Darwin" ]; then

    print_title "Xcode"

    xcode-select --install >/dev/null 2>&1

    execute \
      "until are_xcode_cli_tools_installed; do sleep 5; done" \
      "Install Xcode Command Line Tools"

    sudo xcodebuild -license accept >/dev/null 2>&1
    print_result $? "Agree to the terms of the Xcode license"
  fi
}

################################################################################
#                               Setup Gitconfig                                #
################################################################################

setup_gitconfig() {
  cd "$DOT" || return

  if ! [ -f "$DOT/git/.gitconfig.local.symlink" ]; then
    print_title "Set up gitconfig"

    git_credential="cache"

    if [ "$(uname)" = "Darwin" ]; then
      git_credential="osxkeychain"
    fi

    print_question "What is your Github author name?"
    read -r git_authorname

    print_question "What is your Github author email?"
    read -r git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" \
      -e "s/AUTHOREMAIL/$git_authoremail/g" \
      -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" \
      "$DOT/git/.gitconfig.local.symlink.example" >"$DOT/.gitconfig.local.symlink"

    print_result $? "gitconfig"
  fi
}

################################################################################
#                             Initialize Git Repo                              #
################################################################################

git_init() {
  print_title "Initialize Git repository"

  if [ -z "$DOTFILES_ORIGIN" ]; then
    print_error "Please provide a URL for the Git origin"
    return 1
  fi

  if ! is_git_repository; then
    cd "$DOT" || print_error "Failed to cd $DOT"

    execute \
      "git init && git remote add origin $DOTFILES_ORIGIN" \
      "Initialize the dotfiles Git repository"
  fi
}

################################################################################
#                                     Main                                     #
################################################################################

main() {
  if [ "$(uname)" != "Linux" ] && [ "$(uname)" != "Darwin" ]; then
    printf "Sorry, this script is intended only for macOS and Ubuntu!"
    return 1
  fi

  # Load utils.

  if [ -x "${DOT}/script/utils.sh" ]; then
    . "${DOT}/script/utils.sh" || exit 1
  else
    download_utils || exit 1
  fi

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  skip_questions "$@" &&
    yes_to_all=true

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ask_for_sudo

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Check if this script was run directly, and if not, dotfiles will need to be
  # downloaded.

  printf "%s" "$(sh_source "$0")" | grep "bootstrap.sh" >/dev/null 2>&1 ||
    download_dotfiles

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  setup_gitconfig

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  install_xcode_cli_toools

  "$DOT/homebrew/brew.sh"

  "$DOT/git/git.sh"

  "$DOT/fish/fish.sh"

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if cmd_exists "git"; then
    if [ "$(git config --get remote.origin.url)" != "$DOTFILES_ORIGIN" ]; then
      git_init
    fi
  fi
}

main "$@"
