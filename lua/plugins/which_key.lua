local which_key_map = {
    f = {
        name = "+files",
        f = { 'RnvimrToggle', 'file-explorer' },
        r = { 'History', 'history' },
        s = { 'write', 'write-file' },
        S = { 'writeall', 'write-all-file' },
    },
    w = {
        name = "+windows",
        j = { '<c-w>j', 'window-down' },
        k = { '<c-w>k', 'window-up' },
        h = { '<c-w>h', 'window-left' },
        l = { '<c-w>l', 'window-right' },

        m = { '<c-w>o', 'maximize' },
        c = { '<c-w>c', 'close' },
        v = { '<c-w>v', 'split-vertical' },
        s = { '<c-w>s', 'split-horizontal' },
        ['='] = { '<c-w>=', 'balance-windows' },
    },
    b = {
        name = "+buffers",
        k = { ':Sayonara!', 'kill-buffer' },
        b = { 'Buffers', 'switch-buffer' },
    },
    g = {
        name = "+git",
        g = { 'Git', 'git-status' },
    },
    s = {
        name = "+search",
        p = { 'RG', 'ripgrep' },
        b = { 'BLines', 'ripgrep' },
        s = { 'Telescope lsp_workspace_symbols', 'lsp-workspace-symbols' },
    },
    ['`'] = { 'NvimTreeToggle', 'tree-toggle' },
    ['~'] = { 'NvimTreeFindFile', 'tree-find-file' },
    l = { ':Telescope builtin', 'telescope' },
    -- q = { 
    --     name = "+quit",
    --     q = { 'qall', 'quit' },
    -- },
    [vim.api.nvim_replace_termcodes('<space>', true, true, true)] = { 'Files', 'find-file' },
    ['.'] = 'quick-switch',
}

vim.api.nvim_set_keymap('n', '<leader>.', [[<cmd>lua require'plugins.quickswitch'.start_switch()<cr>]], { noremap = true, silent = true })

vim.api.nvim_set_var('which_key_map', which_key_map)
vim.fn['which_key#register']('<Space>', "g:which_key_map")

vim.api.nvim_set_keymap('n', '<leader>', "<cmd>WhichKey '<Space>'<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>', "<cmd>WhichKeyVisual '<Space>'<CR>", { noremap = true, silent = true })

