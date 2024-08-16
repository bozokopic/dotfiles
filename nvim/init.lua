-- use modern vim
vim.o.compatible = false

-- dont use backup files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- allow unsaved buffers
vim.o.hidden = true

-- enable mouse
vim.o.mouse = 'a'

-- display tabs and trailing spaces
vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·,nbsp:·'

-- search options
vim.o.incsearch = true
vim.o.hlsearch = true

-- backspace in insert mode
vim.o.backspace = "indent,eol,start"

-- no sound
vim.o.visualbell = true

-- set encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- show commands
vim.o.showcmd = true

-- file format
vim.o.fileformats = "unix,dos"

-- disable conceal
vim.g.vim_json_conceal = 0
vim.g.markdown_syntax_conceal = 0
-- autocmd FileType json set conceallevel=0
vim.o.conceallevel = 0
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "json",
    command = "set conceallevel=0"
})

-- show line numbers
vim.o.number = true

-- 80 character line length highlight
vim.o.colorcolumn = "80"

-- highlight current line
vim.o.cursorline = true

-- set tab width and use spaces for tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set colours
vim.opt.termguicolors = true

-- use system clipboard
vim.o.clipboard = ''
vim.keymap.set('n', '""y', '""y')
vim.keymap.set('n', '""yy', '""yy')
vim.keymap.set('n', '""p', '""p')
vim.keymap.set('n', '""P', '""P')
vim.keymap.set('n', 'y', function() return (vim.v.register == '"' and '"+' or '') .. 'y' end, { expr = true })
vim.keymap.set('n', 'yy', function() return (vim.v.register == '"' and '"+' or '') .. 'yy' end, { expr = true })
vim.keymap.set('n', 'p', function() return (vim.v.register == '"' and '"+' or '') .. 'p' end, { expr = true })
vim.keymap.set('n', 'P', function() return (vim.v.register == '"' and '"+' or '') .. 'P' end, { expr = true })

-- copy/paste
vim.keymap.set('n', '<C-x>', '"+dd')
vim.keymap.set('v', '<C-x>', '"+d')
vim.keymap.set('n', '<C-c>', '"+yy')
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set({'n', 'v'}, '<C-v>', '"+p')
vim.keymap.set('i', '<C-v>', '<C-r>+')

-- make files use regular tabs
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "make",
    command = "set tabstop=4 shiftwidth=8 softtabstop=0 noexpandtab"
})

-- trim whitespace
vim.keymap.set('n', '<Leader>wt', [[:%s/\s\+$//e<cr>]])

-- reload vimrc on change
vim.api.nvim_create_augroup("reload_vimrc", {})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    group = "reload_vimrc",
    pattern = vim.env.MYVIMRC,
    callback = function()
        vim.cmd "source $MYVIMRC"
        require('packer').sync()
        -- require('packer').compile()
    end
})

-- gui settings
vim.o.linespace = 4
-- vim.o.guifont = "monospace:h12"

-- neovide settings
if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.01
    vim.g.neovide_cursor_trail_length = 0.01
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_scale_factor = 1.0
    vim.keymap.set('n', '<C-=>', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
    end)
    vim.keymap.set('n', '<C-->', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
    end)
end

-- bootstrap packer
local bootstrap_packer = (function()
    local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
        vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path})
        vim.cmd('packadd packer.nvim')
        return true
    end
    return false
end)()

