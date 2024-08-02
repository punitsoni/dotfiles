local attach = require 'ps.lsp.attach'
local handlers = require 'ps.lsp.handlers'
local capabilities = require 'ps.lsp.capabilities'

return {
    -- cmd = {...},
    -- filetypes = { ...},
    capabilities = capabilities.get(),
    handlers = handlers.default(),
    on_attach = attach.with_default_config,
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
        },
    }
}
