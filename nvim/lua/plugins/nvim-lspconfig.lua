return {
    {
        'neovim/nvim-lspconfig',
        init = function()
            -- vim.lsp.config('lua_ls', {
            --     cmd = {'lua-language-server'},
            --     filetypes = {'lua'},
            --     root_markers = {'.luarc.json', '.git'}
            -- })

            -- vim.lsp.config('clangd', {
            --     cmd = {'clangd', '--header-insertion=never'}
            -- })

            vim.lsp.enable('lua_ls')
        end
    }
}
