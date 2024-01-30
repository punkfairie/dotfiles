#!/user/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function brew_prefix
  set -f path (brew --prefix 2>/dev/null)

  if [ -n $path ]
    printf '%s' "$path"
    return 0
  else
    print_error "Homebrew (get prefix)"
    return 1
  end
end

function brew_tap -a tap
  brew tap "$tap" &>/dev/null
end

function brew_update
  execute "brew update" "Homebrew (update)"
end

function brew_upgrade
  execute "brew upgrade" "Homebrew (upgrade)"
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function brew_install -a formula_readable_name formula arguments tap_value
  # Check that Homebrew is installed
  if ! cmd_exists "brew"
    print_error "$formula_readable_name ('Homebrew' is not installed)"
  end

  # If 'brew tap' needs to be executed, check if it executed correctly.
  if [ -n "$tap_value" ]
    if ! brew_tap "$tap_value"
      print_error "$formula_readable_name ('brew tap $tap_value' failed)"
      return 1
    end
  end

  # Install the formula.
  if brew list "$formula" &>/dev/null
    print_success "$formula_readable_name"
  else
    execute "brew install $formula $arguments" \
      "$formula_readable_name"
  end
end
