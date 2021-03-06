local runcmd = vim.cmd  -- to execute Vim commands e.g. runcmd('pwd')
local vimfn = vim.fn    -- to call Vim functions e.g. fn.bufnr()

local system_name
if vimfn.has("mac") == 1 then
  system_name = "macOS"
elseif vimfn.has("unix") == 1 then
  system_name = "Linux"
elseif vimfn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko lua")
end

-- set the path to the sumneko installation;
local sumneko_root_path = vimfn.stdpath('data') .. '/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
