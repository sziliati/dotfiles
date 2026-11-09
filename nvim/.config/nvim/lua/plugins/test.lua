return {
  "vim-test/vim-test",
  dependencies = { "preservim/vimux" },
  cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
  keys = {
    { "<leader>tn", "<cmd>TestNearest<CR>", desc = "Legközelebbi teszt" },
    { "<leader>tf", "<cmd>TestFile<CR>", desc = "Fájl tesztjei" },
    { "<leader>ts", "<cmd>TestSuite<CR>", desc = "Teljes suite" },
    { "<leader>tl", "<cmd>TestLast<CR>", desc = "Utolsó teszt" },
    { "<leader>tv", "<cmd>TestVisit<CR>", desc = "Utolsó tesztfájl megnyitása" },
  },
  init = function()
    -- tmux alatt egy tmux pane-ben fut (vimux), egyébként Neovim terminálban
    vim.g["test#strategy"] = vim.env.TMUX and "vimux" or "neovim"
    vim.g["test#neovim#start_normal"] = 1
    vim.g["test#php#pest#executable"] = "php artisan test"
  end,
}
