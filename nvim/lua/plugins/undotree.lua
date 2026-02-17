return {
    {
        'mbbill/undotree',
        init = function()
            vim.g.undotree_WindowLayout = 4
            vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, {desc = 'Toggle undo (undotree)'})
        end
    }
}
