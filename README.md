dotfiles
========

startup settings for command-line tools.

Currently supports
- bash
- vim
- tmux

## Installation
Note: To be safe, please take a backup of your current rc files. Your current settings might get overwritten when you install this.

To install just run,
```
./setup.sh
```
## Misc Settings
### setup solarized theme for gnome-terminal
```
./solarized-theme/gnome-terminal-colors-solarized/install.sh
```
### bashrc settings
- use `~/.bashrc_local` file to put settings specific to the machine. This file will be sourced from the generic bashrc script and can override the generic settings.

### Solarized issues
- If git colors are not correct (git sometimes uses bright colors which are defined as grey by solarized),
  change the git colors to non-bold in global gitconfig using following command.
```
git config --global -e
```
