# Zellij

Config: `~/.config/zellij/config.kdl`

Prefix is `Ctrl-a`, same as tmux. Press it, then a key to run a command below.
Press `Ctrl-a` twice to send a literal `Ctrl-a` through to the app running in
the pane (e.g. readline/vim), same as tmux passthrough.

## Panes

- `Ctrl-a` then `|` - split pane right
- `Ctrl-a` then `-` - split pane down
- `Ctrl-h`/`j`/`k`/`l` - move focus between panes (no prefix needed)
- `Ctrl-a` then `h`/`j`/`k`/`l` or arrows - move focus between panes (tmux-mode alternative)
- `Ctrl-a` then `z` - zoom/fullscreen the focused pane
- `Ctrl-a` then `x` - close the focused pane

## Tabs (windows)

- `Ctrl-a` then `c` - new tab
- `Ctrl-a` then `n` - next tab
- `Ctrl-a` then `p` - previous tab
- `Ctrl-a` then `,` - rename tab

## Sessions

- `Ctrl-a` then `d` - detach
- `zm` (shell command, outside or inside zellij) - attach to or create a session via an fzf
  picker of live sessions, mirroring the tmux `tm` command. `zm <name>` skips the picker.
  Exited/resurrectable sessions are hidden from the picker; attach by name to resurrect one.

## Scrollback and search

Not part of tmux mode - this is zellij's native scroll mode, its own prefix-free key:

- `Ctrl-s` - enter scroll mode
  - `j`/`k` or arrows - scroll line by line
  - `Ctrl-f`/`Ctrl-b` or PageUp/PageDown - page scroll
  - `d`/`u` - half-page down/up
  - `e` - open scrollback in `$EDITOR`
  - `s` - enter search (then `n`/`p` for next/prev match, `c` case-sensitivity, `w` whole word)
  - `esc` or `Ctrl-c` - back to normal mode
- Mouse selection copies to clipboard automatically, no separate "begin selection" step

## Reloading config

Unlike tmux, zellij does not hot-reload `config.kdl` into a running session -
keybinds and options are loaded once at session start. To pick up changes,
kill the session and start a new one:

```sh
zellij kill-session <name>
zellij
```

Detaching (`Ctrl-a` then `d`) and reattaching does not reload the config.

## Not carried over from tmux

These tmux binds have no equivalent wired up yet: `r`/`R` config reload, `w`
list-windows, `"` choose-window, `S` choose-session, and the vim-tmux-navigator
`Ctrl-h/j/k/l` passthrough to vim. Add them to `~/.config/zellij/config.kdl` if
you end up needing them. (The `tmux_sessionizer.sh` popup now has a zellij
counterpart: `zm`, see Sessions above.)
