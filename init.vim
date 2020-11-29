if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'nanotech/jellybeans.vim'
Plug '/usr/share/vim/vimfiles/'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
Plug 'vn-ki/coc-clap'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'
Plug 'LnL7/vim-nix'
Plug 'bazelbuild/vim-ft-bzl'
Plug 'lervag/vimtex'
Plug 'tomasiser/vim-code-dark'
Plug 'chriskempson/base16-vim'
Plug 'ziglang/zig.vim'
Plug 'jceb/vim-orgmode'
Plug 'bakpakin/fennel.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'wellle/context.vim'
Plug 'gosukiwi/vim-atom-dark'
Plug 'chrisbra/SudoEdit.vim'
call plug#end()

" Some basic options
set incsearch
set autoread
set laststatus=2
set ruler
set relativenumber
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

set guifont=Iosevka:h11.8

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

" deoplete
let g:deoplete#enable_at_startup = 1

" clap
noremap <silent><leader>ff :Clap filer<cr>
noremap <silent><leader>fr :Clap history<cr>
noremap <silent><leader>h :Clap files<cr>
noremap <silent><leader>bb :Clap buffers<cr>
noremap <silent><leader>s :Clap lines<cr>
noremap <silent><leader>a :Clap grep2<cr>

nnoremap <silent><nowait> <leader>l :<C-u>Clap providers<cr>

" coc
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  autocmd FileType typescript,json,rust setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>m  <Plug>(coc-codeaction-selected)
nmap <leader>m  <Plug>(coc-codeaction-selected)
nmap <leader>mc  v<Plug>(coc-codeaction-selected)

nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <silent><nowait> <leader>c :<C-u>Clap coc_commands<cr>
nnoremap <silent><nowait> <leader>d :<C-u>Clap coc_diagnostics<cr>

command! -nargs=0 Format :call CocAction('format')

" vimtex
let g:tex_flavor = "latex"

" lightline
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ], 
            \             [ 'readonly', 'filename', 'method', 'modified', 'gitg', 'cocstatus' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'gitblame', 'gitb', 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
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

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" git-gutter
let g:gitgutter_map_keys = 0
