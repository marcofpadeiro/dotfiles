return {
    'mbbill/undotree',

    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup()
        end
    },
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = { { 'kkharji/sqlite.lua', module = 'sqlite' }, { 'nvim-telescope/telescope.nvim' } },
        config = function()
            require('neoclip').setup()
        end,
    },
    {
        'akinsho/git-conflict.nvim',
        config = function()
            require('git-conflict').setup()
        end
    },

    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function()
            require('Comment').setup()
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },

    'github/copilot.vim',
}