-- plugins
require('packer').startup {
    function(use)

        use 'wbthomason/packer.nvim'

        use {
            'tanvirtin/monokai.nvim',
            config = function()
                require('monokai').setup {}
            end
        }

        use 'christoomey/vim-tmux-navigator'

        -- use 'jiangmiao/auto-pairs'

        use {
            'majutsushi/tagbar',
            config = function()
                vim.keymap.set('', '<F6>', vim.cmd.TagbarToggle)
            end
        }

        use 'mg979/vim-visual-multi'

        use {
            'nvim-tree/nvim-web-devicons',
            config = function()
                require('nvim-web-devicons').setup {
                    color_icons = true
                }
            end
        }

        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-lua/plenary.nvim'
            },
            after = {
                'nvim-web-devicons'
            },
            config = function()

                require("nvim-tree").setup {
                    filters = {
                        dotfiles = true
                    },
                    update_focused_file = {
                        enable = true
                    },
                    renderer = {
                        icons = {
                            webdev_colors = true,
                            git_placement = 'signcolumn'
                        },
                        highlight_opened_files = 'icon'
                    },
                    view = {
                        signcolumn = 'yes'
                    },
                    actions = {
                        change_dir = {
                            global = true
                        }
                    },
                    live_filter = {
                        always_show_folders = false
                    }
                }
                vim.keymap.set('', '<F5>', vim.cmd.NvimTreeToggle)
            end
        }

        use {
            'akinsho/bufferline.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require("bufferline").setup()
            end
        }

        use {
            'nvim-lualine/lualine.nvim',
            after = {
                'monokai.nvim'
            },
            config = function()
                require('lualine').setup()
            end
        }

        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("ibl").setup {
                    indent = {
                        char = '┊'
                    },
                    scope = {
                        enabled = false
                    }
                }
            end
        }

        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'BurntSushi/ripgrep',
                'nvim-lua/plenary.nvim',
                'cljoly/telescope-repo.nvim'
            },
            config = function()
                local telescope = require('telescope')
                local builtin = require('telescope.builtin')
                telescope.setup {
                    extensions = {
                        repo = {
                            list = {
                                search_dirs = { '~/repos' }
                            }
                        }
                    }
                }
                telescope.load_extension("repo")
                vim.keymap.set('', '<F8>', builtin.builtin)
                vim.keymap.set('', '<leader>ff', builtin.find_files)
                vim.keymap.set('', '<leader>fg', builtin.live_grep)
                vim.keymap.set('', '<leader>fb', builtin.buffers)
                vim.keymap.set('', '<leader>fh', builtin.help_tags)
                vim.keymap.set('', '<leader>fr', telescope.extensions.repo.list)
            end
        }

        use {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 500
                require("which-key").setup {
                }
            end
        }

        use {
            'mrjones2014/legendary.nvim',
            requires = { "stevearc/dressing.nvim" },
            config = function()
                vim.keymap.set('', '<F9>', vim.cmd.Legendary)
                require('legendary').setup {
                }
            end
        }

        use {
            'mbbill/undotree',
            config = function()
                vim.g.undotree_WindowLayout = 4
                vim.keymap.set('', '<F7>', vim.cmd.UndotreeToggle)
            end
        }

        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
            end
        }

        -- use {
        --     'wfxr/minimap.vim',
        --     after = {
        --         'monokai.nvim'
        --     },
        --     config = function()
        --         vim.g.minimap_highlight_range = 1
        --         vim.g.minimap_git_colors = 1
        --         vim.keymap.set('', '<F4>', vim.cmd.MinimapToggle)
        --     end
        -- }

        use {
            'numToStr/Comment.nvim',
            config = function()
                require('Comment').setup()
            end
        }

        use 'rafamadriz/neon'

        -- use {
        --     'nvim-treesitter/nvim-treesitter',
        --     run = ':TSUpdate',
        --     config = function()
        --         require('nvim-treesitter.configs').setup {
        --             ensure_installed = {
        --                 'python', 'bash', 'lua', 'javascript', 'c', 'json', 'html'
        --             },
        --             highlight = {
        --                 enable = true
        --             }
        --         }
        --     end
        -- }

        use {
            'neovim/nvim-lspconfig',
            config = function()
                local lspconfig = require('lspconfig')
                -- lspconfig.jedi_language_server.setup {}
                -- lspconfig.bashls.setup {}
                -- lspconfig.clangd.setup {
                --     cmd = {'clangd', '--header-insertion=never'}
                -- }
                -- lspconfig.tsserver.setup {}
            end
        }

        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-vsnip',
                'hrsh7th/vim-vsnip'
            },
            config = function()
                local cmp = require('cmp')
                cmp.setup {
                    completion = {
                        autocomplete = false
                    },
                    snippet = {
                        expand = function (args)
                            vim.fn["vsnip#anonymous"](args.body)
                        end
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-Space>'] = function()
                            if cmp.visible() then
                                cmp.close()
                            else
                                cmp.complete()
                            end
                        end,
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true })
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'buffer' }
                    })
                }
            end
        }

        if bootstrap_packer then
            require('packer').sync()
        end

    end,
    config = {
        compile_on_sync = true,
        auto_reload_compiled = true
    }
}

