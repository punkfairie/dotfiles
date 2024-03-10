#!/usr/bin/env fish

function tmux_up --description "Update tmux plugins"
    ~/.config/tmux/plugins/tpm/bin/install_plugins
    ~/.config/tmux/plugins/tpm/bin/clean_plugins
    ~/.config/tmux/plugins/tpm/bin/update_plugins all
end
