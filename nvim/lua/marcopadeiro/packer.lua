-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Necessary plugins
    use 'wbthomason/packer.nvim' -- packer itself
    use 'nvim-lua/plenary.nvim'  -- a lot of other plugins use this one


    use 'xiyaowong/transparent.nvim'

    -- Syntax Highlight and theme
    use 'navarasu/onedark.nvim'
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"

    -- Nvim Tree
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    -- Quality of life features AKA I need to learn all of this
    use 'lukas-reineke/indent-blankline.nvim'
    use 'tpope/vim-commentary'      -- gc
    use 'tpope/vim-surround'        -- cs"' cs'<q> ds" ds'
    use 'akinsho/git-conflict.nvim' -- co = accept local changes || ct = accept remote changes || ca = accept both changes


    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- using packer.nvim
    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }
    -- Utils
    use 'windwp/nvim-autopairs'         -- VSCode like autopairs
    use 'github/copilot.vim'            -- Github copilot
    use 'ThePrimeagen/harpoon'          -- Blazing fast through files
    use 'nvim-lualine/lualine.nvim'     -- Lua line rice
    use 'nvim-telescope/telescope.nvim' -- Blazingly fast fuzzy finder
end)
