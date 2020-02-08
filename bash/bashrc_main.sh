# --------------------------------- Checks ---------------------------------- #

show_error() {
  echo "Error: $1"
  echo "Please setup your bashrc according to:"
  echo "https://github.com/punitsoni/dotfiles/tree/dev/bash"
}

if [ -z ${CFGS+x} ]; then
  show_error "CFGS not set."
  return
fi

# ----------------------------- Detect Platform ----------------------------- #

platform='Unknown'
if [[ $(uname) == 'Linux' ]]; then
   platform='Linux'
elif [[ $(uname) == 'Darwin' ]]; then
   platform='macOS'
fi

# --------------------------------- Prompt ---------------------------------- #

source $CFGS/bash/ansicolors.sh
export PS1="\u @\h ${C_GREEN}[\w]\n${C_YELLOW}$ ${C_RESET}"

# ----------------------------- Shell Options ------------------------------- #

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
fi

# ------------------------- Environment Variables --------------------------- #

export PATH=$HOME/bin:$PATH
export EDITOR=nvim
export HISTSIZE=10000

# -------------------------------- Aliases ---------------------------------- #

alias ls="ls --color"
alias la='ls -la'
alias ll='ls -l'
alias grep='grep --color -n -E'

alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias view='nvim -R'

alias tad='tmux attach -d'
alias ..='cd ..'
alias xx='exit'

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
# Delete all branches except the current one.
alias grmb="git branch | xargs git branch -D"
# allow colored output in less
alias less="less -r"
# Edit bashrc.
alias ebrc="$EDITOR $HOME/.bashrc"
# Edit bashrc_main
alias ebrcm="$EDITOR $CFGS/bash/bashrc_main.sh"
# Source bashrc.
alias sbrc="source $HOME/.bashrc"

# ------------------------------ Helper Functions ---------------------------- #

# Jupyter QtConsole with configuration
jqt()
{
  nohup jupyter qtconsole --no-confirm-exit --paging vsplit \
    --JupyterWidget.font_size=12 1>&2 > /dev/null &
  echo "Jupyter QtConsole started."
}

# open a file in desktop UI
xo()
{
  xdg-open $1
}

# Show $PATH variable with each entry in its own line.
showpath()
{
  sed 's/:/\n/g' <<< "$PATH"
}

# ----------------------------- Welcome Message ----------------------------- #
echo \
"------------------------------------------------------------------------------"
printf "%12s: %s\n" "Configs Dir" "$CFGS"
printf "%12s: %s\n" "Platform" "$platform"
printf "%12s: %s\n" "Editor" "$EDITOR"
# echo "Platform: $platform"
# echo "Editor: $EDITOR"
echo \
"------------------------------------------------------------------------------"

