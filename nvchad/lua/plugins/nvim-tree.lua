local nvim_tree_is_max = false

local function NvimTreeMinMax()
  if nvim_tree_is_max then
    vim.cmd ":NvimTreeResize 30"
  else
    vim.cmd ":NvimTreeResize 60"
  end
  nvim_tree_is_max = not nvim_tree_is_max
end

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })

local function OnNvimTreeAttach(bufnr)
  -- Close window on escape.
  map("n", "<Esc>", function()
    vim.cmd "close"
  end)
end

local function SetupNvimTree()
  require("nvim-tree").setup {
    -- on_attach = OnNvimTreeAttach,
    hijack_cursor = true,
    view = {
      float = {
        enable = true,

        open_win_config = function()
          local HEIGHT_RATIO = 0.8 -- You can change this
          local WIDTH_RATIO = 0.5 -- You can change this too
          local screen_w = vim.opt.columns:get()
          local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          local window_w = screen_w * WIDTH_RATIO
          local window_h = screen_h * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.floor(window_h)
          local center_x = (screen_w - window_w) / 2
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = center_x,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
      -- width = 40,
    },
  }
  -- Do not keep nvim-tree as last buffer when closing vim.
  vim.api.nvim_create_autocmd({ "QuitPre" }, {
    callback = function()
      vim.cmd "NvimTreeClose"
    end,
  })

  -- local nmap = require 'ps.utils'.nmap
  map("n", "<leader>tm", NvimTreeMinMax, { desc = "Nvim-tree minimize/maximize" })
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    -- enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      -- Disable loading netrw as per nvim-tree doc.
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = SetupNvimTree,
  },
}
