# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles for macOS and Linux. Organized by tool, with symlink-based installation. There are no build steps, tests, or linters — changes take effect by re-sourcing shell config or restarting the relevant tool.

## How Shell Config is Loaded

1. `~/.zshrc` (or `~/.bashrc`) sources `$DOTFILES/sh/main.sh`
2. `main.sh` sources `sh/common.sh` (aliases, functions, PATH) + shell-specific config (`sh/zsh_config.zsh` or `sh/bash_config.sh`)
3. Login shell (`~/.profile`) sources `sh/profile.sh`
4. Machine-local overrides live in `$CONFIG_LOCAL/zshrc-local` (outside this repo)

To reload after edits:
```bash
source ~/.zshrc
```

## Symlinking Configs

Configs are not auto-linked — each tool has its own setup script or manual `ln -s` step:

```bash
# Tmux
bash $DOTFILES/tmux/setup_tmux.sh          # installs TPM + creates symlinks

# Neovim
ln -s $DOTFILES/nvim ~/.config/nvim

# Kitty
bash $DOTFILES/kitty/install.sh

# AeroSpace (macOS)
ln -s $DOTFILES/aerospace ~/.config/aerospace

# Terminfo (needed for tmux over SSH)
tic -x $DOTFILES/resources/tmux.terminfo
```

## Key Directories

| Directory | What it configures |
|-----------|-------------------|
| `sh/` | Shell (zsh + bash): aliases, functions, PATH, plugins via zplug |
| `nvim/` | Neovim: Lua config, Lazy.nvim plugins, LSP, keymaps, actions |
| `tmux/` | Tmux: prefix=Ctrl+A, vim-style pane nav, TPM plugins |
| `macos/` | macOS tools: AeroSpace (window manager), Ghostty, yabai, skhd |
| `aerospace/` | AeroSpace window manager config |
| `i3/` + `sway/` | Linux window managers |
| `alacritty/` `kitty/` `wezterm/` `ghostty/` | Terminal emulator configs |
| `neo/` | `neo` CLI — a shell-based task runner using `cmd::<name>` function pattern |
| `scripts/` | One-off install scripts (fzf, fonts, tmux sessionizer) |

## Neovim Architecture

Config lives in `nvim/lua/ps/`:
- `general.lua` — core vim options
- `golazy.lua` — Lazy.nvim plugin definitions
- `lsp.lua` — LSP server setup
- `keymaps.lua` — keybindings
- `actions.lua` — telescope-driven action/command palette system

Plugins are managed by [Lazy.nvim](https://github.com/folke/lazy.nvim); run `:Lazy` inside neovim to manage them.

## Shell Functions (sh/functions.sh)

- `tm [name]` — create or attach a tmux session
- `ff [dir]` — fuzzy-find a file and open in `$EDITOR`
- `neo <subcommand>` — run a task defined in `neo/neo.sh`
- `has_command <cmd>` — check if a command exists (use in conditional config)

## macOS-Specific Notes

`macos/setup_macos.sh` installs AeroSpace and Ghostty via Homebrew and links configs. Yabai config is at `macos/yabairc`; skhd hotkeys at `macos/skhdrc`. `macos/DefaultKeyBinding.dict` adds system-wide text editing shortcuts.

## Platform-Conditional Patterns

Shell config uses `has_command` and `$OSTYPE` checks throughout — prefer this pattern when adding tool-specific config that may not be available on all machines:
```bash
if has_command fzf; then
  # fzf config
fi
```
