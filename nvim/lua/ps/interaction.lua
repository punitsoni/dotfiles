local util = require 'ps.utils'

-- Augroup for all autocommands from here.
local group_id = vim.api.nvim_create_augroup('interaction', {})

-- Event handler that is called when a new terminal is opened.
local function OnTermOpen(ev)
  -- Setup the terminal buffer.
  local nmap = util.nmap
  vim.cmd("setlocal nonumber norelativenumber")
  -- nmap('<LeftRelease>', '<LeftRelease>i', { buffer = ev.buf })
  vim.cmd('startinsert')
end

-- Do not continue comments when pressing enter.
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = group_id,
  command = 'set formatoptions-=ro'
})

-- Disable line numbers in terminal.
vim.api.nvim_create_autocmd("TermOpen", {
  group = group_id,
  pattern = "*",
  callback = OnTermOpen,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = group_id,
  pattern = "term://*",
  callback = function()
    vim.cmd('startinsert')
  end,
})

-- When last buffer is deleted, instead of switching to a NONAME buffer, opens
-- the homepage.
vim.api.nvim_create_autocmd("BufDelete", {
  group = group_id,
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
      require 'ps.ui'.homepage()
      vim.api.nvim_buf_delete(bufs[1], {})
    end
  end
})

function OpenScratchBuffer()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
  vim.bo.filetype = 'lua' -- Set to your preferred filetype
end

--- Custom Commands ---

vim.api.nvim_create_user_command('Scratch', OpenScratchBuffer, {})

vim.api.nvim_create_user_command(
  "Myterm",
  function(opts)
    vim.cmd('ToggleTerm size=120 direction=vertical')
  end,
  { nargs = 0 }
)

vim.api.nvim_create_user_command('LspDebugEnable',
  function(opts)
    vim.lsp.set_log_level('error')
    require('vim.lsp.log').set_format_func(vim.inspect)
  end,
  {})

vim.api.nvim_create_user_command('LspDebugDisable',
  function(opts)
    vim.lsp.set_log_level('off')
  end,
  {})

-- Clear contents of lsp log.
vim.api.nvim_create_user_command('LspClearLog',
  function(opts)
    local filepath = vim.lsp.get_log_path()
    local file = io.open(filepath, 'w')
    if file then
      file:write('')
      file:close()
    else
      print("Failed to open the file: " .. filepath)
    end
  end,
  {})
