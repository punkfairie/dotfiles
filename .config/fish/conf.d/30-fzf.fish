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
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
