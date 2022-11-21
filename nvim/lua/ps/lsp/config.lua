
local M = {}

-- This function is called when LSP client is attached to a buffer.
local function lsp_on_attach(client, bufnr)

  local function buf_keymap(mode, lhs, rhs, opts)
    if not opts then
      opts = {}
    end
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  buf_keymap("n", "K", vim.lsp.buf.hover)
  buf_keymap("n", "gd", vim.lsp.buf.definition)
  buf_keymap("n", "gt", vim.lsp.buf.type_definition)
  buf_keymap("n", "gr", vim.lsp.buf.references)
  buf_keymap("n", "gi", vim.lsp.buf.implementation)
  -- Goto next/prev diagnositc.
  buf_keymap("n", "<space>gj", vim.diagnostic.goto_next)
  buf_keymap("n", "<space>gk", vim.diagnostic.goto_prev)
  -- Rename symbol.
  buf_keymap("n", "<space>r", vim.lsp.buf.rename)

end

-- LSP config for lua language.
local function setup_lua(lspconfig)
  -- TODO: install the language server binary automatically.

  -- Setup lua_language_server
  lspconfig.sumneko_lua.setup {
    on_attach = lsp_on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

M.init = function()
  -- npcall returns nil if module not found.
  local lspconfig = vim.F.npcall(require, "lspconfig")

  if not lspconfig then
    return
  end

  setup_lua(lspconfig)

end

return M

