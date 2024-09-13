# Interactive search for string in current directory.
# Requires: rg, fzf, bat
# ripgrep->fzf->vim [QUERY]
cmd::frg() {
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
}
