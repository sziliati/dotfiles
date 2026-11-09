return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files<CR>", desc = "Fájlok" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Fájlok" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<CR>", desc = "Szó a kurzor alatt" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Bufferek" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Legutóbbi fájlok" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Súgó" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymapek" },
    { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnosztika" },
    { "<leader>f.", "<cmd>Telescope resume<CR>", desc = "Utolsó keresés folytatása" },
    { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Keresés a bufferben" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commitok" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git status" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        file_ignore_patterns = { "^.git/", "^node_modules/", "^vendor/" },
      },
      pickers = {
        find_files = { hidden = true },
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
  end,
}
