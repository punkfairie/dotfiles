# dotfiles

mar does dotfiles

# Pre Install

## macOS

- Grant full disk access to iTerm2 (System Preferences -> Security & Privacy ->
  Full Disk Access -> `+` Add iTerm2)

# Post Install

## Casks

```fish
open /usr/local/Caskroom/windscribe/[#.#.#]/windscribeInstaller.app

```

## iTerm2

Set iTerm2 to use the preferences folder ~/dotfiles/os/.

## fish

```fish
fish_config theme save "Catppuccin Mocha"
```

## tmux

```fish
tmux attach || tmux new -s main
```

`<ctrl-a I>` to install plugins.

# Sources

## Main

The overall structure and bootstrapping scripts are based heavily on these two
dotfile repos:

[holman does dotfiles](https://github.com/holman/dotfiles)

[Cătălin’s dotfiles](https://github.com/alrra/dotfiles)

## Others

### Dotfile Repos

[Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles)

### Misc

[oh-my-zsh git](https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index)

[git-prevision](https://gist.github.com/TheCodeArtist/a90978ebca0ff6743036)

[iTerm2 keymaps for tmux](https://web.archive.org/web/20230921160724/https://tangledhelix.com/blog/2012/04/28/iterm2-keymaps-for-tmux/)

[signing-git-commits](https://gist.github.com/phortuin/cf24b1cca3258720c71ad42977e1ba57)

[Correct_GnuPG_Permission](https://gist.github.com/oseme-techguy/bae2e309c084d93b75a9b25f49718f85)
