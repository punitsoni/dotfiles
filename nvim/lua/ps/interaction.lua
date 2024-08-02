local util = require 'ps.utils'

-- Event handler that is called when a new terminal is opened.
local function OnTermOpen(ev)
    -- Setup the terminal buffer.
    local nmap = util.nmap
    vim.cmd("setlocal nonumber norelativenumber")
    nmap('<LeftRelease>', '<LeftRelease>i', { buffer = ev.buf })
end



-- Do not continue comments when pressing enter.
vim.api.nvim_create_autocmd({ 'FileType' }, {
    command = 'set formatoptions-=ro'
})


-- Disable line numbers in terminal.
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = OnTermOpen,
})




-- When last buffer is deleted, instead of switching to a NONAME buffer, opens
-- the homepage.
vim.api.nvim_create_autocmd("BufDelete", {
    pattern = "*",
    callback = function(opts)
        local bufs = vim.tbl_filter(function(bufnr)
            if 1 ~= vim.fn.buflisted(bufnr) then
                return false
            end
            if not vim.api.nvim_buf_is_loaded(bufnr) then
                return false
            end
            if bufnr == opts.buf then
                return false
            end
            return true
        end, vim.api.nvim_list_bufs())

        if vim.tbl_count(bufs) == 1 and vim.api.nvim_buf_get_name(bufs[1]) == '' then
            require 'ps.ui'.homepage()
            vim.api.nvim_buf_delete(bufs[1], {})
        end
    end
})

function OpenScratchBuffer()
    vim.cmd('enew')
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'hide'
    vim.bo.swapfile = false
    vim.bo.filetype = 'lua' -- Set to your preferred filetype
end

--- Custom Commands ---

vim.api.nvim_create_user_command('Scratch', OpenScratchBuffer, {})

vim.api.nvim_create_user_command(
    "Myterm",
    function(opts)
        vim.cmd('ToggleTerm size=120 direction=vertical')
    end,
    { nargs = 0 }
)
