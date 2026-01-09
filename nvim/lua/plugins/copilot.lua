return {
  {
    "github/copilot.vim",   -- official Copilot plugin
    event = "InsertEnter", -- lazy-load on Insert mode
    config = function()
      -- Disable Copilot tab mapping if you want custom keys:
      vim.g.copilot_no_tab_map = true
      -- If you set custom mapping, tell Copilot not to assume defaults
      vim.g.copilot_assume_mapped = true

      -- Custom keymaps to accept suggestions
      vim.api.nvim_set_keymap("i", "<C-l>", 
        "copilot#Accept(\"<CR>\")", { expr = true, silent = true })

      -- Optional: toggle Copilot on/off
      vim.api.nvim_create_user_command("ToggleCopilot", function()
        vim.cmd("Copilot toggle")
      end, { desc = "Toggle GitHub Copilot" })
    end
  }
}
