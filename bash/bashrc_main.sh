# ---------------------------- Helper Functions ----------------------------- #

# Show message for an error when loading this bashrc.
__brc_show_error() {
  echo "Error: $1"
  echo "Please setup your bashrc according to:"
  echo "https://github.com/punitsoni/dotfiles/tree/dev/bash"
}

# Function to be executed on every prompt.
__brc_on_prompt() {
  # Set terminal cursor to line. see https://superuser.com/questions/361335
  # TODO: check if this works everywhere.
  printf '\033[6 q'
}

# Detect current platform.
__brc_detect_platform() {
  if [[ $(uname) == 'Linux' ]]; then
    echo 'Linux'
  elif [[ $(uname) == 'Darwin' ]]; then
    echo 'macOS'
  else
    echo 'Unknown'
  fi
}

# --------------------------------- Checks ---------------------------------- #

if [ -z ${CFGS+x} ]; then
  __brc_show_error "CFGS not set."
  return
fi

# ------------------------------ General Setup ------------------------------ #

platform=$(__brc_detect_platform)

# load function from lib
source $CFGS/bash/lib.sh

# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
fi

# --------------------------------- Prompt ---------------------------------- #

source $CFGS/bash/ansicolors.sh
PS1="\u @\h ${C_GREEN}[\w]\n${C_YELLOW}$ ${C_RESET}"
PROMPT_COMMAND=__brc_on_prompt

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

# alias tad='tmux attach -d'
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
alias ebrc="$EDITOR $HOME/.bashrc"
# Edit bashrc_main
alias ebrcm="$EDITOR $CFGS/bash/bashrc_main.sh"
# Source bashrc.
alias sbrc="source $HOME/.bashrc"

# Attach to tmux session. Create new session if it does not exist.
# If no argument provided. It attaches to session 0.
tm() {
  if [ -z $1 ]; then
    ${TMUX_BIN:-tmux} new-session -A -s 0
  else
    ${TMUX_BIN:-tmux} new-session -A -s $1
  fi
}

# ----------------------------- Welcome Message ----------------------------- #

echo \
"------------------------------------------------------------------------------"
printf "%12s: %s\n" "Configs Dir" "$CFGS"
printf "%12s: %s\n" "Platform" "$platform"
printf "%12s: %s\n" "Editor" "$EDITOR"
echo \
"------------------------------------------------------------------------------"
# maybe_weather
# echo \
# "------------------------------------------------------------------------------"

