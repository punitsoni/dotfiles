function SetupLualine()
  require 'lualine'.setup {
    options = {
      disabled_filetypes = { 'toggleterm' },
      global_status = false,

    },
    sections = {
      lualine_a = { 'mode', 'vim.g.wsp_mode' },
      lualine_b = { 'filename' },
      lualine_c = {
        -- 'buffers'
        -- {
        --   'filename',
        --   path = 1,
        --   file_status = true,
        -- }
      },
      lualine_x = {
        -- {
        --   require("noice").api.status.message.get_hl,
        --   cond = require("noice").api.status.message.has,
        -- },
        -- {
        --   require("noice").api.status.command.get,
        --   cond = require("noice").api.status.command.has,
        --   color = { fg = "#ff9e64" },
        -- },
        -- {
        --   require("noice").api.status.mode.get,
        --   cond = require("noice").api.status.mode.has,
        --   color = { fg = "#ff9e64" },
        -- },
        -- {
        --   require("noice").api.status.search.get,
        --   cond = require("noice").api.status.search.has,
        --   color = { fg = "#ff9e64" },
        -- },
        -- 'encoding',
        -- 'fileformat',
        -- 'filetype'
      },
      lualine_y = { 'diff', 'branch', 'diagnostics' },
      lualine_z = { 'progress', 'location' }
    },

    -- tabline = {
    --   lualine_a = { 'tabs' },
    --   lualine_b = { 'buffers' },
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- }
  }
end

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
      'folke/noice.nvim',
    },
    config = SetupLualine,
  },
}
