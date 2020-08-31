# --------------------------------------------------------------------------- #
#                         Common Shell configuration
# --------------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #
#                            Environment Variables
# --------------------------------------------------------------------------- #
export PATH=${HOME}/bin:${PATH}
export PROMPT='%/ $ '

# Set EDITOR to vim if not set already.
[[ -z ${EDITOR} ]] && export EDITOR=vim

# --------------------------------------------------------------------------- #
#                                 Functions
# --------------------------------------------------------------------------- #
source ${CFGS}/sh/functions.sh

# --------------------------------------------------------------------------- #
#                                  Aliases
# --------------------------------------------------------------------------- #

# TODO: make sure that GNU ls is present for this aliases to work.
alias ls="ls --color"
alias la='ls -la'
alias ll='ls -l'

alias ..='cd ..'
alias xx='exit'
alias t=type

# Common typos
alias celar=clear
alias clea=clear
alias sl=ls
alias rls=ls

# Common git commands.
# Go to root directory of a git project.
alias groot="cd \$(git rev-parse --show-toplevel)"
alias gs="git status"
alias gc="git commit"
alias gl="git log --decorate"
alias gd="git diff"
alias gsh="git show"
alias gshn="git show --name-only"
alias ga="git add"
alias gb="git branch"
alias gr="git remote -v"
alias gch="git checkout"
alias gt="git tag"
# Delete all branches except the current one.
alias grmb="git branch | xargs git branch -D"

# allow colored output in less
alias less="less -r"

