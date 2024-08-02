local M = {}


function M.attach(client, bufnr)
    local function create_cmd(name, func, desc)
        vim.api.nvim_buf_create_user_command(bufnr, name, func,
            { desc = desc })
    end

    create_cmd(
        'Format',
        function(_)
            vim.lsp.buf.format()
        end,
        'Format current buffer with LSP'
    )

    create_cmd(
        'LspSignatureHelp',
        function(_)
            vim.lsp.buf.signature_help()
        end,
        'Signature Help'
    )

    -- TODO: add more commands here as per
    -- https://github.com/fitrh/init.nvim/blob/7127fbef569ee498b1cbfae62ef372050b07afbc/lua/lsp/attach.lua
end

return M
