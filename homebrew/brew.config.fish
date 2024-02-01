#!/usr/bin/env fish

set -gx HOMEBREW_NO_ANALYTICS 1

if status --is-interactive
  eval (/usr/local/Homebrew/bin/brew shellenv fish)
end
