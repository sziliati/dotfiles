local au = vim.api.nvim_create_autocmd

au("TextYankPost", {
  callback = function() vim.hl.on_yank() end,
})

-- Kurzor visszaállítása az utolsó pozícióra
au("BufReadPost", {
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 2 szóközös behúzás ezeknél
au("FileType", {
  pattern = { "lua", "javascript", "typescript", "vue", "json", "yaml", "html", "css", "blade" },
  callback = function() vim.opt_local.shiftwidth = 2; vim.opt_local.tabstop = 2 end,
})
