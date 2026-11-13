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
    opts = function()
      local tools = {
        "intelephense",
        "lua-language-server",
        "stylua",
        "php-debug-adapter",
        "blade-formatter",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint",
      }
      -- A pint és a phpstan composerrel települ, ami PHP nélkül hibát dobna
      if vim.fn.executable("php") == 1 and vim.fn.executable("composer") == 1 then
        vim.list_extend(tools, { "pint", "phpstan" })
      end
      return { ensure_installed = tools }
    end,
  },

  -- Lua fejlesztés a Neovim API-hoz
  { "folke/lazydev.nvim", ft = "lua", opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },
}
