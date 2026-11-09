return {
  "adibhanna/laravel.nvim",
  ft = { "php", "blade" },
  cmd = { "Artisan", "Composer", "Laravel" },
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>la", "<cmd>Artisan<CR>", desc = "Artisan" },
    { "<leader>lc", "<cmd>Composer<CR>", desc = "Composer" },
    { "<leader>lr", "<cmd>Artisan route:list<CR>", desc = "Route-ok" },
  },
  config = function() require("laravel").setup() end,
}
