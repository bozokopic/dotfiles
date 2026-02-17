return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'BurntSushi/ripgrep',
            'nvim-lua/plenary.nvim',
            'cljoly/telescope-repo.nvim'
        },
        opts = {
            extensions = {
                repo = {
                    list = {
                        search_dirs = { '~/repos' }
                    }
                }
            }
        },
        init = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')
            telescope.load_extension('repo')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Find files'})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = 'Live grep'})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'List buffers'})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'List help tags'})
            vim.keymap.set('n', '<leader>fr', telescope.extensions.repo.list, {desc = 'List repos'})
            vim.keymap.set('n', '<leader>fc', builtin.commands, {desc = 'List commands'})
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc = 'List keymaps'})
        end
    }
}
