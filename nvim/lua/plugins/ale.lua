do return {} end
return {
    {
        'dense-analysis/ale',
        config = function()
            vim.g.ale_linters_explicit = 1
            -- vim.g.ale_virtualtext_cursor = 'current'
            vim.g.ale_virtualtext_cursor = 'disabled'
            vim.g.ale_linters = {
                python = {'flake8'},
                lua = {'lua_language_server'},
                c = {'clangd'}
            }

        end
    }
}
