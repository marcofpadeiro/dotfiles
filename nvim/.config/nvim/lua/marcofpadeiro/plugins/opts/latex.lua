return  {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = 'zathura'

            vim.g.vimtex_compiler_method = 'latexmk'


            vim.cmd [[filetype plugin indent on]]
            vim.cmd [[syntax enable]]
        end
}
