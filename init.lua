vim.o.shm = vim.o.shm .. 'I'
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.autoread = true
vim.o.laststatus = 2
vim.o.ruler = true
vim.o.number = true
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.cmdheight = 2
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.cursorline = true

vim.o.wildmode = 'longest,list,full'
vim.o.wildmenu = true

vim.g.mapleader = ' '

-- tab settings
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.shiftwidth = 4

-- plugins
vim.cmd([[command! PackerInstall lua require('plugins').install()]])
vim.cmd([[command! PackerUpdate lua require('plugins').update()]])
vim.cmd([[command! PackerSync lua require('plugins').sync()]])
vim.cmd([[command! PackerClean lua require('plugins').clean()]])
vim.cmd([[command! PackerCompile lua require('plugins').compile()]])

-- GUI
vim.o.guifont = 'Iosevka Term:h14'

if vim.g.colors_name == nil then
    vim.cmd('colorscheme base16-github')
end

vim.api.nvim_exec([[
    augroup focus_checktime
        au!
        au FocusGained,BufEnter * :checktime
    augroup END
]], false)

-- some additional keybinds
vim.api.nvim_set_keymap('n', ']q', '<cmd>cn<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cp<cr>', { silent = true, noremap = true })

vim.api.nvim_set_keymap('', '<c-s-up>', '<c-w>k', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<c-s-down>', '<c-w>j', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<c-s-left>', '<c-w>h', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<c-s-right>', '<c-w>l', { silent = true, noremap = true })

-- LSP colorscheme hack
vim.api.nvim_exec([[
    function! SetLspColors()
        hi LspReferenceText cterm=bold,undercurl ctermbg=239 gui=bold,undercurl guibg=#4f4764 guisp=#FD9720
        hi LspReferenceRead cterm=bold,undercurl ctermbg=34 gui=bold,undercurl guibg=#1aad16 guisp=#FD9720
        hi LspReferenceWrite cterm=bold,underline ctermbg=34 gui=bold,underline guibg=#1aad16 guisp=#FD9720
    endfunction
    command! SetLspColors call SetLspColors()
    SetLspColors
]], false)
