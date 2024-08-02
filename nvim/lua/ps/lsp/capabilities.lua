local capabilities = vim.lsp.protocol.make_client_capabilities()

local M = {}

M.update = function(caps)
    capabilities = caps
end


M.get = function()
    return capabilities
end

return M

