#!/bin/bash

set -xeu

# Install dependencies (debian)

sudo apt install \
  dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
  xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
  libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
  libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev \
  libxcb-shape0 libxcb-shape0-dev meson




mkdir -p ${HOME}/opt
cd ${HOME}/opt
# git clone https://www.github.com/Airblader/i3 i3-gaps

cd i3-gaps

mkdir -p build && cd build
meson ..
ninja

sudo meson install

