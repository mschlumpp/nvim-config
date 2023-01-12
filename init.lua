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
option('shortmess', vim.o.shm .. 'I')
option('incsearch')
option('ignorecase')
option('smartcase')
option('wildignorecase')
option('autoread')
option('showmode', false)
option('laststatus', 2)
option('ruler')
option('number', true, window)
option('hidden')
option('updatetime', 300)
option('timeoutlen', 500)
option('cmdheight', 2)
option('signcolumn', 'auto', window)
option('termguicolors')
option('completeopt', 'menu,menuone,noselect')
option('shortmess', vim.o.shortmess .. 'c')
option('mouse', 'a')
option('undofile', true, buffer)
option('cursorline', true, window)
option('wildmenu', false)
option('inccommand', 'split')
option('list', true, window)
vim.opt.formatoptions:remove { 't' }
vim.opt.formatoptions:append { '/' }

vim.g.mapleader = ' '

-- tab settings
option('smarttab')
option('expandtab', true, buffer)
option('shiftwidth', 4, buffer)

-- Disable matchparen as it causes stutters
-- vim.cmd([[let loaded_matchparen = 1]])

-- plugins
vim.api.nvim_create_user_command("PackerInstall", function(opts) require'plugins'.install(unpack(opts.fargs)) end, {
    complete = "customlist,v:lua.require'packer'.plugin_complete",
    nargs = "*",
})
vim.api.nvim_create_user_command("PackerUpdate", function(opts) require'plugins'.update(unpack(opts.fargs)) end, {
    complete = "customlist,v:lua.require'packer'.plugin_complete",
    nargs = "*",
})
vim.api.nvim_create_user_command("PackerSync", function(opts) require'plugins'.sync(unpack(opts.fargs)) end, {
    complete = "customlist,v:lua.require'packer'.plugin_complete",
    nargs = "*",
})
vim.api.nvim_create_user_command("PackerClean", function(opts) require'plugins'.clean() end, {})
vim.api.nvim_create_user_command("PackerStatus", function(opts) require'plugins'.status() end, {})
vim.api.nvim_create_user_command("PackerProfile", function(opts) require'plugins'.profile_output() end, {})
vim.api.nvim_create_user_command("PackerLoad", function(opts) require'packer'.loader(unpack(opts.fargs), opts.bang) end, {
    complete = "customlist,v:lua.require'packer'.loader_complete",
    nargs = "+",
})
vim.api.nvim_create_user_command("PackerCompile", function(opts) require('plugins').compile(opts.fargs) end, {
    nargs = "*",
})

-- GUI
option('guifont', 'Iosevka Term:h14')

-- Ensure buffers automatic buffer reloading. Uses silent to prevent error messages for command line window/search history.
vim.api.nvim_exec([[
    augroup focus_checktime
        au!
        au FocusGained,BufEnter * :silent! checktime
    augroup END
]], false)

-- Use spellchecking/wordbreaks in text buffers
vim.api.nvim_exec([[
    augroup text_spellcheck
        au!
        au FileType tex,markdown setlocal spell linebreak
    augroup END
]], false)

-- some additional keybinds
vim.api.nvim_set_keymap('n', ']q', '<cmd>cn<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '[q', '<cmd>cp<cr>', { silent = true, noremap = true })

vim.api.nvim_set_keymap('', '<m-c-up>', '<c-w>k', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<m-c-down>', '<c-w>j', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<m-c-left>', '<c-w>h', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<m-c-right>', '<c-w>l', { silent = true, noremap = true })

vim.api.nvim_set_keymap('t', '<esc>', '(&filetype == "fzf" ? "<esc>" : "<c-\\><c-n>")', { noremap = true, expr = true })

-- git in nvim terminal
vim.api.nvim_exec([[
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase set bufhidden=delete
]], false)

-- LSP colorscheme hack
vim.api.nvim_exec([[
    function! SetLspColorsLight()
        hi LspReferenceText cterm=bold,undercurl ctermbg=239 gui=bold,undercurl guibg=#F5F5F5 guisp=#FD9720
        hi LspReferenceRead cterm=bold,undercurl ctermbg=34 gui=bold,undercurl guibg=#F0FAF0 guisp=#FD9720
        hi LspReferenceWrite cterm=bold,underline ctermbg=34 gui=bold,underline guibg=#FAF0F0 guisp=#FD9720
    endfunction
    command! SetLspColorsLight call SetLspColorsLight()

    function! SetLspColors()
        hi LspReferenceText cterm=bold,undercurl ctermbg=239 gui=bold,undercurl guibg=#4f4764 guisp=#FD9720
        hi LspReferenceRead cterm=bold,undercurl ctermbg=34 gui=bold,undercurl guibg=#1aad16 guisp=#FD9720
        hi LspReferenceWrite cterm=bold,underline ctermbg=34 gui=bold,underline guibg=#1aad16 guisp=#FD9720
    endfunction
    command! SetLspColors call SetLspColors()
    SetLspColors
]], false)
