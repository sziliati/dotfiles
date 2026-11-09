-- Neovim 0.11+ native LSP. A szerver-definíciókat (cmd, filetypes, root_markers)
-- az nvim-lspconfig `lsp/*.lua` fájljai adják, itt csak felülírunk és engedélyezünk.

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("intelephense", {
  filetypes = { "php", "blade" },
  settings = {
    intelephense = {
      files = { maxSize = 5000000 },
      environment = { phpVersion = "8.4" },
      -- Prémium licenc: ~/intelephense/licence.txt (automatikusan beolvassa)
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.enable({ "intelephense", "lua_ls", "dockerls", "docker_compose_language_service" })

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { spacing = 2, source = "if_many" },
  float = { source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

-- Beépített alapok (0.11+): K, grn (rename), gra (code action), grr (references),
-- gri (implementation), grt (type def), gO (symbols), <C-s> (signature, insert)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc }) end
    local tb = require("telescope.builtin")
    map("gd", tb.lsp_definitions, "Definíció")
    map("gD", vim.lsp.buf.declaration, "Deklaráció")
    map("gr", tb.lsp_references, "Hivatkozások")
    map("gI", tb.lsp_implementations, "Implementációk")
    map("<leader>cr", vim.lsp.buf.rename, "Átnevezés")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>cs", tb.lsp_document_symbols, "Szimbólumok (fájl)")
    map("<leader>cS", tb.lsp_dynamic_workspace_symbols, "Szimbólumok (projekt)")
    map("<leader>ch", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
    end, "Inlay hintek ki/be")
  end,
})
