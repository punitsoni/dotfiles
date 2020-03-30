# --------------------------------------------------------------------------- #
#                          ZSH configuration Main
# --------------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #
# -------------------------------- Plugins ---------------------------------- #
# --------------------------------------------------------------------------- #
source $HOME/.zplug/init.zsh

# Let zplug manage zplug.
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# List plugins here. Make sure to use double quotes to prevent shell
# expansion.
zplug "zsh-users/zsh-syntax-highlighting"
zplug "mafredri/zsh-async", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  echo "Installing plugins..."
  zplug install
    # printf "Install? [y/N]: "
    # if read -q; then
    #     echo; zplug install
    # fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# --- Plugin configurations.
# zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=48
ZSH_AUTOSUGGEST_USE_ASYNC=1
bindkey '^ ' autosuggest-accept


# --------------------------------------------------------------------------- #
# ------------------------------- My Config --------------------------------- #
# --------------------------------------------------------------------------- #
export EDITOR=${EDITOR:-vim}

# Import dependencies.
source $CFGS/sh/aliases.sh
source $CFGS/sh/functions.sh

# -- Shell options
setopt AUTO_CD
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# Add timestamp in unix epoch time and elapsed time of the command.
setopt EXTENDED_HISTORY
# expire duplicates first.
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications.
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching.
setopt HIST_FIND_NO_DUPS
# removes blank lines from history.
setopt HIST_REDUCE_BLANKS
setopt CORRECT
setopt CORRECT_ALL

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ------------------------------ Completions -------------------------------- #

# load bashcompinit for some old bash completions
autoload -Uz compinit bashcompinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
bashcompinit
_comp_options+=(globdots) # Include hidden files.

# -------------------------------- VI Mode ---------------------------------- #
# Enable vi mode keymap.
bindkey -v
# Reduce the mode switching delay.
KEYTIMEOUT=1
# ZLE widget function to change cursor shape for different vi modes.
zle-keymap-select() {
  case ${KEYMAP} in
    "vicmd")
      cursor block
      ;;
    "main"|"viins"|"")
      cursor beam
      ;;
  esac
}
zle -N zle-keymap-select
# Use Vim keys in completion menu.
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
# Edit the command in vim when pressing Ctrl-v.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line
# Reset cursor to I-beam on each prompt.
precmd_functions+=(cursor beam)

# Enable help command.
autoload -Uz run-help
# unalias run-help
alias help=run-help


