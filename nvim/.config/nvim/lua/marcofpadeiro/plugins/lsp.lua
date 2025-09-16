return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        local lsp = require('lsp-zero').preset({})

        -- set up Mason + mason-lspconfig (this replaces lsp.ensure_installed)
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                'rust_analyzer', -- rust
                'lua_ls',        -- lua
                'jsonls',        -- json
                'bashls',        -- bash
                'marksman',      -- markdown
                'yamlls',        -- yaml
                'taplo',         -- toml
            },
            handlers = {
                lsp.default_setup, -- let lsp-zero configure each server
            },
        })

        local keymap = vim.keymap.set

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
            keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
            keymap("n", "<leader>t", function() vim.diagnostic.open_float() end, opts)
            keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            keymap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            lsp.buffer_autoformat()
        end)

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
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-e>'] = cmp.mapping.close(),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil,
            }),
        })
    end
}
