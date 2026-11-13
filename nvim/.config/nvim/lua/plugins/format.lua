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
    -- A pint a projekt vendor/bin/pint-jét használja, ha van (különben a Mason-féle).
    -- PHP nélkül a pint nem fut, ilyenkor üres listát adunk (nincs hibaüzenet, LSP fallback).
    formatters_by_ft = {
      php = function() return vim.fn.executable("php") == 1 and { "pint" } or {} end,
      blade = { "blade-formatter" },
      lua = { "stylua" },
    },
    format_on_save = function()
      if vim.g.autoformat then return { timeout_ms = 3000, lsp_format = "fallback" } end
    end,
  },
}
