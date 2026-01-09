return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git/", "vendor/"},
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_cutoff = 120,
              prompt_position = "left",
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
          },
          live_grep = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
          },
        },
      })

      -- Set up keymaps
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find help" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Find commands" })
    end,
  }
