#!/usr/bin/env fish

source "$DOT/script/utils.fish"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function package_is_installed -a pkg
  dpkg -s "$pkg" &>/dev/null
end

function install_package -a pkg_readable_name pkg args
  if ! package_is_installed "$pkg"
    execute \
      "sudo apt-get install --allow-authenticated -qqy $args $pkg" "$pkg_readable_name"
      #                            suppress output ─┘│
      #  assume "yes" as the answer to all prompts ──┘
  else
    print_success "$pkg_readable_name"
  end
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function add_key -a key
  wget -q0 - "$key" | sudo apt-key add - &> /dev/null
  #     │└─ write output to file
  #     └─ don't show output
end

function add_ppa -a ppa
  sudo add-apt-repository -y ppa:"$ppa" &>/dev/null
end

function add_to_source_list -a source list
  sudo sh -c "printf 'deb $source' >> '/etc/apt/sources.list.d/$list'"
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function apt_update
  execute "sudo apt-get update -qqy" "APT (update)"
end

function apt_upgrade
  execute \
    "export DEBIAN_FRONTEND=\"noninteractive\" \
      && sudo apt-get -o Dpkg::Options::=\"--force-confnew\" upgrade -qqy" \
    "APT (upgrade)"
end

function apt_autoremove
  execute "sudo apt-get autoremove -qqy" "APT (autoremove)"
end
