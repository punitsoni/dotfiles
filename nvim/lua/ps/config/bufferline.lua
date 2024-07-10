M = function()
  require 'bufferline'.setup {
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "Nvim Tree",
          separator = false,
          text_align = "left"
        }
      },
    },
  }
end

return M
