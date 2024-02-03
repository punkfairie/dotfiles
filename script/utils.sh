#!/usr/bin/env sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

skip_questions() {
  while :; do
    case $1 in
    -y | --yes) return 0 ;;
    *) break ;;
    esac

    shift 1
  done

  return 1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ask_for_sudo() {
  sudo -v >/dev/null 2>&1

  # Update existing 'sudo' timestamp until this script has finished.
  #
  # https://gist.github.com/cowboy/3118588

  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done >/dev/null 2>&1 &
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_color() {
  string=$(echo "$1" | tr -s " ")

  printf "%b" \
    "$(tput setaf "$2" 2>/dev/null)" \
    "$string" \
    "$(tput sgr0 2>/dev/null)"
}

print_in_red() {
  print_in_color "$1" 1
}

print_in_yellow() {
  print_in_color "$1" 3
}

print_in_green() {
  print_in_color "$1" 2
}

print_in_purple() {
  print_in_color "$1" 5
}

print_title() {
  print_in_purple "\n • $1\n\n"
}

print_success() {
  print_in_green "   [✔] $1\n"
}

print_warning() {
  print_in_yellow "   [!] $1\n"
}

print_error() {
  print_in_red "   [✖] $1 $2\n"
}

print_question() {
  print_in_yellow "   [?] $1\n"
}

print_result() {
  if [ "$1" = 0 ]; then
    print_success "$2"
  else
    print_error "$2"
  fi

  return "$1"
}

print_error_stream() {
  while read -r line; do
    print_error "↳ ERROR: $line"
  done
}
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# https://stackoverflow.com/a/32270158
# POSIX read -n 1
# Usage: var="$(read_char)"
read_char() {
  old=$(stty -g)
  stty raw -echo min 0
  printf '%s' "$(dd bs=1 count=1 2>/dev/null)"
  stty "$old"
}

ask() {
  print_question "$1"
  read -r
}

get_answer() {
  printf "%s" "$REPLY"
}

ask_for_confirmation() {
  print_question "$1 (y/n) "
  REPLY="$(read_char)"
  printf "\n"
}

answer_is_yes() {
  expr "$REPLY" : '[Yy]$'
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

show_spinner() {
  readonly FRAMES='/-\|'

  readonly NUMBER_OF_FRAMES=${#FRAMES}

  readonly CMDS="$2"
  readonly MSG="$3"
  readonly PID="$1"

  i=0
  frame_text=""

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

  while kill -0 "$PID" >/dev/null 2>&1; do
    i=$((i + 1))
    num=$((i % NUMBER_OF_FRAMES))
    frame="$(echo $FRAMES | cut -c ${num}-$((num + 1)))"
    frame_text=" [$frame] $MSG"

    # Print frame text.
    printf "%s" "$frame_text"

    sleep 0.2

    # Clear frame text.
    tput rc
  done
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cmd_exists() {
  command -v "$1" >/dev/null 2>&1
}

is_git_repository() {
  git rev-parse >/dev/null 2>&1
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# https://stackoverflow.com/a/29835459
# POSIX compliant way of finding BASH_SOURCE
# Usage: sh_source "$0"
rreadlink() (
  target=$1
  fname=
  targetDir=
  CDPATH=

  {
    \unalias command
    \unset-f command
  } >/dev/null 2>&1
  # shellcheck disable=SC2034
  [ -n "$ZSH_VERSION" ] && options[POSIX_BUILTINS]=on

  while :; do
    [ -L "$target" ] || [ -e "$target" ] || {
      command printf '%s\n' "ERROR: $target does not exist." >&2
      return 1
    }
    # shellcheck disable=SC2164
    command cd "$(command dirname -- "$target")"
    fname=$(command basename -- "$target")
    [ "$fname" = '/' ] && fname=''

    if [ -L "$fname" ]; then
      target=$(command ls -l "$fname")
      target=${target#* -> }
      continue
    fi

    break
  done

  targetDir=$(command pwd -P)
  if [ "$fname" = '.' ]; then
    command printf '%s\n' "${targetDir%/}"
  elif [ "$fname" = '..' ]; then
    command printf '%s\n' "${targetDir%/}/$fname"
  fi
)

sh_source() {
  printf '%s' "$(dirname -- "$(rreadlink "$1")")"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set_trap() {
  trap | grep "'$2' $1" >/dev/null 2>&1 ||
    trap '$2' "$1"
}

kill_all_subproccesses() {
  i=""

  for i in $(jobs -p); do
    kill "$i"
    wait "$i" >/dev/null 2>&1
  done
}

execute() {
  readonly CMDS="$1"
  readonly MSG="${2:-$1}"

  readonly TMP_FILE
  TMP_FILE="$(mktemp /tmp/XXXXX)"

  exit_code=0
  cmds_pid=""

  # If the current process is ended, also end all its subproccesses.
  set_trap "EXIT" "kill_all_subproccesses"

  # Execute commands in background
  # shellcheck disable=SC2261
  eval "$CMDS" \
    >/dev/null 2>&1 \
    2>"$TMP_FILE" &

  cmds_pid=$!

  # Show a spinner if the commands require more time to complete.
  show_spinner "$cmds_pid" "$CMDS" "$MSG"

  # Wait for the commands to no longer be executing in the background, and then
  # get their exit code.
  wait "$cmds_pid" >/dev/null 2>&1
  exit_code=$?

  # Print output based on what happened.
  print_result $exit_code "$MSG"

  if [ $exit_code -ne 0 ]; then
    print_error_stream <"$TMP_FILE"
  fi

  rm -rf "$TMP_FILE"

  return $exit_code
}
