set -xe

mkdir -p ~/.config/yabai
rm -f ~/.config/yabai/yabairc
ln -s ~/dotfiles/macos/yabairc ~/.config/yabai/yabairc

mkdir -p ~/.config/skhd
rm -f ~/.config/skhd/skhdrc
ln -s ~/dotfiles/macos/skhdrc ~/.config/skhd/skhdrc

echo "DONE."

