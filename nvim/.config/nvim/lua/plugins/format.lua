return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true }) end, mode = { "n", "v" }, desc = "Formázás" },
    {
      "<leader>cF",
      function()
        vim.g.autoformat = not vim.g.autoformat
        vim.notify("Formázás mentéskor: " .. (vim.g.autoformat and "BE" or "KI"))
      end,
      desc = "Formázás mentéskor ki/be",
    },
  },
  init = function() vim.g.autoformat = true end,
  opts = {
    -- A pint a projekt vendor/bin/pint-jét használja, ha van (különben a Mason-féle)
    formatters_by_ft = {
      php = { "pint" },
      blade = { "blade-formatter" },
      lua = { "stylua" },
    },
    format_on_save = function()
      if vim.g.autoformat then return { timeout_ms = 3000, lsp_format = "fallback" } end
    end,
  },
}
