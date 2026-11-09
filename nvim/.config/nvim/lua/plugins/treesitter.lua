-- nvim-treesitter (main ág, Neovim 0.11+): a parsereket telepíti,
-- a kiemelést a beépített vim.treesitter.start() adja.
local parsers = {
  "php", "php_only", "phpdoc", "blade", "html", "css", "javascript", "typescript", "tsx", "vue",
  "json", "yaml", "toml", "lua", "luadoc", "vim", "vimdoc", "query", "bash", "sql",
  "markdown", "markdown_inline", "dockerfile", "gitcommit", "diff", "regex",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install(parsers)

    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
        -- Docker Compose: saját filetype a compose LSP-hez, kiemelés yaml-ként
        [".*/?docker%-compose[^/]*%.ya?ml"] = "yaml.docker-compose",
        [".*/?compose[^/]*%.ya?ml"] = "yaml.docker-compose",
        -- Dockerfile.dev, app.Dockerfile, Containerfile stb.
        [".*/?Dockerfile%..*"] = "dockerfile",
        [".*%.[Dd]ockerfile"] = "dockerfile",
      },
      filename = { Containerfile = "dockerfile" },
    })
    vim.treesitter.language.register("yaml", "yaml.docker-compose")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldlevel = 99
        end
      end,
    })
  end,
}
