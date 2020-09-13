-- This is global nvim configuration that is loaded at startup via init.vim.

local function map_key(mode, key, result)
  vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
end

local function lsp_on_attach(client)
  map_key('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')
  -- Show documentation.
  map_key('n', 'M', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map_key('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map_key('n', '<space>cr', '<cmd>lua vim.lsp.buf.rename()<CR>')
  map_key('n', '-', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')

  vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
  require'diagnostic'.on_attach()
end

-- Initialize LSP interfaces.
local function init_lsp()

  -- Settings for diagnostic.nvim
  vim.g.diagnostic_enable_virtual_text = 1
  vim.g.diagnostic_insert_delay = 1
  vim.g.diagnostic_enable_underline = 0
  vim.g.space_before_virtual_text = 6

  -- Setup LSP for lua.
  require'nvim_lsp'.sumneko_lua.setup({
    -- on_attach = require'diagnostic'.on_attach,
    on_attach = lsp_on_attach,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
        completion = { keywordSnippet = "Disable", },
        diagnostics = {
          enable = true,
          globals = {
            "vim", "describe", "it", "before_each", "after_each"
          },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          }
        }
      }
    }
  })

  -- Setup LSP for lua.
  -- require'nvim_lsp/sumneko_lua'
  -- require'nvim_lsp'.sumneko_lua.setup{
  --   cmd = require'nvim_lsp/configs'.sumneko_lua.install_info().cmd,
  --   on_attach = require'diagnostic'.on_attach,
  -- }
end

local function config_plugins()

  -- Use floating window for all FZF operations.
  vim.g.fzf_layout = {
    window = {
      width= 0.8,
      height= 0.5
    }
  }
end

local basics = {

  -- Function that is called from init.vim.
  init = function()
    config_plugins()
    init_lsp()
    -- Clear existing search highlights.
    vim.cmd('noh')
  end,

  -- Returns true if running inside a tmux session
  is_tmux = function()
    local tmux = vim.fn.environ()['TMUX']
    return (tmux ~= nil and tmux ~= '')
  end,

  open_terminal = function()
    vim.api.nvim_command('12split | terminal')
  end,

  -- Deletes the file associated with current buffer.
  delete_current_file = function()
    local f = vim.fn.expand('%')
    vim.fn.delete(f)
    vim.api.nvim_command('bdelete!')
    print('Deleted file', f)
  end

}

return basics
