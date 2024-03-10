#!/usr/bin/env fish

function hack --description "Select a GH repo, [clone it], enter its directory"
    set -f repos $(gh repo list --source --no-archived --json name,description --jq '.[] | "\(.name) \u001b[1;30m\(.description)\u001b[0m"')
    set -f repo $(gum filter --height 10 $repos | string split ' ')[1]

    set -f path "$HOME/hackin/$repo"

    if test ! -d $path
        echo "Cloning $repo into $path..."
        gh repo clone $repo $path
    end

    cd $path
end
