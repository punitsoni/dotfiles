-- TODO: Explore keymap that is implemented here.
-- https://github.com/fitrh/init.nvim/blob/7127fbef569ee498b1cbfae62ef372050b07afbc/lua/keymap/lsp.lua

local M = {}

local function GotoDefinition()
  vim.lsp.buf.definition()
  vim.cmd 'normal zz'
end

local function ShowReferences()
  vim.cmd('Glance references')
end

-- Attaches key-mapping to a given buffer.
function M.attach(bufnr)
  local function buf_nmap(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  buf_nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
  buf_nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  buf_nmap('<C-.>', vim.lsp.buf.code_action, 'Code Action')

  buf_nmap("gd", GotoDefinition, 'Goto Definition')
  buf_nmap('gr', ShowReferences, 'References')
  buf_nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  buf_nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  buf_nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  buf_nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- See `:help K` for why this keymap
  buf_nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  buf_nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  buf_nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  buf_nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  buf_nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  buf_nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  buf_nmap('<leader>uf', function()
    vim.lsp.buf.format()
  end, 'LSP Format Buffer')
end

return M
