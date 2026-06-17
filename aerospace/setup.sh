#!/usr/bin/env bash
# Generates ~/.config/aerospace/aerospace.toml by merging the base config
# with a machine-specific monitor assignment snippet (keyed by serial number).
set -euo pipefail

SERIAL=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
MACHINE_MONITORS="${DOTFILES}/aerospace/machines/${SERIAL}.toml"
BASE="${DOTFILES}/aerospace/aerospace.toml"
DST="${HOME}/.config/aerospace/aerospace.toml"

mkdir -p "$(dirname "$DST")"

if [[ -f "$MACHINE_MONITORS" ]]; then
    cat "$BASE" "$MACHINE_MONITORS" > "$DST"
    echo "  [aerospace] merged base + ${SERIAL} monitor config"
else
    cp "$BASE" "$DST"
    echo "  [aerospace] using base config (no machine config for ${SERIAL})"
fi
