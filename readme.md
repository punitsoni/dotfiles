# The `dotfiles`

## Configure Shell

Create a `.bashrc` or `.zshrc` file in your home directory with following content.

```sh
# ---------------------------------- Setup ---------------------------------- #

# If not running in interactive mode; just return.
[ ! "echo $- | grep -q 'i'" ] && return

# Path to the configs directory.
export CFGS=$HOME/dotfiles

# Source global bash configuration.
source $CFGS/sh/main.sh

# ------------ Add custom ad-hoc configuration below this line. ------------- #


# ------------ Config added automatically by some installed packages -------- #

```
## Configure `tmux`

* Install tmux

```
ln -s $CFGS/tmux/tmux.conf ~/.tmux.conf
ln -s $CFGS/tmux/tmux.conf.local ~/.tmux.conf.local
```

### Troubleshooting

If you see a problem using `clear` command related to terminfo. Please install
the tmux terminfo database.

```
tic -x $CFGS/resources/tmux.terminfo
```

## Configure `i3` window manager

```sh
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/polybar
ln -s $CFGS/i3/config $HOME/.config/i3/config
ln -s $CFGS/i3/compton.conf $HOME/.config/compton.conf
ln -s $CFGS/i3/polybar_config $HOME/.config/polybar/config
```

## Kitty terminal

Kitty sets your terminal type to `xterm-kitty`. This may not be available in
your terminfo database. This might cause your terminal to behave in weird way.
You can install terminfo as a separate package in Linux.

```
sudo apt install kitty-terminfo
```
