-- use modern vim
vim.o.compatible = false

-- dont use backup files
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- allow unsaved buffers
vim.o.hidden = true

-- enable mouse
vim.o.mouse = 'a'

-- display tabs and trailing spaces
vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·,nbsp:·'

-- search options
vim.o.incsearch = true
vim.o.hlsearch = true

-- backspace in insert mode
vim.o.backspace = "indent,eol,start"

-- no sound
vim.o.visualbell = true

-- set autoread
vim.o.autoread = true

-- set encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- show commands
vim.o.showcmd = true

-- file format
vim.o.fileformats = "unix,dos"

-- set leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- set system clipboard
vim.o.clipboard = 'unnamedplus'

-- disable conceal
vim.g.vim_json_conceal = 0
vim.g.markdown_syntax_conceal = 0
vim.o.conceallevel = 0
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "json",
    command = "set conceallevel=0"
})

-- show line numbers
vim.o.number = true

-- 80 character line length highlight
vim.o.colorcolumn = "80"

-- highlight current line
vim.o.cursorline = true

-- set tab width and use spaces for tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set colours
vim.opt.termguicolors = true

-- make files use regular tabs
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = "make",
    command = "set tabstop=4 shiftwidth=8 softtabstop=0 noexpandtab"
})

-- reload vimrc on change
vim.api.nvim_create_augroup("reload_vimrc", {})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    group = "reload_vimrc",
    pattern = vim.env.MYVIMRC,
    callback = function()
        vim.cmd "source $MYVIMRC"
        -- require('packer').sync()
        -- require('packer').compile()
    end
})

-- gui settings
vim.o.linespace = 4
-- vim.o.guifont = "monospace:h12"

-- neovide settings
if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.01
    vim.g.neovide_cursor_trail_length = 0.01
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_scale_factor = 1.0

    vim.keymap.set('n', '<C-=>', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
    end)

    vim.keymap.set('n', '<C-->', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
    end)
end
