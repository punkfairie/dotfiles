#!/usr/bin/env fish

# Extracts archived files / mounts disk images.
# Usage: extract <file> <extra args>

function run_cmd --argument-names cmd
    set -f cmd_name (string split -f1 ' ' "$cmd")

    if command -v "$cmd" &>/dev/null
        eval "$cmd"
    else
        printf "Please install %s to extract this file.\n" "$cmd_name"
    end
end

function extract -a file
    set --erase argv[1]

    if test -f "$file"
        switch "$file"
            case "*.tar.bz2"
                run_cmd "tar -jxvf $argv $file"

            case "*.tar.gz"
                run_cmd "tar -zxvf $argv $file"

            case "*.bz2"
                run_cmd "bunzip2 $argv $file"

            case "*.dmg"
                if test "$(uname)" = Darwin
                    hdiutil mount "$file"
                end

            case "*.gz"
                run_cmd "gunzip $argv $file"

            case "*.tar"
                run_cmd "tar -xvf $argv $file"

            case "*.tbz2"
                run_cmd "tar -jxvf $argv $file"

            case "*.tgz"
                run_cmd "tar -zxvf $argv $file"

            case "*.zip" "*.ZIP"
                set -f dir (string replace --ignore-case '.zip' '')
                mkdir "$dir"
                run_cmd "unzip $argv $file -d $dir"

            case "*pax"
                run_cmd "cat $file | pax -r $argv"

            case "*.pax.Z"
                run_cmd "uncompress $file --stdout | pax -r $argv"

            case "*.rar"
                run_cmd "unrar x $file"

            case "*.Z"
                run_cmd "uncompress $argv $file"

            case "*"
                echo "'$file' cannot be extracted/mounted via extract()."
        end
    else
        echo "'$file' is not a valid file."
    end
end
