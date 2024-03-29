## January 2023

---

Handling local config

We might want to have some configuration that is applied in neovim only in the
local machine. We do not want this config to be packaged as part of the
dotfiles. In that case we cannot have it in the ~/.config/nvim directory, as
that is a symlink to a directory in dotfiles.

Solution is to put this in another runtimepath. ~/.local/share/nvim/site is such
a place where you can put a plugin/ directory that is automatically loaded when
nvim starts.

This is useful to separate the work-specific config that you do not want to
bundle with dotfiles.

## December 2022

---

Everything in `init.lua` is run before any plugins are loaded. We need to see
if we should move all overriding config into after/plugin directory.

---

Implemented the actions feature. Now we can use shortcuts `<space>p` or `Ctrl-p`
to invoke a dropdown menu that shows a list of actions we can perform. Each
action is a lua function call that can be registered beforehand.

For improving telescope performance, install `ripgrep`. This is a fast tool
that works like find and grep. telescope `find_files` builtin automatically
uses this when available.

---

Idea: Actions

Action is a single operation that can be done. We can serach and execute an
action using telescope. We can also bind an action to a key.

---

We are now using fully lua based config for neovim. I want to understand what
is needed to use neovim as an full development envrionment for a largish codebase.

First thing we need is to have "workspace" settings for neovim. Workspace is
defined as a single directory which contains all code that we want to work with.
Each workspace has its own config that persists across editor sessions.

Workspace config also defines which set of files are useful. In a large
codebase, typically we only edit a small number of files. Having this limit
explicit will make navigation and editing faster.

---
