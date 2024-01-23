#!/usr/bin/env bash
# vim:set ft=bash:

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && . "../script/utils.sh"

################################################################################
#                                   Install                                    #
################################################################################

install()
{
  if test ! $(which brew); then
    NONINTERACTIVE=1 \
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
      &> /dev/null
    
    print_result $? "Install"
  fi
}

################################################################################
#                                 Add to Path                                  #
################################################################################

add_to_path()
{
  if command -v brew &> /dev/null; then
    return
  fi

  HARDWARE="$(uname -m)"
  prefix=""

  if [[ "$(uname)" == "Linux" ]]; then
    prefix="/home/linuxbrew/.linuxbrew"
  elif [[ "$HARDWARE" == "arm64" ]]; then
    prefix="/opt/homebrew"
  elif [[ "$HARDWARE" == "x86_64" ]]; then
    prefix="/usr/local"
  else
    print_error "Homebrew is only supported on macOS Intel/ARM or Linux!"
  fi

  PATH="$prefix/bin:$PATH"

  command -v brew &> /dev/null
  print_result $? "Add to PATH"
}

################################################################################
#                               Update & Upgrade                               #
################################################################################

update()
{
  execute "brew update" "Update"
}

upgrade()
{
  execute "brew upgrade" "Upgrade"
}

################################################################################
#                                     Main                                     #
################################################################################

main()
{
  print_title "Homebrew"
  
  install
  add_to_path

  update
  upgrade
}

main
