
local out = vim.api.nvim_exec('scriptnames', true)
print(out)

vim.pretty_print(vim.opt.runtimepath:get())
