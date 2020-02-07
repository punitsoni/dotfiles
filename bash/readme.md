# Bash Configuration

Create a `.bashrc` file in your home directory with following content.


```bash
# ---------------------------------- Setup ---------------------------------- #

# If not running in interactive mode; just return.
if [ ! "echo $- | grep -q 'i'" ]; then
  return
fi

# Path to the configs directory.
export CFGS=$HOME/dotfiles

# Source global bash configuration.
source $CFGS/bash/bashrc_main.sh

# ------------ Add custom ad-hoc configuration below this line. ------------- #


# ------------ Config added automatically by some installed packages -------- #

```
