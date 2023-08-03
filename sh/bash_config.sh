# --------------------------------------------------------------------------- #
#                        Bash-specific Shell Config
# --------------------------------------------------------------------------- #

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

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=10000

# --------------------------------- Prompt ---------------------------------- #

# Function to be executed on every prompt.
__brc_on_prompt() {
  # Set terminal cursor to line. see https://superuser.com/questions/361335
  # TODO: check if this works everywhere.
  printf '\033[6 q'
}

source $DOTFILES/sh/ansicolors.sh
PS1="\n\u@\h ${C_GREEN}[\w]\n${C_YELLOW}$ ${C_RESET}"
PROMPT_COMMAND=__brc_on_prompt

# --------------------------------- Misc ------------------------------------ #

alias eshrc="$EDITOR $HOME/.bashrc"
# Edit bashrc_main
alias eshrcm="$EDITOR $DOTFILES/sh/bash_config.sh"
# Source bashrc.
alias shrc="source $HOME/.bashrc"

# Install fzf key bindings (ctrl-r)
if command -v fzf > /dev/null 2>&1 ; then
  source /usr/share/doc/fzf/examples/key-bindings.bash
fi

