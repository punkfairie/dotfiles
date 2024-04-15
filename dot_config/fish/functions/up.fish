function up --description "Update everything except pacman/yay"
    cd $HOME || exit 1

    if type -q brew
        set_color magenta && echo Homebrew && set_color normal
        brew update && brew upgrade
    end

    if type -q npm
        set_color magenta && echo npm && set_color normal
        npm up -g
    end

    if type -q tmux
        set_color magenta && echo tmux && set_color normal
        tmux_up
    end

    if type -q fish_update_completions
        set_color magenta && echo "fish completions" && set_color normal
        fish_update_completions
    end

    if type -q fisher
        set_color magenta && echo fisher && set_color normal
        fisher update
    end
end
