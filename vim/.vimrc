
" use modern vim
set nocompatible

" netrw
let g:netrw_banner       = 0
let g:netrw_keepdir      = 0
let g:netrw_liststyle    = 3
let g:netrw_sort_options = 'i'

" autostart netrw if vim starts without arguments
"autocmd VimEnter * if !argc() | Explore | endif

" dont use backup files
set nobackup
set nowritebackup
set noswapfile

" allow unsaved buffers
set hidden

" plugin manager
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'mg979/vim-visual-multi'
Plug 'christoomey/vim-tmux-navigator'
Plug 'w0rp/ale'
Plug 'sickill/vim-monokai'
Plug 'thaerkh/vim-indentguides'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mileszs/ack.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'bling/vim-airline'
Plug 'tpope/vim-fireplace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-misc'
Plug 'vim-scripts/paredit.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'https://git.sr.ht/~sircmpwn/hare.vim'

"Plug 'tpope/vim-fugitive.git'
"Plug 'severin-lemaignan/vim-minimap'
call plug#end()
filetype plugin indent on

" color theme
syntax enable
colorscheme monokai

" indentation guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" show line numbers
set number
"set relativenumber

" 80 character line length highlight
set colorcolumn=80

" highlight current line
set cursorline

" set tab width and use spaces for tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" make files use regular tabs
autocmd FileType make set tabstop=4 shiftwidth=8 softtabstop=0 noexpandtab

" enable spell check
"autocmd FileType rst set spell

" gui settings
set linespace=4
set guifont=Droid\ Sans\ Mono:h12
let g:neovide_cursor_animation_length = 0.01
let g:neovide_cursor_trail_length = 0.01
let g:neovide_cursor_vfx_mode = "sonicboom"
"if exists('g:GuiLoaded')
    "GuiTabline 0
"endif
"autocmd UIEnter * GuiTabline 0

" reload vimrc on change
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" airline configuration
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" display tabs and trailing spaces
set list
set listchars=tab:»·,trail:·,nbsp:·

" search options
set incsearch
set hlsearch

" backspace in insert mode
set backspace=indent,eol,start

" no sound
set visualbell

" set encoding
set encoding=utf-8
set fileencoding=utf-8
setglobal fileencoding=utf-8

" remap Esc
"imap <S-Space> <Esc>
"nmap <S-Space> <Esc>

" show commands
set showcmd

" file format
set fileformats=unix,dos

" gitgutter configuration
let g:gitgutter_realtime = 1

" function keys map
noremap <F5> :NERDTreeToggle<CR>
noremap <F6> :TagbarToggle<CR>
noremap <F7> :MBEToggle<CR>
noremap <F8> :tabp<CR>
noremap <F9> :tabn<CR>

" center cursor vertically
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" enable mouse
set mouse=a

" ale configuration
let g:ale_linters = {
\   'python': ['flake8'],
\   'c': ['clangd']
\ }
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_c_clangd_options = '--header-insertion=never'

" YouCompleteMe configuration
"let g:ycm_auto_trigger = 0
"let g:ycm_show_diagnostics_ui = 0

" completion options
set completeopt=menuone,preview,noinsert
set omnifunc=ale#completion#OmniFunc

" use ack.vim with ag
let g:ackprg = 'ag --vimgrep'

" disable conceal
autocmd FileType json set conceallevel=0

" ctrlP
"let g:ctrlp_prompt_mappings = {
"\   'ToggleType(1)':        ['<c-p>', '<c-f>', '<c-up>'],
"\ }
