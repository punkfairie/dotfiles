#!/usr/bin/env fish

abbr -a g --position command git

################################################################################
#                                  Functions                                   #
################################################################################

function git_develop_branch
    command git rev-parse --git-dir &>/dev/null || return
    set -l branch

    for branch in dev devel develop development
        if command git show-ref -q --verify refs/heads/$branch
            echo $branch
            return 0
        end
    end

    echo develop
    return 1
end

function git_main_branch
    command git rev-parse --git-dir &>/dev/null || return
    set -l ref

    for ref in
        refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}
        if command git show-ref -q --verify $ref
            echo (basename $ref)
            return 0
        end
    end

    echo main
    return 1
end

function git_current_branch
    set -l ref (git symbolic-ref --quiet HEAD 2>/dev/null)
    set -l ret $status

    if [ $ret -ne 0 ]
        [ $ret -eq 128 ] && return # no git repo
        set ref (git rev-parse --short HEAD 2>/dev/null) || return
    end

    echo (string replace "refs/heads/" "" $ref)
end

################################################################################
#                                   Staging                                    #
################################################################################

abbr -a ga --position command "git add"
abbr -a gaa --position command "git add --all"

# Interactively stage parts of a file.
abbr -a gapa --position command "git add --patch"

abbr -a gda --position command "git diff"
abbr -a gdas --position command "git diff --staged"
abbr -a gdaw --position command "git diff --word-diff" # show diff by word
abbr -a gdasw --position command "git diff --staged --word-diff"

set exclude ":(exclude)package-lock.json" ":(exclude)*.lock"

function gd --wraps "git diff"
    git diff $argv $exclude
end

function gds --wraps "git diff"
    git diff --staged $argv $exclude
end

function gdw --wraps "git diff"
    git diff --word-diff $argv $exclude
end

function gdsw --wraps "git diff"
    git diff --staged --word-diff $argv $exclude
end

abbr -a gst --position command "git status --short --branch"
abbr -a gstl --position command "git status"

################################################################################
#                                  Committing                                  #
################################################################################

abbr -a gc --position command "git commit"
abbr -a "gc!" --position command "git commit --amend"
abbr -a "gcn!" --position command "git commit --no-edit --amend"
abbr -a gca --position command "git add --all && git commit"
abbr -a "gca!" --position command "git add --all && git commit --amend"
abbr -a "gcan!" --position command "git add --all && git commit --no-edit --amend"
abbr -a gcam --position command "git add --all && git commit -m"
abbr -a gcmsg --position command "git commit -m"
abbr -a gcfu --position command "git commit --fixup"

abbr -a grev --position command "git revert"

################################################################################
#                       Working Dir & Index Manipulation                       #
################################################################################

abbr -a gco --position command "git checkout"

abbr -a grt --position command "git reset"
# grt <commit> -- [<path>] - undo <commit> but keep changes in working dir.

abbr -a grts --position command "git reset --soft"
# Undo commits and stage their changes.

abbr -a grs --position command "git restore --worktree"
# grs <unstaged-path> - revert local changes for <unstaged-path>.
# (--worktree is the default behavior, but included here for clarity).

abbr -a grss --position command "git restore --worktree --source"
# grss <commit> <unstaged-path> - revert <unstaged-path> to <commit>"s version.

abbr -a grst --position command "git restore --staged"
# grst <staged-path> - unstage <staged-path>

abbr -a grsts --position command "git restore --staged --source"
# See grss, but for <staged-path>s.

abbr -a grsa --position command "git restore --worktree --staged"
# grsa <path> - discard all changes for <path>, both staged and unstaged.

abbr -a grsas --position command "git restore --worktree --staged --source"

abbr -a grm --position command "git rm"
# Remove paths from index & working dir.

abbr -a grmc --position command "git rm --cached"
# Unstage & remove only from index; leave in working dir.
# grmc <path> - where <path> is already tracked: stages the removal of <path>

abbr -a gsta --position command "git stash push"
# Save changes; add --message <message> to label stash.

abbr -a gstaa --position command "git stash push --include-untracked"
abbr -a gstap --position command "git stash pop" # retrieve changes
abbr -a gstal --position command "git stash list" # list stashes

abbr -a gstas --position command "git stash show --text"
# --text treats all files as text.

function gwip
    git add -A
    git rm (git ls-files --deleted) 2>/dev/null
    git commit --no-verify --no-gpg-sign --message "🚧 --wip-- [skip ci]"
