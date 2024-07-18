vim.cmd 'edit lua/ps/actions.lua'
-- require'ps.experiments'
-- print(vim.lsp.get_clients())

print(vim.api.nvim_get_current_buf())

print(vim.api.nvim_buf_get_name(0))

print('\n')

vim.cmd 'quit'

