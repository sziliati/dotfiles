-- Lebegő konzol (snacks.nvim terminál), a Claude-hoz hasonlóan.
-- Alt+.  → ki/be (normal, visual ÉS a konzolon belül is)
-- Mindig abból a mappából indul, ahol a Neovimot elindítottad
-- (egy :cd később nem változtatja meg). Elrejtéskor a shell tovább fut.
local toggle_key = "<M-.>"
local start_dir = vim.fn.getcwd()

local function toggle()
  Snacks.terminal.toggle(nil, {
    cwd = start_dir,
    win = {
      position = "float",
      width = 0.85,
      height = 0.85,
      border = "rounded",
      backdrop = 60,
      title = " Konzol ",
      title_pos = "center",
      keys = {
        term_hide = { toggle_key, function(self) self:hide() end, mode = "t", desc = "Konzol elrejtése" },
      },
    },
  })
end

return {
  "folke/snacks.nvim",
  keys = {
    { toggle_key, toggle, mode = { "n", "x" }, desc = "Konzol ki/be (lebegő)" },
  },
}
