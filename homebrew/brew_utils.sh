#!/user/bin/env sh

. "$DOT/script/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_prefix() {
  path=""

  if path="$(brew --prefix 2>/dev/null)"; then
    printf "%s" "$path"
    return 0
  else
    print_error "Homebrew (get prefix)"
    return 1
  fi
}

brew_tap() {
  brew tap "$1" >/dev/null 2>&1
}

brew_update() {
  execute "brew update" "Homebrew (update)"
}

brew_upgrade() {
  execute "brew upgrade" "Homebrew (upgrade)"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

brew_install() {
  readonly FORMULA_READABLE_NAME="$1"
  readonly FORMULA="$2"
  readonly ARGUMENTS="$3"
  readonly TAP_VALUE="$4"

  # Check that Homebrew is installed.

  if ! cmd_exists "brew"; then
    print_error "$FORMULA_READABLE_NAME ('Homebrew' is not installed)"
    return 1
  fi

  # If 'brew tap' needs to be executed, check if it executed correctly.

  if [ -n "$TAP_VALUE" ]; then
    if ! brew_tap "$TAP_VALUE"; then
      print_error "$FORMULA_READABLE_NAME ('brew tap $TAP_VALUE' failed)"
      return 1
    fi
  fi

  # Install the specified formula.

  # shellcheck disable=SC2086
  if brew list "$FORMULA" >/dev/null 2>&1; then
    print_success "$FORMULA_READABLE_NAME"
  else
    execute "brew install $FORMULA $ARGUMENTS" \
      "$FORMULA_READABLE_NAME"
  fi
}
