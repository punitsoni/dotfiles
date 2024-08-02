
local function SetupHarpoon()
  local harpoon = require'harpoon'
  local util = require'ps.utils'
  harpoon:setup()

  util.nmap("ga", function() harpoon:list():add() end)
  util.nmap("gm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  util.nmap('g1', function() harpoon:list():select(1) end)
  util.nmap('g2', function() harpoon:list():select(2) end)
  util.nmap('g3', function() harpoon:list():select(3) end)
  util.nmap('g4', function() harpoon:list():select(4) end)

end

return {
  -- Harpoon: quickly switch between imp files in project.
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = SetupHarpoon,
  },
}

