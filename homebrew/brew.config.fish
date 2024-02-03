#!/usr/bin/env fish

set -gx HOMEBREW_NO_ANALYTICS 1

if status --is-interactive
    if [ "$(uname -m)" = arm64 ]
        eval "$(/opt/homebrew/bin/brew shellenv fish)"
    else if [ "$(uname -m)" = x86_64 ]
        eval "$(/usr/local/bin/brew shellenv fish)"
    end
end
