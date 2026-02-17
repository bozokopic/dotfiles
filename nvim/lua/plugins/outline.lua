return {
    -- {
    --     'majutsushi/tagbar',
    --     init = function()
    --         vim.keymap.set('n', '<leader>to', vim.cmd.TagbarToggle, {desc = 'Toggle outline (tagbar)'})
    --     end
    -- }
    {
        "hedyhli/outline.nvim",
        dependencies = {
            'epheien/outline-treesitter-provider.nvim',
            'epheien/outline-ctags-provider.nvim'
        },
        opts = {
            providers = {
                priority = {'lsp', 'ctags', 'treesitter'}
            }
        },
        init = function()
            vim.keymap.set('n', '<leader>to', vim.cmd.Outline, {desc = 'Toggle outline (outline)'})
        end
    }
}
