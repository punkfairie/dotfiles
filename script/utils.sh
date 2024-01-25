#!/usr/bin/env bash
# vim:set ft=bash:

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

skip_questions()
{
  while :; do
    case $1 in
      -y | --yes ) return 0 ;;
      * ) break ;;
    esac

    shift 1
  done

  return 1 
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

ask_for_sudo()
{
  sudo -v &> /dev/null

  # Update existing 'sudo' timestamp until this script has finished.
  #
  # https://gist.github.com/cowboy/3118588

  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

print_in_color()
{
  printf "%b" \
    "$(tput setaf "$2" 2> /dev/null)" \
    "$1" \
    "$(tput sgr0 2> /dev/null)"
}

print_in_red()
{
  print_in_color "$1" 1
}

print_in_yellow()
{
  print_in_color "$1" 3
}

print_in_green()
{
  print_in_color "$1" 2
}

print_in_purple()
{
  print_in_color "$1" 5
}

print_title()
{
  print_in_purple "\n • $1\n\n"
}

print_success()
{
  print_in_green "   [✔] $1\n"
}

print_warning()
{
  print_in_yellow "   [!] $1\n"
}

print_error()
{
  print_in_red "   [✖] $1 $2\n"
}

print_question()
{
  print_in_yellow "   [?] $1\n"
}

print_result()
{
  if [[ "$1" == 0 ]]; then
    print_success "$2"
  else
    print_error "$2"
  fi

  return "$1"
}

print_error_stream()
{
  while read -r line; do
    print_error "↳ ERROR: $line"
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

ask()
{
  print_question "$1"
  read -r
}

get_answer()
{
  printf "%s" "$REPLY"
}

ask_for_confirmation()
{
  print_question "$1 (y/n) "
  read -r -n 1
  printf "\n"
}

answer_is_yes()
{
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

show_spinner()
{
  local -r FRAMES='/-\|'

  # shellcheck disable=SC2034
  local -r NUMBER_OF_FRAMES=${#FRAMES}

  local -r CMDS="$2"
  local -r MSG="$3"
  local -r PID="$1"

  local i=0
  local frame_text=""

  # Provide more space so that the text hopefully doesn't reach the bottom line
  # of the terminal window.
  #
  # This is a workaround for escape sequences not tracking the buffer position
  # (accounting for scrolling).
  #
  # See also: https://unix.stackexchange.com/a/278888

  printf "\n\n\n"
  tput cuu 3
  tput sc

  while kill -0 "$PID" &> /dev/null; do
    frame_text="   [${FRAMES:$((i++%NUMBER_OF_FRAMES)):1}] $MSG"

    # Print frame text.
    printf "%s" "$frame_text"

    sleep 0.2

    # Clear frame text.
    tput rc
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

cmd_exists()
{
  command -v "$1" &> /dev/null
}

is_git_repository()
{
  git rev-parse &> /dev/null
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

set_trap()
{
  trap -p "$1" | grep "$2" &> /dev/null \
    || trap "$2" "$1"
}

kill_all_subproccesses()
{
  local i=""

  for i in $(jobs -p); do
    kill "$i"
    wait "$i" &> /dev/null
  done
}

execute()
{
  local -r CMDS="$1"
  local -r MSG="${2:-$1}"
  local -r TMP_FILE="$(mktemp /tmp/XXXXX)"

  local exit_code=0
  local cmds_pid=""

  # If the current process is ended, also end all its subproccesses.
  set_trap "EXIT" "kill_all_subproccesses"

  # Execute commands in background
  # shellcheck disable=SC2261
  eval "$CMDS" \
    &> /dev/null \
    2> "$TMP_FILE" &

  cmds_pid=$!

  # Show a spinner if the commands require more time to complete.
  show_spinner "$cmds_pid" "$CMDS" "$MSG"

  # Wait for the commands to no longer be executing in the background, and then
  # get their exit code.
  wait "$cmds_pid" &> /dev/null
  exit_code=$?

  # Print output based on what happened.
  print_result $exit_code "$MSG"

  if [[ $exit_code -ne 0 ]]; then
    print_error_stream < "$TMP_FILE"
  fi

  rm -rf "$TMP_FILE"

  return $exit_code
}
