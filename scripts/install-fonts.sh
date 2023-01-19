# Automatically install some nerd fonts that we use.

set -ex

# td=$(mktemp -d)/nerd-fonts

td=/tmp/nerd-fonts
rm -rf ${td}

mkdir -p ${td}

git clone --filter=blob:none --sparse \
  https://github.com/ryanoasis/nerd-fonts.git ${td}

cd ${td}

git sparse-checkout add patched-fonts/JetBrainsMono
git sparse-checkout add patched-fonts/FiraCode

./install.sh
