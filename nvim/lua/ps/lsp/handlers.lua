local M = {}

local function make_handler(base, opts)
  return function(err, result, ctx, config)
    config = vim.tbl_extend('force', config or {}, opts)
    base(err, result, ctx, config)
  end
end

function M.with(handlers)
  local _handlers = {}
  for _, handler in ipairs(handlers) do
    _handlers = vim.tbl_extend("keep", _handlers, handler)
  end
  return _handlers
end

function M.default()
  return M.with({ M.hover })
end

M.signature_help = {
  ["textDocument/signatureHelp"] = make_handler(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

M.hover = {
  ["textDocument/hover"] = make_handler(vim.lsp.handlers.hover, { border = "rounded" }),
}

return M
