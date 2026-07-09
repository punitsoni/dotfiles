-- Swift development support.
-- Relies on sourcekit-lsp configured in lua/ps/lsp/sourcekit.lua.
-- No extra plugins are strictly required; this file wires up quality-of-life
-- details for Swift buffers.

local function swift_augroup()
  local group = vim.api.nvim_create_augroup('ps_swift', { clear = true })

  -- Enable inlay hints automatically when entering a Swift buffer.
  -- sourcekit-lsp serves these for parameter labels and inferred types.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    pattern = { '*.swift' },
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == 'sourcekit' then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end,
    desc = 'Enable inlay hints for Swift (sourcekit-lsp)',
  })
end

swift_augroup()

return {}
