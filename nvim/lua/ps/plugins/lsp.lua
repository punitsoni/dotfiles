-- Configure LSP related plugin

local function ShowReferences()
  -- TODO Use trouble.nvim as references view.
  -- vim.cmd([[Trouble lsp_references focus=true follow=false ]])
  -- require'trouble'.open({
  --   mode = 'lsp_references',
  --   focus = true,
  --   follow = false,
  -- })
  vim.lsp.buf.references()
end

local function SetupKeymaps(bufnr)
  -- Buffer local keymap for normal mode.
  local function nmap(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')

  nmap("gd", function()
    vim.lsp.buf.definition()
    vim.cmd 'normal zz'
  end,
    'Goto Definition'
  )

  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gr', ShowReferences, 'References')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end


--  This function gets run when an LSP connects to a particular buffer.
local function OnLspAttach(_, bufnr)
  -- Setup buffer-local keybinding.
  SetupKeymaps(bufnr)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local function SetupLspConfig()
  -- nvim-cmp supports additional completion capabilities.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities())

  require'mason'.setup()
  require'mason-lspconfig'.setup {
    ensure_installed = {'lua_ls'},
  }

  require("lspconfig").lua_ls.setup {
    -- cmd = {...},
    -- filetypes = { ...},
    capabilities = capabilities,
    on_attach = OnLspAttach,
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    }
  }

  ---- Configure clangd.
  require("lspconfig").clangd.setup {
    -- cmd = {...},
    -- filetypes = { ...},
    capabilities = capabilities,
    on_attach = OnLspAttach,
    root_dir = require'lspconfig'.util.root_pattern('compile_commands.json'),
    single_file_support = true,
    settings = {
    }
  }

  require("lspconfig").pyright.setup {
  }
end


local function SetupNvimCmp()
  local cmp = require'cmp'
  cmp.setup {
    mapping = cmp.mapping.preset.insert {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete({}),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- elseif luasnip.expand_or_jumpable() then
          --   luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
          -- elseif luasnip.jumpable(-1) then
          --   luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
    },
  }
end

-- Return the Lazy plugin spec. --
return {
  {
    'neovim/nvim-lspconfig',
    config = SetupLspConfig,
    dependencies = {
      -- Mason insures that language servers are installed.
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
      -- Cmp provides completion engine that is used by lspconfig.
      {
        'hrsh7th/nvim-cmp',
        config = SetupNvimCmp,
        dependencies = {
          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lua',
          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',
        },
      },
    },
  },
  -- Useful status updates for LSP
  { 'j-hui/fidget.nvim' },
  -- Good LSP settings for neovim lua development.
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {}
  },
}

