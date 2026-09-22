local Context = require 'ps.wsp.context'
local Path = require 'plenary.path'
local snacks = require('snacks')


-- wsp module.
local wsp = {}

local function get_context()
  return Context.Instance()
end

local kDefaultConfigTemplate = [[
return {
  config = {
    name = "%s",
    -- rg type names: controls which files appear in find_files and live_grep.
    -- Bypasses .gitignore so these types always show up regardless of ignore rules.
    -- file_types = { "swift", "c", "cpp", "make", "cmake" },
  }
}
]]

local kDefaultIgnoreTemplate = [[
.git
.venv

# Standard gitignore syntax. To exclude a dir except one of its subdirs, use
# the dir/* + !dir/keep override idiom, eg:
#   optional_submodules/*
#   !optional_submodules/pepcapture
]]

-- Initializes a wsp workspace rooted at the current working directory by
-- creating .wsp/lua/wsp_local.lua and .wsp/ignore with default contents.
function wsp.wsp_init()
  local rootdir = Path.new(vim.uv.cwd())
  local configdir = rootdir:joinpath('.wsp')
  local luadir = configdir:joinpath('lua')
  local configfile = luadir:joinpath('wsp_local.lua')
  local ignorefile = configdir:joinpath('ignore')

  if configfile:exists() then
    print('wsp already initialized at ' .. configfile.filename)
    return
  end

  luadir:mkdir({ parents = true })
  local name = vim.fn.fnamemodify(rootdir.filename, ':t')
  configfile:write(string.format(kDefaultConfigTemplate, name), 'w')
  if not ignorefile:exists() then
    ignorefile:write(kDefaultIgnoreTemplate, 'w')
  end

  print('wsp initialized at ' .. configdir.filename)
end

function wsp.is_active()
  return get_context().active
end

-- If .wsp/ignore exists next to wsp_local.lua, point rg at it with
-- --ignore-file so its gitignore-syntax rules (including negation) apply.
-- rg's gitignore-file parser, unlike bare `-g` flags, honors the standard
-- `dir/*` + `!dir/keep` override idiom for "exclude a dir except a subdir".
local function ignore_file_args(ctx)
  local ignorefile = ctx.configdir .. '/ignore'
  if vim.uv.fs_stat(ignorefile) then
    return { '--ignore-file', ignorefile }
  end
  return {}
end

function wsp.find_files()
  local ctx = get_context()

  if not ctx.active then
    print('wsp not active')
    return
  end

  local config = ctx.config
  assert(config)

  local args = { '--no-ignore-vcs' }
  vim.list_extend(args, ignore_file_args(ctx))
  for _, t in ipairs(config.file_types or {}) do
    table.insert(args, '--type=' .. t)
  end

  snacks.picker.files({
    cmd = 'rg',
    hidden = true,
    layout = vim.o.columns < 200 and { hidden = { 'preview' } } or nil,
    cwd = ctx.rootdir,
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

  local args = { '--no-ignore-vcs' }
  vim.list_extend(args, ignore_file_args(ctx))
  for _, t in ipairs(config.file_types or {}) do
    table.insert(args, '--type=' .. t)
  end

  snacks.picker.grep({
    hidden = true,
    layout = vim.o.columns < 200 and { hidden = { 'preview' } } or nil,
    cwd = ctx.rootdir,
    args = args,
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

vim.api.nvim_create_user_command('WspInit', wsp.wsp_init, {})
vim.api.nvim_create_user_command('WspConfig', wsp.edit_config, {})

return wsp
