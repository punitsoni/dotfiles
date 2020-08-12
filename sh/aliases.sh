
alias ls="ls --color"
alias la='ls -la'
alias ll='ls -l'
# alias grep='grep --color -n -E'

alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias view='nvim -R'

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
alias gr="git remote"
alias gch="git checkout"
alias gt="git tag"
# Delete all branches except the current one.
alias grmb="git branch | xargs git branch -D"

# allow colored output in less
alias less="less -r"

# Edit bashrc.
alias ebrc="${EDITOR} ${HOME}/.bashrc"
# Edit bashrc_main
alias ebrcm="${EDITOR} ${CFGS}/bash/bashrc_main.sh"
# Source bashrc.
alias sbrc="source ${HOME}/.bashrc"

alias ezrc="${EDITOR} ${HOME}/.zshrc"
alias ezrcm="${EDITOR} ${CFGS}/sh/zshrc_main.zsh"
alias szrc="source ${HOME}/.zshrc"

# Edit zshrc.
alias ezrc="$EDITOR $HOME/.zshrc"
# Edit zshrc_main.
alias ezrcm="$EDITOR $CFGS/sh/zshrc_main.zsh"
# Source bashrc.
alias szrc="source $HOME/.zshrc"

