vim.keymap.set("n", "<S-Up>", "10k", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Down>", "10j", { noremap = true, silent = true })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Cmd>w<CR>", { noremap = true, silent = true })
