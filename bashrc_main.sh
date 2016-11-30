# --- Generic BASH settings ---

# bash prompt
export PS1='\u@\h \[\033[33m\]\W\[\033[00m\] $ '

# Aliases
alias ls='ls --color'
alias la='ls -la --color'
alias ll='ls -l --color'
alias grep='grep --color -n -E'

# go to root directory of a git project
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
alias remove-branches="git branch | xargs git branch -D"
alias bb="bitbake"

# force 256 color terminal in tmux to work with solarized theme
alias tmux="TERM=xterm-256color /usr/bin/tmux"

# allow colored output in less
alias less="less -r"

# TODO: check if this is needed
#setup ssh agent on startup
# if [ ! -e "$HOME/.ssh/environment" ]; then
#    touch $HOME/.ssh/environment
#fi

#SSH_ENV="$HOME/.ssh/environment"

#start_agent() {
#    echo "Initialising new SSH agent..."
#    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#    echo succeeded
#    chmod 600 "${SSH_ENV}"
#    . "${SSH_ENV}" > /dev/null
#    /usr/bin/ssh-add;
#}

# Source SSH settings, if applicable
# if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi

# Detect OS (Linux, Mac OS X)
platform='unknown'
if [[ $(uname) == 'Linux' ]]; then
   platform='linux'
elif [[ $(uname) == 'Darwin' ]]; then
   platform='mac'
fi

## import platform specific settings
case $platform in
  "linux") source $DOTFILES_DIR/bashrc_linux.sh;;
  "mac") source $DOTFILES_DIR/bashrc_mac.sh;;
  *) true;;
esac
