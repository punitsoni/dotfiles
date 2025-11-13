
# ln -s ~/dotfiles/tmux ~/.config/

# git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

#!/usr/bin/env bash
set -euo pipefail

# Ensure Homebrew is available
if ! command -v brew >/dev/null 2>&1; then
  echo ">> Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install tmux if not installed
if ! command -v tmux >/dev/null 2>&1; then
  echo ">> Installing tmux..."
  brew install tmux
fi

TMUX_CONFIGDIR=~/.config/tmux

ln -s ~/dotfiles/tmux ${TMUX_CONFIGDIR}

echo ">> Setting up Tmux Plugin Manager (TPM) ..." 

# Clone TPM if not already installed
TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Cloning TPM into ${TPM_DIR}..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "TPM is already installed at ${TPM_DIR}"
fi

echo "✅ TPM setup complete!"


