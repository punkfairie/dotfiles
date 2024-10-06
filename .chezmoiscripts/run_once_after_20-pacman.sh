#!/usr/bin/env bash

if command -v pacman-key &>/dev/null; then
  sudo pacman-key --init
  sudo pacman-key --populate archlinux
fi
