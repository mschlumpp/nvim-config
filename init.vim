if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '/usr/share/vim/vimfiles/'

" Appearance
Plug 'itchyny/lightline.vim'

Plug 'nanotech/jellybeans.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'chriskempson/base16-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'ray-x/paleaurora'

" Utilities
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/SudoEdit.vim'

" Tree Sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" LSP and related packages
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'

Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'jackguo380/vim-lsp-cxx-highlight'

" Language supportk
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'LnL7/vim-nix'
Plug 'bazelbuild/vim-ft-bzl'
Plug 'lervag/vimtex'
Plug 'ziglang/zig.vim'
Plug 'jceb/vim-orgmode'
Plug 'bakpakin/fennel.vim'

call plug#end()

" Some basic options
set incsearch
set autoread
set laststatus=2
set ruler
set number
set hidden
set updatetime=300
set cmdheight=2
set signcolumn=number
set termguicolors
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set mouse=a
set undofile

set wildmode=longest,list,full
set wildmenu

au FocusGained,BufEnter * :checktime

let mapleader = " "

" Tab settings
set smarttab
set expandtab
set shiftwidth=4

colorscheme jellybeans

set guifont=Iosevka:h14

" Some keybindings from emacs config
noremap <leader>wk <c-w>k
noremap <leader>wj <c-w>j
noremap <leader>wh <c-w>h
noremap <leader>wl <c-w>l

noremap <c-s-up> <c-w>k
noremap <c-s-down> <c-w>j
noremap <c-s-left> <c-w>h
noremap <c-s-right> <c-w>l

noremap <leader>wm <c-w>o
noremap <leader>wc <c-w>c
noremap <leader>wv <c-w>v
noremap <leader>ws <c-w>s

noremap <silent><leader>bk :bd<cr>

" quick fix
nnoremap <silent>]q :cn<cr>
nnoremap <silent>[q :cp<cr>

" deoplete
let g:deoplete#enable_at_startup = 1

" telescope
nnoremap <silent><leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <silent><leader>h  <cmd>Telescope find_files<cr>
nnoremap <silent><leader>bb <cmd>Telescope buffers<cr>
nnoremap <silent><leader>s <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent><leader>ps <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <silent><leader>q <cmd>Telescope quickfix<cr>

nnoremap <silent><nowait> <leader>l <cmd>Telescope builtin<cr>

" completion-nvim
let g:completion_enable_snippet = 'vim-vsnip'

" vsnip
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Tree Sitter
lua require('treesitter')

" nvim-lsp
lua require('lspinit')

autocmd Filetype cpp,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

function! SetLspColors()
    hi LspReferenceText cterm=bold,undercurl ctermbg=239 gui=bold,undercurl guibg=#4f4764 guisp=#FD9720
    hi LspReferenceRead cterm=bold,undercurl ctermbg=34 gui=bold,undercurl guibg=#1aad16 guisp=#FD9720
    hi LspReferenceWrite cterm=bold,underline ctermbg=34 gui=bold,underline guibg=#1aad16 guisp=#FD9720
endfunction
command! SetLspColors call SetLspColors()
SetLspColors

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" vimtex
let g:tex_flavor = "latex"

" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], 
            \             [ 'readonly', 'filename', 'method', 'modified', 'gitg', 'lspstatus' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'gitblame', 'gitb', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'lspstatus': 'LspStatus',
            \   'gitg': 'LightlineGitBranch',
            \   'gitb': 'LightlineGitBuffer',
            \   'gitblame': 'LightlineGitBlame',
            \ }
            \ }

function! LightlineGitBranch()
    return get(g:, 'coc_git_status', '')
endfunction

function! LightlineGitBuffer()
    return get(b:, 'coc_git_status', '')
endfunction

function! LightlineGitBlame()
    return get(b:, 'coc_git_blame', '')
endfunction

" git-gutter
let g:gitgutter_map_keys = 0

