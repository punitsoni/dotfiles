local function configure_null_ls()
  local null_ls = require("null-ls")
  null_ls.setup({
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.black,        -- for Python formatting
    null_ls.builtins.code_actions.gitsigns,   -- for Git actions
    null_ls.builtins.formatting.shfmt,
  })
end

return {
  {
    -- none-ls is the supported version of null-ls as original one is now archived.
    'nvimtools/none-ls.nvim',
    config = configure_null_ls
  },
}
