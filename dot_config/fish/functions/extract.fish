#!/usr/bin/env fish

# Extracts archived files / mounts disk images.
# Usage: extract <file>

function extract -a file
    set --erase argv[1]

    if test -f "$file"
        switch "$file"
            case "*.tar.bz2"
                tar -jxvf $argv "$file"
            case "*.tar.gz"
                tar -zxvf $argv "$file"
            case "*.bz2"
                bunzip2 $argv "$file"
            case "*.dmg"
                if test "$(uname)" = Darwin
                    hdiutil mount "$file"
                end
            case "*.gz"
                gunzip $argv "$file"
            case "*.tar"
                tar -xvf $argv "$file"
            case "*.tbz2"
                tar -jxvf $argv "$file"
            case "*.tgz"
                tar -zxvf $argv "$file"
            case "*.zip" "*.ZIP"
                set -f dir (string replace --ignore-case '.zip' '')
                mkdir "$dir"
                unzip $argv "$file" -d "$dir"
            case "*pax"
                cat "$file" | pax -r $argv
            case "*.pax.Z"
                uncompress "$file" --stdout | pax -r $argv
            case "*.rar"
                unrar x "$file"
            case "*.Z"
                uncompress $argv "$file"
            case "*"
                echo "'$file' cannot be extracted/mounted via extract()."
        end
    else
        echo "'$file' is not a valid file."
    end
end
