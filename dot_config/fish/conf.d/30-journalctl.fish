#!/usr/bin/env fish

if command -v journalctl &>/dev/null
    abbr -a jf --position command "sudo journalctl --follow --unit"
    abbr -a je --position command "sudo journalctl --pager-end --unit"
end
