-- Alsó státuszsor (LazyVim-szerű elrendezés). theme = "auto": az aktuális (Omarchy) colorschemét követi.
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    -- a módot a lualine mutatja, a betöltésig üres státuszsor ne villanjon
    vim.o.showmode = false
  end,
  opts = function()
    -- gitsigns diff-adatai (gyorsabb, mint a lualine saját git diff-je)
    local function diff_source()
      local gs = vim.b.gitsigns_status_dict
      if gs then return { added = gs.added, modified = gs.changed, removed = gs.removed } end
    end

    return {
      options = {
        theme = "auto",
        globalstatus = vim.o.laststatus == 3,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "[névtelen]" } },
        },
        lualine_x = {
          -- futó DAP session állapota
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = "DiagnosticWarn",
          },
          -- LSP kliensek
          {
            function()
              local names = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
              return " " .. table.concat(names, ", ")
            end,
            cond = function() return #vim.lsp.get_clients({ bufnr = 0 }) > 0 end,
          },
          { "diff", source = diff_source, symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function() return " " .. os.date("%H:%M") end,
        },
      },
      extensions = { "lazy", "oil", "nvim-dap-ui", "quickfix" },
    }
  end,
}
