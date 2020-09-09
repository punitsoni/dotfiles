-- This is global nvim configuration that is loaded at startup via init.vim.
-- All definitions here are loaded in global namespace.

-- Setup clangd for C/C++ LSP. For this, it is required to have `clangd`
-- installed and in $PATH.
-- if vim.fn.executable('clangd') then
--   require'nvim_lsp'.clangd.setup{}
-- end
-- VimScript
-- require'nvim_lsp'.vimls.setup{}
-- Python
-- require'nvim_lsp'.pyls.setup{}
-- Bash
-- require'nvim_lsp'.bashls.setup{}

function open_terminal()
  vim.api.nvim_command('12split | terminal')
end

-- Delete the file associated with current buffer.
function delete_me()
  f = vim.fn.expand('%')
  vim.fn.delete(f)
  vim.api.nvim_command('bdelete!')
  print('Deleted file', f)
end
