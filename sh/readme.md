
## Configure login (non-interactive) shells.

Put following in your `~/.profile`

```sh
dotfiles_path=${HOME}/dotfiles

if [ -d ${dotfiles_path} ]; then
  export DOTFILES=$HOME/dotfiles
  # Source main config for login shells.
  source ${DOTFILES}/sh/profile.sh
fi

```
