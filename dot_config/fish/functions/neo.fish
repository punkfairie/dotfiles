#!/usr/bin/env fish

function neo --wraps neo-matrix
    neo-matrix --charset=ascii $argv
end
