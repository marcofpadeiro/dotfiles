return {
    {
        'Mofiqul/dracula.nvim',
        config = function()
            require("dracula").setup({
                vim.cmd [[colorscheme dracula]]
            })
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({})
        end
    },

    {
        'NvChad/nvim-colorizer.lua',
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            user_default_options = {
                names = false,
                mode = "background",
                tailwind = false,
                virtualtext = "■",
                always_update = true
            },
        },
    },

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {},
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        opts = function()
            local dashboard = require('alpha.themes.dashboard')

            dashboard.section.buttons.val = {
                dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
                dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
                dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
                dashboard.button('q', ' ' .. ' Quit', ':qa<CR>'),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = 'AlphaButtons'
                button.opts.hl_shortcut = 'AlphaShortcut'
            end
            dashboard.section.footer.opts.hl = 'Type'
            dashboard.section.header.opts.hl = 'AlphaHeader'
            dashboard.section.buttons.opts.hl = 'AlphaButtons'
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            if vim.o.filetype == 'lazy' then
                vim.cmd.close()
                vim.api.nvim_create_autocmd('User', {
                    pattern = 'AlphaReady',
                    callback = function()
                        require('lazy').show()
                    end,
                })
            end

            require('alpha').setup(dashboard.opts)
            vim.api.nvim_create_autocmd('User', {
                pattern = 'LazyVimStarted',
                callback = function()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = '⚡ Neovim loaded ' ..
                        stats.count .. ' plugins in ' .. ms .. 'ms'
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    {
        'vigoux/notifier.nvim',
        config = function()
            require('notifier').setup()
        end,
    },

    {
        'vigoux/notifier.nvim',
        config = function()
            require('notifier').setup()
        end,
    },
}
