--------------------------------------------------------------------------------
----------------------------- The basics module --------------------------------
--------------------------------------------------------------------------------

local nvim_lsp = require('nvim_lsp')
local M = {}

-- Create a global key mapping. Similar to *noremap command.
function M.mapkey(mode, from_keys, to_keys)
  vim.fn.nvim_set_keymap(mode, from_keys, to_keys, {
     noremap = true,
     silent = true
   })
end

-- Create a buffer key mapping. Similar to *noremap <buffer> command.
function M.mapkey_buffer(mode, from_keys, to_keys)
  vim.fn.nvim_buf_set_keymap(0, mode, from_keys, to_keys, {
     noremap = true,
     silent = true
   })
end

-- Custom function that is to be run after LSP client is attached.
local function lsp_on_attach(_)
  require'diagnostic'.on_attach()
  require'completion'.on_attach()

  M.mapkey_buffer('n', '<c-]>'     , '<cmd>lua vim.lsp.buf.definition()<CR>')
  M.mapkey_buffer('n', 'gd'        , '<cmd>lua vim.lsp.buf.definition()<CR>')
  M.mapkey_buffer('n', 'M'         , '<cmd>lua vim.lsp.buf.hover()<CR>')
  M.mapkey_buffer('n', '<space>la' , '<cmd>lua vim.lsp.buf.code_action()<CR>')
  M.mapkey_buffer('n', '<space>lr' , '<cmd>lua vim.lsp.buf.rename()<CR>')
  M.mapkey_buffer('n', '-'         , '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')

  -- Use the LSP for providing completion for this buffer.
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

end

-- Initialize LSP interfaces.
local function init_lsp()
  -- Settings for diagnostic.nvim
  vim.g.diagnostic_enable_virtual_text = 1
  vim.g.diagnostic_insert_delay = 1
  vim.g.diagnostic_enable_underline = 0
  vim.g.space_before_virtual_text = 8

  -- Setup LSP for lua.
  -- nvim_lsp.sumneko_lua.setup({
  --   -- on_attach = require'diagnostic'.on_attach,
  --   on_attach = lsp_on_attach,
  --   settings = {
  --     Lua = {
  --       runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },
  --       completion = { keywordSnippet = 'Disable', },
  --       diagnostics = {
  --         enable = true,
  --         globals = {
  --           'vim', 'describe', 'it', 'before_each', 'after_each'
  --         },
  --       },
  --       workspace = {
  --         library = {
  --           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
  --         }
  --       }
  --     }
  --   }
  -- })

  -- -- Setup LSP for VimL.
  -- nvim_lsp.vimls.setup({
  --   on_attach = lsp_on_attach,
  -- })

  -- -- TODO: autocheck to make sure pyls is available in $PATH
  -- -- Setup LSP for Python.
  -- nvim_lsp.pyls.setup({
  --   on_attach = lsp_on_attach,
  -- })

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

-- Function that is called from init.vim.
function M.init()
  config_plugins()
  init_lsp()
  -- Clear existing search highlights.
  vim.cmd('noh')
end

-- Returns true if running inside a tmux session
function M.is_tmux()
  local tmux = vim.fn.environ()['TMUX']
  return (tmux ~= nil and tmux ~= '')
end

function M.open_terminal()
  -- vim.api.nvim_command('12split | terminal')
  vim.cmd('12split | terminal')
end

function M.termbelow()
  vim.cmd('12split | terminal')
end

function M.termright()
  vim.cmd('vsplit | terminal')
end

-- Deletes the file associated with current buffer.
function M.delete_current_file()
  local f = vim.fn.expand('%')
  vim.fn.delete(f)
  vim.api.nvim_command('bdelete!')
  print('Deleted file', f)
end

-- Shorthand for inspecting a lua object.
function M.show(x)
  print(vim.inspect(x))
end

-- Prints attached lsp clients for the current buffer.
function M.lsp_clients()
  M.show(vim.lsp.buf_get_clients())
end

-- " Checks if a colorscheme exists.
function M.has_colorscheme(name)
  local list = vim.fn.globpath(vim.o.rtp,
                               'colors/' .. name .. '.vim',
                               false, true)
  return (#list ~= 0)
end

-- Prints information about active windows.
function M.wininfo()
  local ws = vim.fn.getwininfo()
  M.show(ws)
end

function M.install_missing_plugins()
  M.show(vim.g.plugs)
end

return M

