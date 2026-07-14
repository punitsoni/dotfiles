# shellcheck shell=bash
# Library of shell functions.

neo() {
  "${DOTFILES}/neo/neo.sh" "$@"
}

# Show message for an error when loading this bashrc.
__shrc_show_error() {
  echo "Error: $1"
  echo "Please setup your bashrc according to:"
  echo "https://github.com/punitsoni/dotfiles/tree/dev/bash"
}

# Detect current platform.
__shrc_detect_platform() {
  if [[ $(uname) == 'Linux' ]]; then
    echo 'Linux'
  elif [[ $(uname) == 'Darwin' ]]; then
    echo 'macOS'
  else
    echo 'Unknown'
  fi
}

# Returns true if platform is MacOS.
is_macos() {
  [[ $(uname) == 'Darwin' ]]
}

has_command() {
  command -v "$1" &> /dev/null
}

# Attach to or create a tmux session.
# Usage: tm [session-name]
# If no name given, opens an interactive fzf picker.
tm() {
  local session
  session=$(bash "$DOTFILES/scripts/tmux_sessionizer.sh" "$@")
  [[ -z "$session" ]] && return 0

  # Create the session if it doesn't exist yet.
  tmux has-session -t "$session" 2>/dev/null || tmux new-session -ds "$session"

  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$session"
  else
    # Use `script` to allocate a pty when stdout isn't a terminal (e.g. iTerm).
    script /dev/null tmux new-session -A -s "$session"
  fi
}

# Attach to or create a zellij session.
# Usage: zm [session-name]
# If no name given, opens an interactive fzf picker.
zm() {
  if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<'EOF'
zm - attach to or create a zellij session

Usage:
  zm             Open an interactive fzf picker of existing sessions
  zm <name>      Attach to (or create) the session named <name>
  zm help        Show this help
EOF
    return 0
  fi

  local session
  session=$(bash "$DOTFILES/scripts/zellij_sessionizer.sh" "$@")
  [[ -z "$session" ]] && return 0

  if [[ -n "${ZELLIJ:-}" ]]; then
    zellij action switch-session "$session"
  else
    zellij attach -c "$session"
  fi
}

# Returns a string corresponding to the variant of ls command present in the
# system.
ls_version() {
  if ls --color -d . >/dev/null 2>&1; then
    echo "GNU_LS"
  elif ls -G -d . >/dev/null 2>&1; then
    echo "BSD_LS"
  else
    echo "SOLARIS_LS"
  fi
}

# Fuzzy find a file and open in editor.
ff() {
  local dir="${1:-.}"

  __editable_files() {
    find "$dir" \
      -type f \
      \( -not -path "*/.git/*" \) \
      \( -not -path "*/__pycache__/*" \) \
      \( -not -name "*.bin" \) \
      \( -not -name "*.out" \) \
      \( -not -name "*.o" \) \
      \( -not -name "*.pyc" \)
  }

  __open_fzf() {
    fzf --height=30%   \
        --border=sharp \
        --prompt='>> ' \
        --keep-right
  }

  local file
  file=$(__editable_files | __open_fzf)
  [[ -n "$file" ]] && $EDITOR "$file"
}


# Set terminal cursor shape.
cursor() {
  if [[ $1 == "block" ]]; then
      echo -ne '\e[2 q'
  else
      echo -ne '\e[6 q'
  fi
}

# Run jupyter QtConsole with configuration.
jqt() {
  nohup jupyter qtconsole --no-confirm-exit --paging vsplit \
    --JupyterWidget.font_size=12 1>&2 > /dev/null &
  echo "Jupyter QtConsole started."
}

# Run a command completely detached from terminal.
run_detached() {
  nohup "$@" < /dev/null > /dev/null 2>&1
}

# Open a file in desktop UI.
xo() {
  run_detached xdg-open "$1"
}

# Show $PATH variable with each entry in its own line.
showpath() {
  echo "${PATH//:/$'\n'}"
}

# Print the hardware serial number of this machine.
machine_serial() {
  system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}'
}
