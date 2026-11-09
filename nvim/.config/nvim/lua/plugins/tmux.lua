-- <C-h/j/k/l> navigáció Neovim splitek és tmux pane-ek között
-- (a tmux oldali bindingok a tmux configban kellenek – lásd README)
return {
  "christoomey/vim-tmux-navigator",
  cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<CR>" },
    { "<C-j>", "<cmd>TmuxNavigateDown<CR>" },
    { "<C-k>", "<cmd>TmuxNavigateUp<CR>" },
    { "<C-l>", "<cmd>TmuxNavigateRight<CR>" },
  },
}
