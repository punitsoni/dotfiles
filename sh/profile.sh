# Config for login shells.

is_interactive_shell() {
  [[ $- == *i* ]]
}

is_login_shell() {
  shopt -q login_shell
}

# TODO: May be move this to a common script which is sourced by both
# login and non-login shells.

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# For login shells which are interactive, we need to source the rc file.
if is_interactive_shell; then
  # If shell is bash, load bashrc.
  if [[ ! -z ${BASH} ]]; then
    source ${HOME}/.bashrc
  fi
  # TODO: add support for zsh.
fi

