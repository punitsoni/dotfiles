export PS1='\u@\h:[\[\033[33m\]\W\[\033[00m\]]$ '

export PATH=$PATH:/usr/sbin:/sbin

export LANG=en_US.utf8

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

export PATH=$PATH:/local/mnt/workspace/punits/dropbox/scripts:/local/mnt/workspace/punits/bi

# setup dircolors for solarized theme
eval `dircolors ~/.dircolors`
