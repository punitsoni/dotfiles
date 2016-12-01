#!/bin/bash
#
# setup script for installing the config files for various programs
# Author: Punit Soni <punitxsmart@gmail.com>
#


# find the path to directory containing this script
dotfiles_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P )

show_help() {
    echo "usage: ./setup.sh [-f]"
    echo "  -f : force overwrite"
    exit 0
}

force_overwrite="no"
# A POSIX variable. Reset in case getopts has been used previously in the shell.
OPTIND=1
while getopts "hf" opt; do
    case $opt in
    h|\?) show_help;;
    f)  force_overwrite="yes";;
    esac
done

overwrite_check() {
    if [ $force_overwrite = "yes" ]; then
        return 0
    fi
    while true; do
        read -p "overwrite $1 ? (y/n) " yn
        case $yn in
            [Yy]) return 0;;
            [Nn]) return 1;;
            *)
        esac
    done
}

echo "configuring bash..."
overwrite_check "~/.bashrc and ~/.dotfiles" && {
    # move the original bashrc if its not a symlink
    if [ ! -h $HOME/.bashrc ]; then
        mv $HOME/.bashrc $HOME/.bashrc_default
    fi
    rm -rf $HOME/.dotfiles
    rsync -a $dotfiles_dir/ $HOME/.dotfiles
    ln -sf $HOME/.dotfiles/bashrc $HOME/.bashrc
}

: '
# do not setup vim until portability issues are fixed
echo "configuring vim..."
overwrite_check "~/.vimrc and ~/.vim" && {
    # TODO: move the original vimrc if its not a symlink
    if [ ! -h $HOME/.vimrc ]; then
        mv $HOME/.vimrc $HOME/.vimrc_default.vim
    fi
    ln -sf $HOME/.dotfiles/vimrc $HOME/.vimrc;
    ln -sf $HOME/.dotfiles/vim $HOME/.vim;
}
'

echo "configuring tmux..."
overwrite_check "$HOME/tmux.conf" && {
    ln -sf $HOME/.dotfiles/tmux.conf $HOME/.tmux.conf
}
#cp -r $dotfiles_dir $HOME/.dotfiles
#ln -sf $dotfiles_dir/solarized-theme/dircolors-solarized/dircolors.ansi-dark \
#    ~/.dircolors
#ln -sf $dotfiles_dir/scripts ~/.scripts
#ln -sf $dotfiles_dir/notes.txt ~/.notes.txt
echo "DONE."

echo "Run following command to reload bash configuration."
echo  "\n\tsource ~/.bashrc\n"
