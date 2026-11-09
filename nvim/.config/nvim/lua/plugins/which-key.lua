return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    spec = {
      { "<leader>a", group = "AI (Claude)" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Kód" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Keresés" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git hunk" },
      { "<leader>l", group = "Laravel" },
      { "<leader>t", group = "Teszt" },
      { "<leader>x", group = "Diagnosztika" },
    },
  },
  keys = {
    { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer keymapek" },
  },
}
