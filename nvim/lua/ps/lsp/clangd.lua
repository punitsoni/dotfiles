local attach = require 'ps.lsp.attach'
local handlers = require 'ps.lsp.handlers'
local capabilities = require 'ps.lsp.capabilities'

return {
    cmd = {
        'clangd', '--fallback-style=webkit', '--background-index', '--clang-tidy',
        '--header-insertion=iwyu', '-j=4'
    },
    capabilities = capabilities.get(),
    handlers = handlers.default(),
    on_attach = attach.with_default_config,
    root_dir = require 'lspconfig'.util.root_pattern('compile_commands.json'),
    single_file_support = true,
    settings = {
    }
}
