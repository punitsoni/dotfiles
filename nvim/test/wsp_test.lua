-- Run this test using following command.
--
--    nvim -l test/wsp_test.lua
--

print('** wsp test **')

-- Enable plenary plugin in the headless script mode.
local plenary_path = vim.fn.stdpath('data') .. '/lazy/plenary.nvim'
vim.opt.rtp:prepend(plenary_path)

local Path = require'plenary.path'
local Context = require'ps.wsp.context'

local wsp = {}

-- Returns true if currently we are in active wsp workspace.
wsp.is_active = function ()
  error('Not implemented')
end

wsp.get_wsp_files = function()
  error('Not implemented')
end

wsp.init = function ()
  error('Not implemented')
end

local function assert_eq(lhs, rhs)
  if lhs ~= rhs then
    error('Assertion failed')
  end
end

local function test1()
  print(vim.uv.cwd())
  local state = wsp_init()
  assert_eq(state.active, true)
  vim.print(state)
  print('')
  print('TEST PASS')
end

local function test2()
  ctx = Context.Instance()
  vim.print(ctx)
  print(ctx:is_active())
  print(ctx:config_file())
end

test2()

--[[

Use cases

- get list of all workspace files
- Add wsp dir to runtimepath so the local lua modules can be used.
- Change workspace on cwd change.
-

Design

-


]]--
