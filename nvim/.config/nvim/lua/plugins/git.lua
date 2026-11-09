-- Lazygit: <leader>gg (tmux popup) – lásd config/keymaps.lua
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    current_line_blame = false,
    on_attach = function(buf)
      local gs = require("gitsigns")
      local map = function(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buf, desc = desc }) end
      map("n", "]h", function() gs.nav_hunk("next") end, "Következő hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Előző hunk")
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Hunk stage")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Hunk reset")
      map("n", "<leader>hS", gs.stage_buffer, "Buffer stage")
      map("n", "<leader>hR", gs.reset_buffer, "Buffer reset")
      map("n", "<leader>hp", gs.preview_hunk_inline, "Hunk előnézet")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame (sor)")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Blame ki/be")
      map("n", "<leader>hd", gs.diffthis, "Diff")
      map({ "o", "x" }, "ih", ":<C-u>Gitsigns select_hunk<CR>", "Hunk")
    end,
  },
}
