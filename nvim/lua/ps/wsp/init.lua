local Context = require 'ps.wsp.context'
local ts_builtin = require('telescope.builtin')


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
  local command = { 'rg', '--files', '--hidden', '--color=never' }

  assert(config)

  -- TODO: inclusion of general globs interferes with type selection later.
  -- for _, d in ipairs(config.dirs) do
  --   table.insert(command, '--glob')
  --   table.insert(command, d .. '/**/*')
  --   print(d)
  -- end

  for _, d in ipairs(config.dirs_exclude) do
    table.insert(command, '--glob')
    table.insert(command, '!' .. d .. '/**/*')
    print(d)
  end

  vim.list_extend(command, {
    '--glob=!**/.git/*',
    '--type=c',
    '--type=cpp',
    '--type=python',
    '--type=make',
    '--type=cmake',
    '--type=sh',
    ctx.rootdir
  })

  ts_builtin.find_files({
    find_command = command,
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

  -- Telescope live_grep calls the ripgrep (rg) tool. We can pass additional
  -- arguments to the rg invocation.
  local rg_args = {}

  -- for _, d in ipairs(config.dirs) do
  --   table.insert(rg_args, '--glob='..d .. '/**/*')
  -- end
  --
  for _, d in ipairs(config.dirs_exclude) do
    table.insert(rg_args, '--glob=!' .. d .. '/**/*')
  end

  vim.list_extend(rg_args, {
    '--glob=!**/.git/*',
    '--type=c',
    '--type=cpp',
    '--type=python',
    '--type=make',
    '--type=cmake',
  })

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
