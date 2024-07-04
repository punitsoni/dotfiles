-- Configure plugin lualine.
M = function()
  require'lualine'.setup {
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'vim.g.wsp_mode', 'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
  }
end

return M

