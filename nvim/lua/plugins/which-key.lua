return {
    {
        "folke/which-key.nvim",
        opts = {
            spec = {
                {'<leader>t', group = 'toggle'}
            }
        },
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500

            vim.keymap.set('n', '<leader>?', function()
                require("which-key").show({global = true})
            end, {desc = 'Global keymaps (which-key)'})
        end
    }
}
