# The `dotfiles`

## First time setup

Generate ssh key
```
ssh-keygen -t ed25519 -C "you@gmail.com"
```

Add ssh key to your github account
```
cat ~/.ssh/id_ed25519.pub
```
clone `dotfiles` repo in your machine
```
git clone git@github.com:punitsoni/dotfiles.git
```

## Configure Shell

Create a `.bashrc` or `.zshrc` file in your home directory with following content.

```sh
# ---------------------------------- Setup ---------------------------------- #

# If not running in interactive mode; just return.
[ ! "echo $- | grep -q 'i'" ] && return

# Path to the configs directory.
export DOTFILES=$HOME/dotfiles

# Source global bash configuration.
source $DOTFILES/sh/main.sh

# ------------ Add custom ad-hoc configuration below this line. ------------- #


# ------------ Config added automatically by some installed packages -------- #

```

Restart your terminal.

## Configure `tmux`

* Install tmux

```
ln -s $DOTFILES/tmux/tmux.conf ~/.tmux.conf && ln -s $DOTFILES/tmux/tmux.conf.local ~/.tmux.conf.local
```

### Troubleshooting

If you see a problem using `clear` command related to terminfo. Please install
the tmux terminfo database.

```
tic -x $DOTFILES/resources/tmux.terminfo
```

## Configure `i3` window manager

```sh
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/polybar
ln -s $DOTFILES/i3/config $HOME/.config/i3/config
ln -s $DOTFILES/i3/compton.conf $HOME/.config/compton.conf
ln -s $DOTFILES/i3/polybar_config $HOME/.config/polybar/config
```

## Kitty terminal

Kitty sets your terminal type to `xterm-kitty`. This may not be available in
your terminfo database. This might cause your terminal to behave in weird way.
You can install terminfo as a separate package in Linux.

```
sudo apt install kitty-terminfo
```
