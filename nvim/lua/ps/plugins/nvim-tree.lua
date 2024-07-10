
local function SetupNvimTree()
  require'nvim-tree'.setup()
  -- Do not keep nvim-tree as last buffer when closing vim.
  vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
  })
end


return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = SetupNvimTree,
  },
}

