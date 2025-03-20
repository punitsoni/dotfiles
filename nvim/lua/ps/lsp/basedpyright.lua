local attach = require 'ps.lsp.attach'
local handlers = require 'ps.lsp.handlers'
local capabilities = require 'ps.lsp.capabilities'

return {
  -- cmd = {...},
  capabilities = capabilities.get(),
  handlers = handlers.default(),
  on_attach = attach.with_default_config,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard"
      },
    },
  },
}
