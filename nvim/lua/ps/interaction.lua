
vim.api.nvim_create_user_command(
  "Myterm",
  function(opts)
    vim.cmd('ToggleTerm size=120 direction=vertical')
  end,
  { nargs = 0 }
)


-- When last buffer is deleted, instead of switching to a NONAME buffer, opens
-- the homepage.
vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*",
  callback = function(opts)
    local bufs = vim.tbl_filter(function(bufnr)
      if 1 ~= vim.fn.buflisted(bufnr) then
        return false
      end
      if not vim.api.nvim_buf_is_loaded(bufnr) then
        return false
      end
      if bufnr == opts.buf then
        return false
      end
      return true
    end, vim.api.nvim_list_bufs())

    if vim.tbl_count(bufs) == 1 and vim.api.nvim_buf_get_name(bufs[1]) == '' then
      -- Opens homepage.
      vim.cmd('Alpha')
      vim.api.nvim_buf_delete(bufs[1], {})
    end
  end
})


