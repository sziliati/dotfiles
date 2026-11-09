-- Claude Code lebegő ablakban (snacks.nvim terminál).
-- Alt+,  → ki/be (normal, visual ÉS a Claude ablakon belül is)
local toggle_key = "<M-,>"

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd", "ClaudeCodeTreeAdd" },
  opts = {
    terminal = {
      provider = "snacks",
      -- Mindig a projekt gyökeréből indul (git repo / composer.json / artisan),
      -- az aktuális fájl helyéből felfelé keresve; ha nincs, a Neovim cwd-je.
      cwd_provider = function(ctx)
        local from = ctx.file_dir or ctx.cwd
        return vim.fs.root(from, { ".git", "artisan", "composer.json", "package.json" }) or ctx.cwd
      end,
      ---@type snacks.win.Config|{}
      snacks_win_opts = {
        position = "float",
        width = 0.85,
        height = 0.85,
        border = "rounded",
        backdrop = 60,
        title = " Claude Code ",
        title_pos = "center",
        keys = {
          claude_hide = { toggle_key, function(self) self:hide() end, mode = "t", desc = "Claude elrejtése" },
        },
      },
    },
  },
  keys = {
    { toggle_key, "<cmd>ClaudeCodeFocus<CR>", mode = { "n", "x" }, desc = "Claude ki/be (lebegő)" },
    { "<leader>ac", "<cmd>ClaudeCodeFocus<CR>", desc = "Claude ki/be (lebegő)" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<CR>", desc = "Claude resume" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<CR>", desc = "Claude continue" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Modell választás" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>", desc = "Buffer hozzáadása" },
    { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Kijelölés küldése" },
    { "<leader>as", "<cmd>ClaudeCodeTreeAdd<CR>", ft = { "oil" }, desc = "Fájl hozzáadása" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Diff elfogadása" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Diff elutasítása" },
    { "<leader>aq", "<cmd>ClaudeCodeClose<CR>", desc = "Claude bezárása (leállítás)" },
  },
}
