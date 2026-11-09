return {
  -- Szerver-definíciók (lsp/*.lua) a native vim.lsp.config/enable-hez
  { "neovim/nvim-lspconfig", lazy = false },

  -- Külső binárisok telepítése (LSP, formatter, linter, debug adapter)
  {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = false,
    opts = {
      ensure_installed = {
        "intelephense",
        "lua-language-server",
        "pint",
        "phpstan",
        "stylua",
        "php-debug-adapter",
        "blade-formatter",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint",
      },
    },
  },

  -- Lua fejlesztés a Neovim API-hoz
  { "folke/lazydev.nvim", ft = "lua", opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },
}
