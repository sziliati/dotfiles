return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      window = {
        layout = 'vertical',
        width = 0.4,
        relative = 'editor',
      },
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      vim.cmd([[
        augroup CopilotChatWindow
          autocmd!
          autocmd FileType copilot-chat wincmd L
        augroup END
      ]])
    end,
  }
}
