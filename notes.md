TODO
----
* Revisit the dev workflow setup by ThePrimagen.
  - Automatically create tmux sessions in workspaces using fzf
  - Use cht.sh for looking up help from commandline.

NOTES
-----

---

Installing i3 gaps in debian. Best option is to build from source.
https://github.com/Airblader/i3/wiki/Building-from-source

Build polybar from source in debian.
https://github.com/polybar/polybar#building-from-source
https://github.com/polybar/polybar/wiki/Compiling#build-dependencies

See this wiki for setup.
https://github.com/polybar/polybar/wiki

---

Using GNU utilitis in macOS

```
brew install coreutils findutils
```
See https://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities

---

## Use vscode as a diff tool for git

```
git config --global diff.guitool vscode && \
git config --global difftool.vscode.cmd 'code --new-window --wait --diff $LOCAL $REMOTE'
```


