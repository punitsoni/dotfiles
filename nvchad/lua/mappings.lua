require "nvchad.mappings"
local actions = require 'ps.actions'

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map({ "n", "i" }, "<C-b>", actions.toggle_tree, { desc = "Toggle File Explorer Tree" })
