#!/usr/bin/env fish

set -gx FZF_DEFAULT_CMD 'rg --files --hidden --glob "!.git"'

set -gx FZF_DEFAULT_OPTS "\
--margin=10%,5% \
--border=sharp \
--pointer=' ' \
--marker=' ' \
--prompt=' ' \
--preview-label-pos='bottom' \
--preview-window='border-sharp' \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# fzf.fish
set -g fzf_preview_dir_cmd eza --all --color=always --sort=name --group-directories-first
set -g fzf_diff_highlighter delta --paging=never --width=20
