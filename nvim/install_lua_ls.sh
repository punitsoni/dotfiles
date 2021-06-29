#!/bin/sh

# TODO: support other systems.
if [[ $(uname) != 'Darwin' ]]; then
  echo "Skipping Lang Server installation."
  exit 0
fi

installdir=$1/lua-language-server
if [ -d ${installdir}]; then
  echo "lua-language-server is already installed at ${installdir}"
fi

if ! command -v brew; then
  echo "brew not found"
  echo "Skipping Lang Server installation."
  exit 1
fi

if ! command -v ninja; then
  brew install ninja
fi


git clone https://github.com/sumneko/lua-language-server $installdir
cd $installdir
git submodule update --init --recursive

# Build macOS
echo "Building..."
cd 3rd/luamake
compile/install.sh
cd ../../
./3rd/luamake/luamake rebuild

echo "DONE"
