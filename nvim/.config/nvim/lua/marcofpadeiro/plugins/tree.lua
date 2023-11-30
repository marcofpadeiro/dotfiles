return {
  -- File Explorer
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute({ toggle = true, focus = true })
        end,
        desc = 'Explorer NeoTree (root dir)',
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    -- Config for the plugin Setup
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        position = 'left',
        width = 30,
        mapping_options = {
          nowait = true,
        },
        mappings = {
          ['<2-LeftMouse>'] = 'open',
          ['<Tab>'] = 'open',
          ['a'] = {
            'add',
            config = {
              show_path = 'none'
            }
          },
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['H'] = 'toggle_hidden',
        }
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '󰜌',
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = '*',
          highlight = 'NeoTreeFileIcon'
        },
        modified = {
          symbol = '[+]',
          highlight = 'NeoTreeModified',
        },
        git_status = {
          symbols = {
            -- Change type
            added     = '', -- or '✚', but this is redundant info if you use git_status_colors on the name
            modified  = '', -- or '', but this is redundant info if you use git_status_colors on the name
            deleted   = '✖', -- this can only be used in the git_status source
            renamed   = '󰁕', -- this can only be used in the git_status source
            -- Status type
            untracked = '',
            ignored   = '',
            unstaged  = 'u',
            staged    = '',
            conflict  = '',
          }
        },
      },
    },
    -- End Config
    config = function(_, opts)
      require('neo-tree').setup(opts)
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },
}
