return {
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            filters = {
                dotfiles = false
            },
            update_focused_file = {
                enable = true
            },
            renderer = {
                icons = {
                    webdev_colors = true,
                    git_placement = 'signcolumn'
                },
                highlight_git = 'name'
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
            },
            git = {
                ignore = false
            }
        },
        init = function()
            -- vim.api.nvim_create_autocmd({"VimEnter"}, {
            --     callback = function()
            --         require("nvim-tree.api").tree.open()
            --     end
            -- })

            vim.keymap.set('n', '<leader>tt', vim.cmd.NvimTreeToggle, {desc = "Toggle tree (nvim-tree)"})
        end
    }
}
