# bashrc from https://github.com/punitsoni/dotfiles

# Your original bash configuration is available in ~/.bashrc_default
# If required, you can switch back to that using following command
#	rm -f ~/.bashrc && mv ~/.bashrc_default ~/.bashrc

# import original default bashrc if available
if [ -e ~/.bashrc_default ]; then
  source ~/.bashrc_default
fi

DOTFILES_DIR=$HOME/.dotfiles

# import main bashrc
source $DOTFILES_DIR/bashrc_main.sh

# NOTE: Add any local machine specific configuration to ~/.bashrc_local
if [ -e ~/.bashrc_local ]; then
  source ~/.bashrc_local
fi
