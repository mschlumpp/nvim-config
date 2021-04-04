require('compe').setup {
    enabled = true,
    autocomplete = true,
    source = {
        path = true,
        buffer = {
            ignored_filetypes = {'rust', 'cpp'},
        },
        calc = true,
        vsnip = true,
        nvim_lsp = true,
        emoji = true,
        treesitter = {
            ignored_filetypes = {'rust', 'cpp'},
        },
        nvim_lua = true,
        spell = true,
        tags = true,
    },
}

local function intern_rep(str) 
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

function _G.tab_complete()
    if vim.fn.pumvisible() == 1 then
        return intern_rep("<C-n>")
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return intern_rep("<Plug>(vsnip-expand-or-jump)")
    elseif check_back_space() then
        return intern_rep("<Tab>")
    end
    return vim.fn['compe#complete']()
end

function _G.tab_complete_rev()
    if vim.fn.pumvisible() == 1 then
        return intern_rep("<C-p>")
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return intern_rep("<Plug>(vsnip-jump-prev)")
    end
    return intern_rep("<S-Tab>")
end

vim.api.nvim_set_keymap('i', '<Tab>', "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', "v:lua.tab_complete()", { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', "v:lua.tab_complete_rev()", { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', "v:lua.tab_complete_rev()", { expr = true })

vim.api.nvim_set_keymap('i', "<CR>", "compe#confirm(lexima#expand('<LT>CR>', 'i'))", { silent = true, expr = true })
vim.api.nvim_set_keymap('i', "<C-e>", "compe#close('<C-e>')", { expr = true })
vim.api.nvim_set_keymap('i', "<C-Space>", "compe#complete()", { expr = true })
