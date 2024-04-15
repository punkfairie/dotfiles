# mar does dotfiles

Welcome to my dotfiles :)

Feel free to steal what you like, though I'd advise against wholesale using my
config. Things are likely to break. At the very least - change the values in
dot_config/git/config.local.

I apologize for the disgusting Chezmoi format - I resisted it for ages and then
things got complex enough that I needed it.

The branches all contain previous iterations, with the exception of fish-shell
which was used to test out using fish as my login shell before committing.

# How to setup GPG because it makes me want to toss the computer out the window

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

set key (\
    gpg --list-secret-keys --keyid-format SHORT\
    | grep 'rsa4096'\
    | sed 's/sec   rsa4096\///'\
    | awk '{print $1}'\
)
copyq copy "$key"
```

```toml
# ~/.config/chezmoi/chezmoi.toml

[data]
gpgKey = # PASTE HERE
```

```fish
gpg --armor --export $key | copyq copy -
```

Go to <https://github.com/settings/keys> and add the copied key to your account.
