#!/usr/bin/env zsh

alias g="git"

################################################################################
#                                  Functions                                   #
################################################################################

function git_develop_branch()
{
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

function git_main_branch()
{
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  echo master
  return 1
}

function git_current_branch()
{
  local ref
  ref=$(git symbolic-ref --quiet HEAD 2>/dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return # no git repo
    ref=$(git rev-parse --short HEAD 2>/dev/null) || return
  fi

  echo ${ref#refs/heads/}
}

################################################################################
#                                   Staging                                    #
################################################################################

alias ga="git add"
alias gaa="git add --all"
alias gapa="git add --patch" # interactively stage parts of a file

alias gd="git diff"
alias gds="git diff --staged"
alias gdw="git diff --word-diff" # show differences by word
alias gdsw="git diff --staged --word-diff"

function gdnolock()
{
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
# I think this tells ZSH that gdnolock takes the same arguments as git diff for
# autocompletion purposes?
compdef _git gdnolock=git-diff

alias gst="git status"
alias gss="git status --short"

################################################################################
#                                  Committing                                  #
################################################################################

alias gc="git commit"
alias 'gc!'="git commit --amend"
alias "gcn!"="git commit --no-edit --amend"
alias gca="git commit -a"
alias 'gca!'="git commit -a --amend"
alias 'gcan!'="git commit -a --no-edit --amend"
alias gcam="git commit -a -m"
alias gcmsg="git commit -m"

alias grev="git revert"

################################################################################
#                       Working Dir & Index Manipulation                       #
################################################################################

alias gco="git checkout"

alias grt="git reset"
# grt <commit> -- [<path>] - undo <commit> but keep changes in working dir

alias grts="git reset --soft" # undo commits and stage their changes

alias grs="git restore --worktree"
# grs <unstaged-path> - revert local changes for <unstaged-path>
# (--worktree is the default behavior, but included here for clarity)

alias grss="git restore --worktree --source"
# grss <commit> <unstaged-path> - revert <unstaged-path> to <commit>'s version

alias grst="git restore --staged"
# grst <staged-path> - unstage <staged-path>

alias grsts="git restore --staged --source" # see grss, but for <staged-path>s

alias grsa="git restore --worktree --staged"
# grsa <path> - discard all changes for <path>, both staged and unstaged

alias grsas="git restore --worktree --staged --source"

alias grm="git rm" # remove paths from index & working dir

alias grmc="git rm --cached"
# Unstage & remove only from index; leave in working dir.
# grmc <path> - where <path> is already tracked: stages the removal of <path>

alias gsta="git stash push" # save changes; add --message <message> to label stash
alias gstaa="git stash push --include-untracked"
alias gstap="git stash pop"         # retrieve changes
alias gstal="git stash list"        # list stashes
alias gstas="git stash show --text" # --text treats all files as text

alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "🚧 --wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\🚧 --wip--" && git reset HEAD~1'

alias gcl="git clean -f" # remove unknown (untracked and unignored) files
alias gcldr="git clean --dry-run"

################################################################################
#                                   Branches                                   #
################################################################################

alias gb="git branch"
alias gcb="git checkout -b"
alias gcm="git checkout $(git_main_branch)"
alias gcd="git checkout $(git_develop_branch)"

alias gm="git merge"
alias gmtl="git mergetool --no-prompt"
alias gma="git merge --abort"

################################################################################
#                             History Manipulation                             #
################################################################################

alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"

alias grb="git rebase"
alias grbi="git rebase -i"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grbd="git rebase $(git_develop_branch)"
alias grbm="git rebase $(git_main_branch)"

################################################################################
#                                    Bisect                                    #
################################################################################

alias gbs="git bisect"
alias gbsb="git bisect bad"
alias gbsg="git bisect good"
alias gbsr="git bisect reset"
alias gbss="git bisect start"

################################################################################
#                           Interaction with Remote                            #
################################################################################

alias gp="git push"
alias gpv="git push -v"
alias gpd="git push --dry-run"
alias gpf="git push --force-with-lease --force-if-includes"
alias gpfv="git push --force-with-lease --force-if-includes -v"
alias 'gpf!'="git push --force"
alias 'gpfv!'="git push --force -v"

alias gf="git fetch"
alias gfa="git fetch --all --prune" # fetch all & remove invalid remote refs
alias gpl="git pull"
alias gplr="git pull --rebase"

################################################################################
#                                     Logs                                     #
################################################################################

# Current branch
alias gl="git log --pretty=lc --graph"
alias glo="git log --pretty=lo --graph --date=human"
alias gls="git log --pretty=lo --graph --date=human --simplify-by-decoration"
alias glf="git log --pretty=lf --graph"
alias gld="git log --pretty=lf --graph --cc --stat"
alias glp="git log --pretty=lf --graph --cc --patch"

# All branches+tags on all remotes
alias la="git log --pretty=lc --graph --all"
alias lao="git log --pretty=lo --graph --date=human --all"
alias las="git log --pretty=lo --graph --date=human --simplify-by-decoration --all"
alias laf="git log --pretty=lf --graph --all"
alias lad="git log --pretty=lf --graph --cc --stat --all"
alias lap="git log --pretty=lf --graph --cc --patch --all"

################################################################################
#                           Shortcuts to Feel Smart                            #
################################################################################

alias gprevision="!f() { git checkout $(git log --oneline $2 | awk -v commit=\"$1\" 'FNR == -commit+1 {print $1}') $2; }; f"
# gprevision <N> <path>
# Checkout the <N>th revision (counting backwards from HEAD) of <path>.
#
# e.g. to checkout the last version of example.txt:
# gprevision -1 example.txt

alias gnevermind="reset --hard HEAD && git clean -df"

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
