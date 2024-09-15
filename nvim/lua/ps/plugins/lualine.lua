function SetupLualine()
  require 'lualine'.setup {
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'vim.g.wsp_mode', 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          path = 1,
          file_status = true,
        }
      },
      lualine_x = {
        {
          require("noice").api.status.message.get_hl,
          cond = require("noice").api.status.message.has,
        },
        {
          require("noice").api.status.command.get,
          cond = require("noice").api.status.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#ff9e64" },
        },
        -- 'encoding',
        -- 'fileformat',
        -- 'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
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
