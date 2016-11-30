#!/bin/sh
#
# setup script for installing the config files for various programs
# Author: Punit Soni <punitxsmart@gmail.com>
#

dotfiles_dir=$(pwd)

force_overwrite="no"

show_help() {
    echo "usage: ./setup.sh [-f]"
    echo "  -f : force overwrite"
    exit 0
}

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

echo "configuring vim..."
overwrite_check "$HOME/.vimrc" && {
    ln -sf $HOME/.dotfiles/vimrc $HOME/.vimrc;
    ln -sf $HOME/.dotfiles/vim $HOME/.vim;
}

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
