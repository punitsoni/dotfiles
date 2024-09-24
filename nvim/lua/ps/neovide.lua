-- util = require 'ps.utils'

local function EnableFontScaling()
  vim.g.neovide_scale_factor = 1.0
  local kDeltaFactor = 0.05

  vim.keymap.set({ 'n', 'i', 'v', 't' }, "<D-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * (1 + kDeltaFactor)
  end)

  vim.keymap.set({ 'n', 'i', 'v', 't' }, "<D-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * (1 - kDeltaFactor)
  end)

  vim.keymap.set({ 'n', 'i', 'v', 't' }, "<D-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end)
end

local function EnableTabSwitching()
  -- Tab switching.
  -- TODO simplify this logic with loop.
  vim.keymap.set({ 'n', 'i', 't' }, '<D-1>', function()
    vim.cmd('1tabnext')
  end, { noremap = true, silent = true })
  vim.keymap.set({ 'n', 'i', 't' }, '<D-2>', function()
    vim.cmd('2tabnext')
  end, { noremap = true, silent = true })
  vim.keymap.set({ 'n', 'i', 't' }, '<D-3>', function()
    vim.cmd('3tabnext')
  end, { noremap = true, silent = true })
  vim.keymap.set({ 'n', 'i', 't' }, '<D-4>', function()
    vim.cmd('4tabnext')
  end, { noremap = true, silent = true })
end

local function DisableHorizontalScrolling()
  vim.keymap.set({ 'n', 'v', 'c', 't' }, '<ScrollWheelLeft>', '<nop>')
  vim.keymap.set({ 'n', 'v', 'c', 't' }, '<ScrollWheelRight>', '<nop>')
end


local function ConfigNeovide()
  -- vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0.1

  -- Allow clipboard copy paste in neovim (Cmd-c and Cmd-v)
  vim.g.neovide_input_use_logo = 1
  -- Cmd-c: copy
  vim.keymap.set('v', '<D-c>', '"+y')
  -- Cmd-v: paste
  vim.keymap.set({ 'n', 'v', 'c', 't' }, '<D-v>', function()
    vim.api.nvim_put({ vim.fn.getreg('+') }, 'c', false, true)
  end)

  EnableFontScaling()
  EnableTabSwitching()
  DisableHorizontalScrolling()

end

-- Setting for neovide gui.
if vim.g.neovide then
  ConfigNeovide()
end
