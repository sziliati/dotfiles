return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = { php = { "phpstan" }, dockerfile = { "hadolint" } }

    -- Projekt-szintű phpstan előnyben (vendor/bin), a phpstan.neon-t a gyökérben keresi
    lint.linters.phpstan.cmd = function()
      local local_bin = vim.fs.find("vendor/bin/phpstan", { upward = true, path = vim.fn.expand("%:p:h") })[1]
      return local_bin or "phpstan"
    end

    local function run()
      local root = vim.fs.root(0, { "composer.json", ".git" })
      lint.try_lint(nil, { cwd = root })
    end
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = run,
    })
    vim.schedule(run) -- a betöltést kiváltó első bufferre is (filetype után)
    vim.keymap.set("n", "<leader>cl", function() lint.try_lint() end, { desc = "Lint futtatása" })
  end,
}
