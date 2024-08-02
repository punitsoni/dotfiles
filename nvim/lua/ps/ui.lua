
util = require'ps.utils'

local M = {}

function M.homepage()
    if util.hascmd(':Alpha') then
        vim.cmd('Alpha')
    end
end