end

function gunwip
    git rev-list --max-count=1 --format="%s" HEAD | grep -q "🚧 --wip--" \
        && git reset HEAD~1
end

abbr -a gcl --position command "git clean -f"
# Remove unknown (untracked and unignored) files.

abbr -a gcldr --position command "git clean --dry-run"

################################################################################
#                                   Branches                                   #
################################################################################

abbr -a gb --position command "git branch"
abbr -a gcb --position command "git checkout -b"
abbr -a gcm --position command "git checkout $(git_main_branch)"
abbr -a gcd --position command "git checkout $(git_develop_branch)"

abbr -a gm --position command "git merge"
abbr -a gmtl --position command "git mergetool --no-prompt"
abbr -a gma --position command "git merge --abort"

################################################################################
#                             History Manipulation                             #
################################################################################

abbr -a gbs --position command "git bisect"
abbr -a gbsb --position command "git bisect bad"
abbr -a gbsg --position command "git bisect good"
abbr -a gbsr --position command "git bisect reset"
abbr -a gbss --position command "git bisect start"

abbr -a grb --position command "git rebase"
abbr -a grbi --position command "git rebase --interactive"
abbr -a grbo --position command "git rebase --onto"
abbr -a grba --position command "git rebase --abort"
abbr -a grbc --position command "git rebase --continue"
abbr -a grbs --position command "git rebase --skip"
abbr -a grbd --position command "git rebase $(git_develop_branch)"
abbr -a grbm --position command "git rebase $(git_main_branch)"

################################################################################
#                           Interaction with Remote                            #
################################################################################

abbr -a gp --position command "git push"
abbr -a gpv --position command "git push -v"
abbr -a gpd --position command "git push --dry-run"
abbr -a gpf --position command "git push --force-with-lease --force-if-includes"
abbr -a gpfv --position command "git push --force-with-lease --force-if-includes -v"
abbr -a "gpf!" --position command "git push --force"
abbr -a "gpfv!" --position command "git push --force -v"

abbr -a gf --position command "git fetch"

abbr -a gfa --position command "git fetch --all --prune"
# Fetch all & remove invalid remote refs.

abbr -a gpl --position command "git pull"
abbr -a gplr --position command "git pull --rebase"

################################################################################
#                                     Logs                                     #
################################################################################

# Current branch.
abbr -a gl --position command "git log --pretty=lc --graph"
abbr -a glo --position command "git log --pretty=lo --graph --date=human"
abbr -a gls --position command "git log --pretty=lo --graph --date=human --simplify-by-decoration"
abbr -a glf --position command "git log --pretty=lf --graph"
abbr -a gld --position command "git log --pretty=lf --graph --cc --stat"
abbr -a glp --position command "git log --pretty=lf --graph --cc --patch"

# All branches on all remotes.
abbr -a gla --position command "git log --pretty=lc --graph --all"
abbr -a glao --position command "git log --pretty=lo --graph --all --date=human"
abbr -a glas --position command "git log --pretty=lo --graph --all --date=human --simplify-by-decoration"
abbr -a glaf --position command "git log --pretty=lf --graph --all"
abbr -a glad --position command "git log --pretty=lf --graph --all --cc --stat"
abbr -a glap --position command "git log --pretty=lf --graph --all --cc --patch"

################################################################################
#                           Shortcuts to Feel Smart                            #
################################################################################

function gprevision -a N path
    git checkout \
        (git log --online $path | awk -v commit="$N" "FNR == -commit+1 {print $N}") \
        $path
end
# gprevision <N> <path>
# Checkout the <N>th revision (counting backwards from HEAD) of <path>.
#
# e.g. to checkout the last version of example.txt:
# gprevision -1 example.txt

function gnevermind
    reset --hard HEAD && git clean -df
end

################################################################################
#                                    Notes                                     #
################################################################################

# A note on reset, restore, and revert, paraphrased from `man git`, plus my own
# on `rm`:
#
# revert - make a new commit that reverts a previous commit.
# restore - undo uncommitted changes in the working tree.
# reset - update the branch and change commit history.
# rm - same as system rm; remove files, either from git's knowledge, the working
#   directory, or both.
#
# These are not a description of the *possible* uses, rather a narrowing of the
# *intended* uses.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# PATH VALUES:
# :/ - all files within the root of the working tree, so all files in the repo,
#   a la git add's --all option.
