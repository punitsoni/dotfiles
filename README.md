dotfiles
========

startup settings for vim, bash, tmux etc.

## Installation
Note: Please take a backup of your current rc files
All settings will be overwritten by this.

```
rm ~/.vimrc
ln -s vimrc ~/.vimrc
ln -s vim ~/.vim
ln -s bashrc ~/.bashrc
```

### bashrc settings
- use `~/.bashrc_local` file to put settings specific to the machine. This file will be sourced from the generic bashrc script and can override the generic settings.
