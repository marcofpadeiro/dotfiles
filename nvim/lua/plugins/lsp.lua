return {
  -- Mason
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "gopls",
          "jsonls",
          "ltex_plus",
          "lua_ls",
          "marksman",
          "pyright",
          "rust_analyzer",
          "taplo",
          "ts_ls",
          "yamlls",
        },
        automatic_installation = true,
      })

      for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
        if server_name ~= "jdtls" then
          vim.lsp.enable(server_name)
        end
      end
    end,
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      'rafamadriz/friendly-snippets',
    },
    build = function()
      require('blink.cmp').build():pwait()
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default', ['<C-n>'] = { 'hide' }, ['<C-j>'] = { 'select_next' }, ['<C-k>'] = { 'select_prev' } },
      completion = { documentation = { auto_show = false } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy = { implementation = "rust" }
    },
  },

  -- java
  {
    'nvim-java/nvim-java',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require('java').setup({
        dap = { config_overrides = {} },
      })
      vim.lsp.enable('jdtls')
    end,
  },

  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local keymap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          keymap("K", vim.lsp.buf.hover, "Hover Documentation")
          keymap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          keymap("<leader>rn", vim.lsp.buf.rename, "Rename all references")
          keymap("<leader>ld", vim.diagnostic.open_float, "Open Diagnostic Float")
          keymap("gd", vim.lsp.buf.definition, "Goto Definition")
          keymap("<leader>fu", vim.lsp.buf.references, "Find Usages")
          keymap("form", vim.lsp.buf.format, "Format")
        end,
      })
    end,
  },

  -- Vimtex
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.opt.wrap = true
        end,
      })

      vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        options = {
          "-pdf",
          "-xelatex",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
  },
}
