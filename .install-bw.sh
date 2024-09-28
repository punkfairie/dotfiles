#!/usr/bin/env sh

type bw >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
	brew install bitwarden-cli
	;;
Linux)
	if command -v yay 2>&1; then
		yay -S bitwarden-cli
	elif command -v pacman 2>&1; then
		pacman -S bitwarden-cli
	elif command -v npm 2>&1; then
		npm install -g @bitwarden/cli
	else
		echo "unsupported OS"
		exit 1
	fi
	;;
esac
