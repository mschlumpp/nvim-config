local function option(name, value, targets)
    local t = targets
    local v = value
    if targets == nil then
        t = {vim.o}
    end
    if value == nil then
        v = true
    end
    for i, target in ipairs(t) do
         target[name] = v
    end
end

local buffer = {vim.o, vim.bo}
local window = {vim.o, vim.wo}
option('shm', vim.o.shm .. 'I')
option('incsearch')
option('ignorecase')
option('smartcase')
option('autoread')
option('laststatus', 2)
option('ruler')
option('number', true, window)
option('hidden')
option('updatetime', 300)
option('timeoutlen', 500)
option('cmdheight', 2)
option('signcolumn', 'yes', window)
option('termguicolors')
option('completeopt', 'menuone,noselect')
option('shortmess', vim.o.shortmess .. 'c')
option('mouse', 'a')
option('undofile', true, buffer)
option('cursorline', true, window)
option('wildmode', 'longest,list,full')
option('wildmenu')

vim.g.mapleader = ' '

-- tab settings
option('smarttab')
option('expandtab', true, buffer)
option('shiftwidth', 4, buffer)

-- plugins
vim.cmd([[command! PackerInstall lua require('plugins').install()]])
vim.cmd([[command! PackerUpdate lua require('plugins').update()]])
vim.cmd([[command! PackerSync lua require('plugins').sync()]])
vim.cmd([[command! PackerClean lua require('plugins').clean()]])
vim.cmd([[command! PackerCompile lua require('plugins').compile()]])
vim.cmd([[command! PackerStatus lua require('plugins').status()]])

-- GUI
option('guifont', 'Iosevka Term:h14')

-- Ensure buffers automatic buffer reloading. Uses silent to prevent error messages for command line window/search history.
vim.api.nvim_exec([[
    augroup focus_checktime
        au!
        au FocusGained,BufEnter * :silent! checktime
    augroup END
]], false)

-- Use spellchecking in text buffers
vim.api.nvim_exec([[
    augroup text_spellcheck
        au!
        au FileType markdown setlocal spell
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
