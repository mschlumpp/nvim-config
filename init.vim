if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug '/usr/share/vim/vimfiles/'

" Appearance
Plug 'glepnir/galaxyline.nvim'
Plug 'dstein64/nvim-scrollview'

Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Utilities
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'akinsho/nvim-toggleterm.lua'
Plug 'chrisbra/SudoEdit.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mhinz/vim-sayonara'

" Tree Sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'

" LSP and related packages
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
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
set signcolumn=yes
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

noremap <silent><leader>bk <cmd>Sayonara!<cr>

nnoremap <silent><leader>gg <cmd>Gstatus<cr>

" quick fix
nnoremap <silent>]q :cn<cr>
nnoremap <silent>[q :cp<cr>

" completion-nvim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_confirm_key = ""
imap <expr> <cr> pumvisible() ? complete_info()["selected"] != "-1" ?
            \ "\<Plug>(completion_confirm_completion)"  :
            \ "\<c-e>\<CR>" : "\<CR>"

let g:completion_matching_smart_case = 1

" telescope
lua <<EOF
local telescope = require('telescope')
telescope.load_extension('dap')
telescope.setup {
    defaults = {
        winblend = 5
    }
}
EOF

" fzf
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" These are here because they belong under the 'f'ile hierarchy
nnoremap <silent><leader>fs <cmd>w<cr>
nnoremap <silent><leader>fS <cmd>wall<cr>

nnoremap <silent><leader>fr <cmd>History<cr>
nnoremap <silent><leader>h  <cmd>Files<cr>
nnoremap <silent><leader>bb <cmd>Buffers<cr>

nnoremap <silent><leader>sl <cmd>BLines<cr>
nnoremap <silent><leader>sp <cmd>RG<cr>

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

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" lua plugins
lua require('plugins.treesitter')
lua require('plugins.dap')
lua require('plugins.gitsigns')
lua require('plugins.lsp')
lua require('plugins.galaxyline')
lua require('plugins.toggleterm')

" lsp
autocmd Filetype cpp,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

function! SetLspColors()
    hi LspReferenceText cterm=bold,undercurl ctermbg=239 gui=bold,undercurl guibg=#4f4764 guisp=#FD9720
    hi LspReferenceRead cterm=bold,undercurl ctermbg=34 gui=bold,undercurl guibg=#1aad16 guisp=#FD9720
    hi LspReferenceWrite cterm=bold,underline ctermbg=34 gui=bold,underline guibg=#1aad16 guisp=#FD9720
endfunction
command! SetLspColors call SetLspColors()
SetLspColors

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


" vimtex
let g:tex_flavor = "latex"

