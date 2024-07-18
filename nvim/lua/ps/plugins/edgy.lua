return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      exit_when_last = true,
      close_when_all_hidden = false,
      options = {
        left = { size = 40 },
        -- bottom = { size = 30 },
      },
      animate = {
        enabled = false,
      },
      -- Exit vim when only edgy windows are left.
      -- TODO: This has some edge-cases that need to be sorted out.
      -- exit_when_last = true,
      left = {
        -- Neo-tree filesystem always takes half the screen height
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = "Neotree",
          size = { height = 0.6 },
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          collapsed = false, -- show window as closed/collapsed on start
          open = "Neotree position=top buffers",
        },
        -- {
        --   title = function()
        --     local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
        --     return vim.fn.fnamemodify(buf_name, ":t")
        --   end,
        --   ft = "Outline",
        --   pinned = true,
        --   open = "SymbolsOutlineOpen",

        -- },
        -- any other neo-tree windows
        "neo-tree",
      },
      bottom = {
        "Trouble",
        { ft = "qf", title = "QuickFix" },
        -- {
        --   ft = "neorepl",
        --   title = "REPL",
        --  size = { height = 40 }
        -- },
        -- {
        --   ft = "help",
        --   -- size = { height = 30 },
        --   -- Only show help buffers.
        --   filter = function(buf)
        --     return vim.bo[buf].buftype == "help"
        --   end,
        -- },
      },
    }
  }
}

