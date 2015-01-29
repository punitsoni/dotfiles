# --- Generic BASH settings ---

# bash prompt
export PS1='\u@\h:[\[\033[33m\]\W\[\033[00m\]]$ '

# Detect OS (Linux, Mac OS X)
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='mac'
fi

# Aliases
alias ls='ls --color'
alias la='ls -la --color'
alias ll='ls -l --color'
alias grep='grep --color -n -E'
alias hal="cd \$ANDROID_BUILD_TOP/hardware/qcom/camera"
alias app="cd \$ANDROID_BUILD_TOP/packages/apps/Camera"
alias mmc="cd \$ANDROID_BUILD_TOP/vendor/qcom/proprietary/mm-camera"
alias kernel="cd \$ANDROID_BUILD_TOP/kernel/"
alias out="cd \$ANDROID_BUILD_TOP/out/target/product/\$TARGET_PRODUCT/"
alias drop="cd \$ANDROID_BUILD_TOP/../dropbox"

alias gs="git status"
alias gc="git commit"
alias gl="git log --decorate"
alias gd="git diff"
alias gsh="git show"
alias gshn="git show --name-only"
alias ga="git add"
alias gb="git branch"
alias remove-branches="git branch | xargs git branch -D"

alias emacs="emacs -nw"

alias glsh="~/gl.sh"

alias klog="echo \"waiting for device\" && adb wait-for-device root \
        && adb wait-for-device shell cat /proc/kmsg | tee k.log"


# force 256 color terminal in tmux to work with solarized theme
alias tmux="TERM=xterm-256color /usr/bin/tmux"

# allow colored output in less
alias less="less -r"

#setup ssh agent on startup

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# TODO: move to local
export \
PATH=$PATH:/local/mnt/workspace/punits/dropbox/scripts:\
/local/mnt/workspace/punits/bi:\
~/bin:~/.scripts

# setup dircolors for solarized theme
eval `dircolors ~/.dircolors`

## Mac specific settings ##
if [[ $platform == 'mac' ]]; then
   alias ls='ls -G'
   alias la='ls -al'
fi

# Import local settings from .bashrc_local file
# this file will be specific to the machine you are using. It will not be synced
# in dotfiles repo
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
