local keymap = require("ps.lsp.keymap")
local command = require 'ps.lsp.command'
-- local ui = { diagnostic = require("lsp.ui.diagnostic") }

local function default(client, bufnr)
  -- if client.resolved_capabilities.code_lens then
  --   vim.lsp.codelens.refresh()
  -- end
  -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- command.buffer.attach(client)
  -- command.codelens.attach(client)
  -- command.diagnostic.attach()
  -- keymap.attach(bufnr)
  -- event.attach(client)
  -- ui.diagnostic.attach()
end

------------------------------------------------------------------------------
------------------------------- Public API -----------------------------------
------------------------------------------------------------------------------

local M = {}

function M.with_default_config(client, bufnr)
  keymap.attach(client, bufnr)
  command.attach(client, bufnr)

  -- io.stdout:write(vim.inspect(client)..'\n')
  -- vim.print(client)
  -- vim.print(vim.inspect(client))
  -- vim.cmd('quit')
end

-- function M.with_lsp_status(client)
--   local status = require("lsp-status")
--   local config = require("plugin.lspstatus.config")
--   status.register_progress()
--   status.on_attach(client)
--   status.config(config)
-- end
--
-- function M.without_formatting(client)
--   client.resolved_capabilities.document_formatting = false
--   client.resolved_capabilities.document_range_formatting = false
-- end

return M
