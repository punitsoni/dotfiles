# Neovim configuration

## Config directories

ftplugin/

Put filetype specific config here. Loaded automatically when filetype is set.
For example `ftplugin/cpp.lua`

after/plugin

Everything here get loaded automatically after the main init.lua and all plugins
are finished loading.

## Run lua file in nvim environment for development

sh runlua.sh file.lua

Neovim has a standard way to run lua scripts in headless mode.

nvim -l file.lua 

## Useful shortcuts and tips

* `C-w L` Move the current window to right full-height. Useful for moving help
  buffer to right side.

