# Configure i3 window manager

As of i3 4.22, i3-gaps are now part of upstream i3.

## Building i3 from scratch

* Download the source archive.

* Install build dependencies
```sh
sudo apt-get build-dep i3
```

* In i3 source directory,
```sh
# Build
mkdir build && cd build
meson ..
ninja

# Install
sudo meson install

```

## Other tools and dependencies

* Install rofi
* Install compton

```
sudo apt install rofi compton feh polybar

# Pulse-audio utils for Volume control shortcuts
sudo apt install pulse-audio-utils pulseaudio pavucontrol pulseaudio-module-bluetooth
```
