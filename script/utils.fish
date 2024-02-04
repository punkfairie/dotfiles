#!/usr/bin/env fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function print_in_color -a text color
    printf '%b' \
        "$(tput setaf $color 2> /dev/null)" \
        $text \
        "$(tput sgr0 2> /dev/null)"
end

function print_in_red -a text
    print_in_color $text 1
end

function print_in_yellow -a text
    print_in_color $text 3
end

function print_in_green -a text
    print_in_color $text 2
end

function print_in_cyan -a text
    print_in_color $text 6
end

function print_in_purple -a text
    print_in_color $text 5
end

function print_title -a text
    print_in_purple "\n 󰣐 $text\n\n"
end

function print_subtitle -a text
    print_in_cyan "\n  $text\n"
end

function print_success -a text
    print_in_green "   [✔] $text\n"
end

function print_warning -a text
    print_in_yellow "   [!] $text\n"
end

function print_error -a text text2
    print_in_red "   [✖] $text $text2\n"
end

function print_question -a text
    print_in_yellow "   [?] $text\n"
end

function print_result -a exit_code text
    if [ "$exit_code" -eq 0 ]
        print_success $text
    else
        print_error $text
    end

    return $exit_code
end

function print_error_stream
    while read -l line
        print_error "↳ ERROR: $line"
    end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function show_spinner -a pid cmds msg
    set -f frames '/-\|'

    set -f number_of_frames (string length $frames)

    set -f i 0
    set -f frame_text ""

    printf "\n\n\n"
    tput cuu 3
    tput sc

    while kill -0 "$pid" &>/dev/null
        set i (math "$i + 1")
        set -l num (math "($i % $number_of_frames) + 1")

        set -l frame (string sub -s $num -l 1 $frames)

        set frame_text "   [$frame] $msg"

        printf '%s' $frame_text

        sleep 0.2

        tput rc
    end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function set_trap -a sig func
    trap -p "$sig" | grep "$func" &>/dev/null \
        || trap "$func" "$sig"
end

function kill_all_subproccesses
    set -l i ""

    for i in (jobs -p)
        kill "$i"
        wait "$i" &>/dev/null
    end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function execute -a cmds msg
    if ! set -q msg
        set -f msg "$cmds"
    end

    set -l tmp_file "$(mktemp /tmp/XXXXX)"

    set -g exit_code 0

    set_trap EXIT kill_all_subproccesses

    fish -c "$cmds" >/dev/null 2>$tmp_file &
    set cmds_pid (jobs -lp)

    function _exited_$cmds_pid --on-process-exit $cmds_pid -S
        set -g exit_code $argv[3]
        functions -e _exited_$cmds_pid
    end

    show_spinner $cmds_pid $cmds $msg

    wait $cmds_pid &>/dev/null

    print_result $exit_code $msg

    if [ $exit_code -ne 0 ]
        print_error_stream <$tmp_file
    end

    rm -rf "$tmp_file"

    return $exit_code
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function cmd_exists -a cmd
    command -v "$cmd" &>/dev/null
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function ask_for_sudo
    sudo -v &>/dev/null

    # Update existing 'sudo' timestamp until this script has finished.
    #
    # https://gist.github.com/cowboy/3118588

    while true
        sudo -n true
        sleep 60
        kill -0 "$fish_pid" || exit
    end &>/dev/null &
end
