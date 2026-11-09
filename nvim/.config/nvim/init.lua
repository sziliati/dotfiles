-- Saját Neovim config (Neovim 0.11+ native LSP, lazy.nvim)
-- Az eredeti Omarchy config: ~/.config/nvim.omarchy-bak-20261109 (visszaállítás: ./restore-omarchy-nvim.sh)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.lsp")
