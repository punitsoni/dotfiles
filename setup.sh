#!/bin/bash
#
# setup script for installing the config files for various programs
# Author: Punit Soni <punitxsmart@gmail.com>
#

function backup {
    if [ -e $1 ]; then
            rm -rf $1.backup
            mv $1 $1.backup
    fi
}

read -p "This will overwrite your existing rc files, continue? (y/n) " -n 1 -r
echo -e "\n"

dotfiles_dir=$(pwd)

if [[ !  $REPLY =~ ^[Yy]$ ]]
then
	echo "Aborted by user."
	exit 0
fi

# TODO: take backup of existing settings

set -x # start echoing commands
backup ~/.bashrc
backup ~/.vimrc
backup ~/.tmux.conf
backup ~/.dircolors
backup ~/.vim
backup ~/.scripts


ln -sf $dotfiles_dir/bashrc ~/.bashrc
ln -sf $dotfiles_dir/vimrc ~/.vimrc
ln -sf $dotfiles_dir/vim ~/.vim
ln -sf $dotfiles_dir/tmux.conf ~/.tmux.conf
ln -sf $dotfiles_dir/solarized-theme/dircolors-solarized/dircolors.ansi-dark \
    ~/.dircolors
ln -sf $dotfiles_dir/scripts ~/.scripts
ln -sf $dotfiles_dir/notes.txt ~/.notes.txt
set +x # stop echoing commands

echo -e "Run following command to reload bashrc.\n"
echo -e "\tsource ~/.bashrc\n"
echo "DONE."
