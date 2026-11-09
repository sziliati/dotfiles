local o = vim.opt

o.number = true
o.relativenumber = false
o.signcolumn = "yes"
o.cursorline = true
o.termguicolors = true
o.mouse = "a"
o.clipboard = "unnamedplus"
o.undofile = true
o.swapfile = false
o.ignorecase = true
o.smartcase = true
o.splitright = true
o.splitbelow = true
o.scrolloff = 8
o.updatetime = 250
o.timeoutlen = 400
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true
o.wrap = false
o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
o.inccommand = "split"
o.confirm = true
o.winborder = "rounded"
o.laststatus = 3

-- Omarchy: vágólap tmux / SSH alatt is (wl-copy, tmux buffer, OSC 52)
require("config.remote_clipboard").setup()
