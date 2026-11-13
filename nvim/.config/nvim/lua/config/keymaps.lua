local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Mentés" })
-- Ctrl+S: mentés (a conform format_on_save-je formáz előtte) és vissza normal módba
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>write<CR><Esc>", { desc = "Mentés + formázás" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Kilépés" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Előző buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Következő buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Buffer bezárása" })
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Diagnosztika (sor)" })
map("n", "<leader>xq", vim.diagnostic.setloclist, { desc = "Diagnosztika → loclist" })

-- Külső TUI-k: tmux alatt popupban, egyébként lebegő terminálban
local function tui(cmd)
  return function()
    local cwd = vim.fn.getcwd()
    if vim.env.TMUX then
      vim.system({ "tmux", "display-popup", "-E", "-w", "92%", "-h", "90%", "-d", cwd, cmd })
    else
      local buf = vim.api.nvim_create_buf(false, true)
      local w, h = math.floor(vim.o.columns * 0.92), math.floor(vim.o.lines * 0.9)
      vim.api.nvim_open_win(buf, true, {
        relative = "editor", width = w, height = h,
        col = math.floor((vim.o.columns - w) / 2), row = math.floor((vim.o.lines - h) / 2),
      })
      vim.fn.jobstart(cmd, {
        term = true, cwd = cwd,
        on_exit = function() pcall(vim.api.nvim_buf_delete, buf, { force = true }) end,
      })
      vim.cmd.startinsert()
    end
  end
end
map("n", "<leader>gg", tui("lazygit"), { desc = "Lazygit" })
map("n", "<leader>D", tui("lazysql"), { desc = "Lazysql (adatbázis)" })

-- Fájl útvonalának másolása a vágólapra (konténerből is, a remote_clipboard révén)
local function copy_path(fn)
  return function()
    local text = fn()
    if text == "" then return vim.notify("Nincs fájl a bufferben", vim.log.levels.WARN) end
    vim.fn.setreg("+", text)
    vim.notify("Kimásolva: " .. text)
  end
end
map("n", "<leader>yp", copy_path(function() return vim.fn.expand("%:.") end), { desc = "Relatív útvonal másolása" })
map("n", "<leader>yl", copy_path(function()
  local p = vim.fn.expand("%:.")
  return p == "" and "" or p .. ":" .. vim.fn.line(".")
end), { desc = "Relatív útvonal + sor másolása" })
map("n", "<leader>yP", copy_path(function() return vim.fn.expand("%:p") end), { desc = "Abszolút útvonal másolása" })
