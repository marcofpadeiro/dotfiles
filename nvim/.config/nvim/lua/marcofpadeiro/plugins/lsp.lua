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

        -- Rust
        { 'simrat39/rust-tools.nvim' },
    },
    config = function()
        local lsp = require('lsp-zero').preset('recommended')
        lsp.preset("recommended")

        local cmp = require('cmp')

        cmp.setup({
            mapping = {
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
            }
        })

        lsp.set_sign_icons({
            error = '✘',
            warn = '',
            hint = '⚑',
            info = '󰙎'
        })

        lsp.ensure_installed({
            'lua_ls',
            'tsserver',
            'clangd',
            'rust_analyzer',
            'bashls',
            'cssls',
            'dockerls',
            'html',
            'jsonls',
            'marksman',
            'gopls',
            'pylsp',
            'sqlls',
            'tsserver',
        })

        local lspconfig = require('lspconfig')

        -- lua
        lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

        -- c
        lspconfig.clangd.setup {}

        -- rust
        lsp.configure('rust_analyzer', {
            cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
        })


        lsp.setup()
    end
}
