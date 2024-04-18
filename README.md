# mar does dotfiles

Welcome to my dotfiles :)

Feel free to steal what you like, though I'd advise against wholesale using my
config. Things are likely to break. At the very least - change the values in
dot_config/git/config.local.

I apologize for the disgusting Chezmoi format - I resisted it for ages and then
things got complex enough that I needed it.

The branches all contain previous iterations, with the exception of fish-shell
which was used to test out using fish as my login shell before committing.

## First-Time Setup

### GPG makes me want to toss the computer out the window

```fish
gpg --full-gen-key
# kind of key: 4
# key size: 4096
# expiration: 0 && y
# real name: punkfairie
# email: 23287005+punkfairie@users.noreply.github.com

sudo -k
chown -R (whoami) "$HOME/.gnupg/"
find "$HOME/.gnupg" -type f -exec chmod 600 {} \;
find "$HOME/.gnupg" -type d -exec chmod 700 {} \;

chezmoi init --apply punkfairie
```

### Arch

```fish
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin

yay -Syu
yay -S --needed - < ~/.config/packages/arch

gpg --armor --export (get-gpg-key) | copyq copy -
```

### General

Go to <https://github.com/settings/keys> and add the copied key to your account.

```fish
volta install node
topgrade
```

## Themes

### GRUB

```conf
# /etc/default/grub
GRUB_THEME="/usr/share/grub/themes/catppuccin-<flavor>/theme.txt"
```

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

### SDDM

### TTY

```fish
git clone https://github.com/catppuccin/tty.git
cd tty
./generate.sh <flavor> | copyq copy -
```

Edit `/etc/default/grub` and append copied content to `GRUB_CMDLINE_LINUX`.

`sudo grub-mkconfig -o /boot/grub/grub.cfg`
