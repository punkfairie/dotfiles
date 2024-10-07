#!/usr/bin/env fish

if command -v rvm &>/dev/null
    if status --is-interactive
        rvm use 3 &>/dev/null
    end
else if test -e /opt/homebrew/opt/ruby/bin/ruby
    fish_add_path /opt/homebrew/opt/ruby/bin/
end
