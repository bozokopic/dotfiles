return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip'
        },
        main = 'cmp',
        opts = function()
            local cmp = require('cmp')
            return {
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
}
