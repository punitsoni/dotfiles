M = function()
  require 'catppuccin'.setup {
    -- Fix annoying high-contrast virtual text shown for warnings.
    highlight_overrides = {
      mocha = function(colors)
        return {
          DiagnosticVirtualTextWarn = { fg = colors.surface1, bg=colors.base },
        }
      end
    }
  }
end
return M
