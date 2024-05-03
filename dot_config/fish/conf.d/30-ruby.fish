#!/usr/bin/env fish

if command -v rvm &>/dev/null
    rvm use 3 &>/dev/null
else if test -e /opt/homebrew/opt/ruby/bin/ruby
    fish_add_path /opt/homebrew/opt/ruby/bin/
end
