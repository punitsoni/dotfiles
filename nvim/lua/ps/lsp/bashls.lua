local attach = require 'ps.lsp.attach'
local handlers = require 'ps.lsp.handlers'
local capabilities = require 'ps.lsp.capabilities'

return {
  capabilities = capabilities.get(),
  handlers = handlers.default(),
  on_attach = attach.with_default_config,
  single_file_support = true,
  settings = {}
}
