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

## sources

[Cătălin’s dotfiles](https://github.com/alrra/dotfiles)

[oh-my-zsh git](https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index)

[git-prevision](https://gist.github.com/TheCodeArtist/a90978ebca0ff6743036)

[iTerm2 keymaps for tmux](https://web.archive.org/web/20230921160724/https://tangledhelix.com/blog/2012/04/28/iterm2-keymaps-for-tmux/)
