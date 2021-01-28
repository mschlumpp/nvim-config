if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '/usr/share/vim/vimfiles/'

" Appearance
Plug 'itchyny/lightline.vim'
Plug 'dstein64/nvim-scrollview'

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
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/SudoEdit.vim'
Plug 'editorconfig/editorconfig-vim'

" Tree Sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" LSP and related packages
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'

Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-lsp'

Plug 'jackguo380/vim-lsp-cxx-highlight'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-telescope/telescope-dap.nvim'

" Language support
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
set ignorecase
set smartcase
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

nnoremap <silent><leader>gg <cmd>Gstatus<cr>

" quick fix
nnoremap <silent>]q :cn<cr>
nnoremap <silent>[q :cp<cr>

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#lsp#handler_enabled = 0

" telescope
lua <<EOF
local telescope = require('telescope')
telescope.load_extension('fzy_native')
telescope.load_extension('dap')
telescope.setup {
    defaults = {
        winblend = 5
    }
}
EOF
" These are here because they belong under the 'f'ile hierarchy
nnoremap <silent><leader>fs <cmd>w<cr>
nnoremap <silent><leader>fS <cmd>wall<cr>

nnoremap <silent><leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <silent><leader>h  <cmd>Telescope find_files<cr>
nnoremap <silent><leader>bb <cmd>Telescope buffers<cr>

nnoremap <silent><leader>sl <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <silent><leader>sp <cmd>Telescope live_grep<cr>

nnoremap <silent><leader>ps <cmd>Telescope lsp_workspace_symbols<cr>
nnoremap <silent><leader>q <cmd>Telescope quickfix<cr>

noremap <silent><nowait> <leader>l <cmd>Telescope builtin<cr>

" deoplete
let g:deoplete#enable_at_startup = 1

" vsnip
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Tree Sitter
lua require('treesitter')

" dap
lua require('dapinit')

command! -complete=file -nargs=* DebugC lua require'dapinit'.start_c_debugger({<f-args>})

nnoremap <silent> <F9> <cmd>lua require 'dap'.continue()<cr>
nnoremap <silent> <F8> <cmd>lua require 'dap'.step_over()<cr>
nnoremap <silent> <F20> <cmd>lua require 'dap'.step_out()<cr>
nnoremap <silent> <F7> <cmd>lua require 'dap'.step_into()<cr>

nnoremap <silent> <leader>db <cmd>lua require 'dap'.toggle_breakpoint()<cr>
nnoremap <silent> <leader>dK <cmd>lua require 'dap.ui.variables'.hover()<cr>
nnoremap <silent> <leader>dB <cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
nnoremap <silent> <leader>dp <cmd>lua require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>
nnoremap <silent> <leader>do <cmd>lua require 'dap'.repl.toggle()<cr>

nnoremap <silent> <leader>dd <cmd>lua require 'telescope'.extensions.dap.commands()<cr>
nnoremap <silent> <leader>dl <cmd>lua require 'telescope'.extensions.dap.list_breakpoints()<cr>
nnoremap <silent> <leader>dv <cmd>lua require 'telescope'.extensions.dap.variables()<cr>

nnoremap <silent> <leader>dr <cmd>lua require 'dap'.run_last()<cr>

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

" vimtex
let g:tex_flavor = "latex"

" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], 
            \             [ 'gitg', 'readonly', 'filename', 'method', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'gitblame', 'gitb', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'gitg': 'FugitiveHead',
            \ }
            \ }

" git-gutter
let g:gitgutter_map_keys = 0

