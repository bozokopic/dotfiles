return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        opts = {
            ensure_installed = {
                'python', 'bash', 'lua', 'javascript', 'c', 'json', 'html'
            },
            highlight = {
                enable = true
            }
        }
    }
}
