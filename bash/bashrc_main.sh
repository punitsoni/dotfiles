# --------------------------------- Prompt ---------------------------------- #

source $CFGS/bash/ansicolors.sh
export PS1="\u @\h ${C_GREEN}[\w]\n${C_YELLOW}$ ${C_RESET}"

# ----------------------------- Shell Options ------------------------------- #

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ------------------------- Environment Variables --------------------------- #

export PATH=$HOME/bin:$PATH
export EDITOR=vim
export HISTSIZE=10000

# -------------------------------- Aliases ---------------------------------- #

alias ls="ls --color"
alias la='ls -la'
alias ll='ls -l'
alias grep='grep --color -n -E'

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
# Delete all branches except the current one.
alias remove-branches="git branch | xargs git branch -D"
# allow colored output in less
alias less="less -r"
# Edit bashrc.
alias ebrc="$EDITOR $HOME/.bashrc"
# Source bashrc.
alias sbrc="source $HOME/.bashrc"

# -------------------------- OS Specific Settings --------------------------- #

platform='Unknown'
if [[ $(uname) == 'Linux' ]]; then
   platform='Linux'
   source $CFGS/bash/bashrc_linux.sh
elif [[ $(uname) == 'Darwin' ]]; then
   source $CFGS/bash/bashrc_macos.sh
   platform='macOS'
fi

# ----------------------------- Welcome Message ----------------------------- #
echo \
"------------------------------------------------------------------------------"
echo "Configs Dir: $CFGS"
echo "Platform: $platform"
echo \
"------------------------------------------------------------------------------"