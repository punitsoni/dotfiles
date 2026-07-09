local M = {}


function M.attach(client, bufnr)
  local function create_cmd(name, func, desc)
    vim.api.nvim_buf_create_user_command(bufnr, name, func,
      { desc = desc })
  end

  create_cmd(
    'Format',
    function(_)
      vim.lsp.buf.format()
    end,
    'Format current buffer with LSP'
  )

  create_cmd(
    'LspSignatureHelp',
    function(_)
      vim.lsp.buf.signature_help()
    end,
    'Signature Help'
  )

  create_cmd(
    'LspInfo',
    function(_)
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      if #clients == 0 then
        vim.notify('No LSP clients attached to this buffer', vim.log.levels.WARN)
        return
      end
      local lines = { 'LSP clients for buffer ' .. bufnr .. ' (' .. vim.fn.expand('%:t') .. '):', '' }
      for _, c in ipairs(clients) do
        table.insert(lines, '  name:      ' .. c.name)
        table.insert(lines, '  id:        ' .. c.id)
        table.insert(lines, '  root_dir:  ' .. (c.config.root_dir or 'n/a'))
        table.insert(lines, '  cmd:       ' .. table.concat(c.config.cmd or {}, ' '))
        table.insert(lines, '')
      end
      vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
    end,
    'Show LSP clients attached to current buffer'
  )

  -- TODO: add more commands here as per
  -- https://github.com/fitrh/init.nvim/blob/7127fbef569ee498b1cbfae62ef372050b07afbc/lua/lsp/attach.lua
end

return M
