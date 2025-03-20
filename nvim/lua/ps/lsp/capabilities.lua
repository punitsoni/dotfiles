local caps_ = vim.lsp.protocol.make_client_capabilities()

local M = {}

M.update = function(caps)
  -- vim.print('caps before')
  -- vim.print(caps_)
  vim.tbl_deep_extend("force", caps_, caps)
  -- vim.print('updated caps')
  -- vim.print(caps_)
end


M.get = function()
  return caps_
end

return M
