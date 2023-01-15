# --------------------------------------------------------------------------- #
#                         Common Shell configuration
# --------------------------------------------------------------------------- #

# --------------------------------------------------------------------------- #
#                                 Functions
# --------------------------------------------------------------------------- #
source ${DOTFILES}/sh/functions.sh

# --------------------------------------------------------------------------- #
#                            Environment Variables
# --------------------------------------------------------------------------- #
# Use programs from your own bin/
export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}

# If neovim is available alias vim to neovim.
if command -v nvim &> /dev/null; then
  export EDITOR=nvim
  alias vim=nvim
  alias vi=nvim
fi

# --------------------------------------------------------------------------- #
#                                  Aliases
# --------------------------------------------------------------------------- #

# Setup best available alias for ls.
if [[ -x $(command -v lsd) ]]; then
  # If lsd exists, use that to provide ls command.
  alias ls="lsd"
  alias ll="lsd -l"
  alias la="lsd -la"
elif [[ $(ls_version) == "GNU_LS" ]]; then
  alias ls="ls --color"
  alias ll='ls -l'
  alias la='ls -la'
elif [[ $(ls_version) == "BSD_LS" ]]; then
  # macOS has BSD version of ls by default.
  alias ls="ls -G"
  alias ll='ls -l'
  alias la='ls -la'
fi


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

