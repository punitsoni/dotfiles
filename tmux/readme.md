## Setup `tmux`

* Install tmux

* Link tmux conf

```
ln -s $CFGS/tmux/tmux.conf ~/.tmux.conf
ln -s $CFGS/tmux/tmux.conf.local ~/.tmux.conf.local
```

## Troubleshooting

If you see a problem using `clear` command related to terminfo. Please install
the tmux terminfo database.

```
tic -x $CFGS/resources/tmux.terminfo
```
