
-- -- use system clipboard
-- vim.o.clipboard = ''
-- vim.keymap.set('n', '""y', '""y')
-- vim.keymap.set('n', '""yy', '""yy')
-- vim.keymap.set('n', '""p', '""p')
-- vim.keymap.set('n', '""P', '""P')
-- vim.keymap.set('n', 'y', function() return (vim.v.register == '"' and '"+' or '') .. 'y' end, { expr = true })
-- vim.keymap.set('n', 'yy', function() return (vim.v.register == '"' and '"+' or '') .. 'yy' end, { expr = true })
-- vim.keymap.set('n', 'p', function() return (vim.v.register == '"' and '"+' or '') .. 'p' end, { expr = true })
-- vim.keymap.set('n', 'P', function() return (vim.v.register == '"' and '"+' or '') .. 'P' end, { expr = true })
--
-- -- copy/paste
-- vim.keymap.set('n', '<C-x>', '"+dd')
-- vim.keymap.set('v', '<C-x>', '"+d')
-- vim.keymap.set('n', '<C-c>', '"+yy')
-- vim.keymap.set('v', '<C-c>', '"+y')
-- vim.keymap.set({'n', 'v'}, '<C-v>', '"+p')
-- vim.keymap.set('i', '<C-v>', '<C-r>+')

-- trim whitespace
vim.keymap.set('n', '<leader>wt', [[:%s/\s\+$//e<cr>]], {desc = 'Trim whitespace'})



-- toggle virtual text
vim.keymap.set('n', '<leader>tv', function()
    vim.diagnostic.config {virtual_text = not vim.diagnostic.config().virtual_text}
end, {desc = 'Toggle diagnostics virtual text'})


