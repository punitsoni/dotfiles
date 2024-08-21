# Library of shell functions.

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
  command -v $1 &> /dev/null
}

# Attach to tmux session. Create new session if it does not exist.
# If no argument provided. It attaches to session 0.
tm() {
  # if [ -z $1 ]; then
  #   tmux new-session -A -s 0
  # else
  #   tmux new-session -A -s $1
  # fi
  bash $DOTFILES/scripts/tmux_sessionizer.sh $@
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
  dir=$1

  if [[ -z $dir ]]; then
    dir=.
  fi

  __editable_files() {
    find $dir \
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

  file=$(__editable_files | __open_fzf)

  [[ ! -z $file ]] && $EDITOR $file
}

# ripgrep->fzf->vim [QUERY]
# Requires `bat` --> brew install bat
frg() {
  dir=$1

  if [[ -z $dir ]]; then
    dir=.
  fi

  RELOAD="reload:rg --column --color=always --smart-case {q} ${dir}|| :"
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            ${EDITOR} {1} +{2}     # No selection. Open the current line in Vim.
          else
            ${EDITOR} +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --delimiter : \
      --query ""

      # --delimiter / --with-nth -1 \
}


# Set terminal cursor shape.
cursor() {
  if [[ $1 == "block" ]]; then
      # Set terminal cursor to block.
      echo -ne '\e[2 q';
  else
      # Default: Set terminal cursor to I-beam.
      echo -ne '\e[6 q';
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
  run_detached xdg-open $1
}

# Show $PATH variable with each entry in its own line.
showpath() {
  sed 's/:/\n/g' < echo ${PATH}
}

random_chuck_joke() {
  wget "http://api.icndb.com/jokes/random" -qO- | \
    jshon -e value -e joke -u | recode html | cowsay | lolcat
}

# Displays weather in your city.
weather() {
  curl "wttr.in?q0uFnM";
}


