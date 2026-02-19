-- Tab and indentation settings
vim.opt.tabstop = 4        -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4     -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.softtabstop = 4    -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.smartindent = true -- Smart autoindenting when starting a new line
vim.opt.autoindent = true  -- Copy indent from current line when starting a new line
vim.opt.number = true
vim.opt.cursorline = true

require("config.lazy")

-- create missing directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local dir = vim.fn.expand("%:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- save for ctrl + save
vim.keymap.set("n", "<leader>w", ":w<CR>", { silent = true })

-- map Ctrl-S in normal and visual modes: save and show notification
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>:lua vim.notify('File saved', vim.log.levels.INFO)<CR>", { silent = true })
-- map Ctrl-S in insert mode: run a single normal-mode command to save and notify, staying in insert
vim.keymap.set("i", "<C-s>", "<C-o>:w<CR>:lua vim.notify('File saved', vim.log.levels.INFO)<CR>", { silent = true })
