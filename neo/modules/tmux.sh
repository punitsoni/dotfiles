
# get a list of currently running tmux panes

cmd::tmux_panes() {
    tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_pid} #{pane_current_command}'
}
