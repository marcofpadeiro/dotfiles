return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        require('java').setup()
        local lsp = require('lsp-zero').preset({})

        lsp.on_attach(function(client, bufnr)
            lsp.default_keymaps({ buffer = bufnr })
            lsp.buffer_autoformat()
        end)

        lsp.ensure_installed({
            'tsserver',      -- typescript/javascrip
            'rust_analyzer', -- rust
            'lua_ls',        -- lua
            'clangd',        -- C/C++
            'jsonls',        -- json
            'bashls',        -- bash
            'cssls',         -- css
            'dockerls',      -- dockerfile
            'gopls',         -- go
            'html',          -- html
            'marksman',      -- markdown
            'yamlls',        -- yaml
            'taplo',         -- toml
        })

        lsp.setup()

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            },
            formatting = lsp.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-a>'] = cmp.mapping.confirm({ select = true }),
                ['<Cr>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping.close(),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil,
            }),
        })

        require('lspconfig').jdtls.setup({})
    end
}
