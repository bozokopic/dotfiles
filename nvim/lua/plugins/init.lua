return {
    {
        'tanvirtin/monokai.nvim',
        priority = 100,
        opts = {}
    },

    {'christoomey/vim-tmux-navigator'},

    {'mg979/vim-visual-multi'},

    {
        'akinsho/bufferline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {}
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'tanvirtin/monokai.nvim'
        },
        opts = {}
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {
            indent = {
                char = '┊'
            },
            scope = {
                enabled = false
            }
        }
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {}
    },

    -- {
    --     'mrjones2014/legendary.nvim',
    --     dependencies = { "stevearc/dressing.nvim" },
    --     opts = {},
    --     init = function()
    --         vim.keymap.set('', '<F9>', vim.cmd.Legendary)
    --     end
    -- },

    -- {
    --     'KabbAmine/zeavim.vim',
    --     init = function()
    --         vim.keymap.set('', '<F1>', vim.cmd.Zeavim)
    --     end
    -- }

    -- {'jiangmiao/auto-pairs'},

    -- {'rafamadriz/neon'},

    -- {
    --     'numToStr/Comment.nvim',
    --     opts = {}
    -- },

    -- {
    --     'wfxr/minimap.vim',
    --     dependencies = {
    --         'tanvirtin/monokai.nvim'
    --     },
    --     init = function()
    --         vim.g.minimap_highlight_range = 0
    --         vim.g.minimap_git_colors = 0
    --         vim.keymap.set('', '<F3>', vim.cmd.MinimapToggle)
    --     end
    -- },
}
