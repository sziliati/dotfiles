#!/usr/bin/env bash
# Visszaállítja az eredeti Omarchy/LazyVim Neovim configot.
# Az aktuális (saját) config *.custom-<dátum> néven megmarad.
set -euo pipefail
BAK=omarchy-bak-20261109
NOW=custom-$(date +%Y%m%d-%H%M%S)
for d in "$HOME/.config/nvim" "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"; do
  [[ -e "$d" ]] && mv "$d" "$d.$NOW"
  [[ -e "$d.$BAK" ]] && mv "$d.$BAK" "$d"
done
echo "Visszaállítva. A saját config: ~/.config/nvim.$NOW"
