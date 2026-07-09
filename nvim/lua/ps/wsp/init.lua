local Context = require 'ps.wsp.context'
local ts_builtin = require('telescope.builtin')
local snacks = require('snacks')


-- wsp module.
local wsp = {}

local function get_context()
  return Context.Instance()
end

function wsp.init()
end

function wsp.is_active()
  return get_context().active
end

function wsp.find_files()
  local ctx = get_context()

  if not ctx.active then
    print('wsp not active')
    return
  end

  local config = ctx.config
  assert(config)

  local args = { '--no-ignore-vcs', '--follow' }
  for _, t in ipairs(config.file_types or {}) do
    table.insert(args, '--type=' .. t)
  end

  snacks.picker.files({
    cmd = 'rg',
    hidden = true,
    preview = false,
    cwd = ctx.rootdir,
    exclude = vim.tbl_map(function(d) return d .. '/**/*' end, config.dirs_exclude or {}),
    args = args,
  })
end

function wsp.live_grep()
  local ctx = get_context()

  if not ctx.active then
    print('wsp not active')
    return
  end

  local config = ctx.config
  assert(config)

  local rg_args = { '--no-ignore-vcs' }

  for _, d in ipairs(config.dirs_exclude or {}) do
    table.insert(rg_args, '--glob=!' .. d .. '/**/*')
  end

  table.insert(rg_args, '--glob=!**/.git/*')

  for _, t in ipairs(config.file_types or {}) do
    table.insert(rg_args, '--type=' .. t)
  end

  ts_builtin.live_grep({
    cwd = ctx.rootdir,
    additional_args = rg_args,
  })
end

function wsp.edit_config()
  local ctx = get_context()
  if not ctx.active then
    print('wsp not active')
    return
  end
  vim.cmd('e ' .. ctx.configdir .. '/lua/wsp_local.lua')
end

return wsp
