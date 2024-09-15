
status bar for yabai

https://github.com/somdoron/spacebar

To use macbook as a server or a remote ssh-host, we need to disable sleeping
when lid is closed.

```
# Disable sleep.
sudo pmset -a disablesleep 1

# Enable sleep.
sudo pmset -a disablesleep 0
```

Workaround for "Clock is behind" problem

```
sudo sntp -sS time.apple.com
```
