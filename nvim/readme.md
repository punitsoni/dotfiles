## Setup neovim

### Install neovim

See https://github.com/neovim/neovim/wiki/Installing-Neovim

### Link neovim config

```bash
ln -s $CFGS/nvim/init.vim $HOME/.config/nvim/init.vim
```

Note: `$CFGS` points to your configs directory. If bash setup is done.
This variable will point to correct location.

### Install vim-plug plugin manager

Install vim-plug for neovim according to the instructions here.
https://github.com/junegunn/vim-plug

### Install fzf support

If not already installed, install fzf. This is required for lot of search
functionality built in our neovim config.

### First start

Open neovim and run command `:PlugInstall` to install all plugins. After done,
restart neovim.

## Troubleshooting

If you see errors related to python provider not found. Install pynvim package.

```
python -m pip install pynvim
```

From inside neovim, run command `:UpdateRemotePlugins`

