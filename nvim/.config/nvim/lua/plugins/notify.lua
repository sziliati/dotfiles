-- vim.notify üzenetek buborékokban, jobb felül (snacks.nvim notifier).
-- A snacks spec többi része a terminal.lua-ban van, a lazy.nvim összefésüli őket.
return {
  "folke/snacks.nvim",
  lazy = false, -- a notifiernek indulásnál kell betöltődnie, hogy a korai üzeneteket is elkapja
  priority = 1000,
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "compact", -- keretes buborék, címsorban az ikonnal; alternatíva: "fancy", "minimal"
      top_down = true, -- jobb felső sarokból lefelé rendeződnek
    },
  },
  keys = {
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Értesítések előzménye" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Értesítések elrejtése" },
  },
}
