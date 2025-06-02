local function config__null_ls()
  require 'mason-null-ls'.setup {
    ensure_installed = { 'ruff' },
    automatic_installation = true,
  }

  local null_ls = require 'null-ls'
  require 'null-ls'.setup {
    sources = {
      -- ---- Python ----
      -- Ruff is a fast python formatter.
      require 'none-ls.formatting.ruff'.with {
        extra_args = { '--extend-select', 'I' }
      },
      require 'none-ls.formatting.ruff_format',
      require 'none-ls.diagnostics.ruff',

      -- null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.completion.spell,
      -- null_ls.builtins.code_actions.gitsigns,

      -- ---- Shell ----
      null_ls.builtins.formatting.shfmt.with {
        args = { '-i', '4' }
      },
    }
  }
end

return {
  -- {
  --   -- none-ls is the supported version of null-ls as original one is now archived.
  --   'nvimtools/none-ls.nvim',
  --   config = config__null_ls,
  --   dependencies = {
  --     'nvimtools/none-ls-extras.nvim',
  --     'jayp0521/mason-null-ls.nvim',
  --   },
  -- },
}
