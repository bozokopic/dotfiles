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

-- set encoding
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- show commands
vim.o.showcmd = true

-- file format
vim.o.fileformats = "unix,dos"

-- disable conceal
vim.g.vim_json_conceal = 0
vim.g.markdown_syntax_conceal = 0
-- autocmd FileType json set conceallevel=0

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
    command = "source $MYVIMRC"
})

-- gui settings
vim.o.linespace = 4
vim.o.guifont = "Droid\\ Sans\\ Mono:h12"

-- neovide settings
if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.01
    vim.g.neovide_cursor_trail_length = 0.01
    vim.g.neovide_cursor_vfx_mode = "sonicboom"
    vim.g.neovide_scale_factor = 1.0
    vim.keymap.set('n', '<C-=>', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
    end)
    vim.keymap.set('n', '<C-->', function()
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
    end)
end

-- plugin manager
vim.fn['plug#begin']()
vim.cmd.Plug('"airblade/vim-gitgutter"')
vim.cmd.Plug('"christoomey/vim-tmux-navigator"')
vim.cmd.Plug('"jiangmiao/auto-pairs"')
vim.cmd.Plug('"majutsushi/tagbar"')
vim.cmd.Plug('"mg979/vim-visual-multi"')
vim.cmd.Plug('"nvim-tree/nvim-tree.lua"')
vim.cmd.Plug('"nvim-tree/nvim-web-devicons"')
vim.cmd.Plug('"romgrk/barbar.nvim"')
vim.cmd.Plug('"tanvirtin/monokai.nvim"')
vim.cmd.Plug('"thaerkh/vim-indentguides"')
vim.fn['plug#end']()

-- monokai
require('monokai').setup({})

-- indentguides
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_start_level = 2
vim.g.indent_guides_guide_size = 1

-- nvim-tree
require("nvim-tree").setup()
vim.opt.termguicolors = true

-- barbar
require('bufferline').setup({
    auto_hide = false
})
local _ = (function(y)
    local nvim_tree_events = require('nvim-tree.events')
    local bufferline_api = require('bufferline.api')

    local function get_tree_size()
        return require'nvim-tree.view'.View.width
    end

    nvim_tree_events.subscribe('TreeOpen', function()
        bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe('Resize', function()
        bufferline_api.set_offset(get_tree_size())
    end)

    nvim_tree_events.subscribe('TreeClose', function()
        bufferline_api.set_offset(0)
    end)
end)()

-- gitgutter 
vim.g.gitgutter_realtime = 1

-- function keys map
vim.keymap.set('', '<F5>', vim.cmd.NvimTreeToggle)
vim.keymap.set('', '<F6>', vim.cmd.TagbarToggle)

