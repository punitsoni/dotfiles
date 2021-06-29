local runcmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()

local datapath = fn.stdpath('data')
local configpath = fn.stdpath('config')

local function install_lua_ls()
  if not fn.isdirectory(datapath .. '/lua-language-server') then
    runcmd ('!sh ' .. configpath .. '/install_lua_ls.sh ' .. datapath)
  end
end

return {
  install_ls = function (lang)
    if lang == 'lua' then
      install_lua_ls()
    end
  end
}
