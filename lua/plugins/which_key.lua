local wk = require 'which-key'

wk.setup {
    plugins = {
        spelling = {
            enabled = true,
        },
    },
}

wk.register({
    f = {
        name = "+files",
        f = { '<cmd>RnvimrToggle<cr>', 'file-explorer' },
        r = { '<cmd>Telescope oldfiles<cr>', 'history' },
        s = { '<cmd>write<cr>', 'write-file' },
        S = { '<cmd>wall<cr>', 'write-all-file' },
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
        k = { '<cmd>Sayonara!<cr>', 'kill-buffer' },
        b = { '<cmd>Telescope buffers<cr>', 'switch-buffer' },
    },
    t = {
        name = "+options",
        u = { '<cmd>UndotreeToggle<cr>', 'undo-tree'},
    },
    g = {
        name = "+git",
        g = { '<cmd>Git<cr>', 'git-status' },
    },
    c = {
        name = '+code',
    },
    s = {
        name = "+search",
        p = { '<cmd>Telescope live_grep<cr>', 'ripgrep' },
        b = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'buffer-lines' },
        s = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'lsp-workspace-symbols' },
    },
    ['`'] = { '<cmd>NvimTreeToggle<cr>', 'tree-toggle' },
    ['~'] = { '<cmd>NvimTreeFindFile<cr>', 'tree-find-file' },
    l = { '<cmd>Telescope builtin<cr>', 'telescope' },
    r = { '<cmd>Telescope resume<cr>', 'resume-telescope'},
    q = { 
        name = "+quickfix",
        q = { '<cmd>copen<cr>', 'open' },
        c = { '<cmd>cclose<cr>', 'close' },
        p = { '<cmd>colder<cr>', 'older-list' },
        n = { '<cmd>cnewer<cr>', 'newer-list' },
        h = { '<cmd>Telescope quickfixhistory<cr>', 'list-history' },
    },
    ['<space>'] = { '<cmd>Telescope find_files<cr>', 'find-file' },
    ['.'] = { function() require'plugins.quickswitch'.start_switch() end, 'quick-switch' },
}, { prefix = "<leader>" })

-- vim.api.nvim_set_keymap('n', '<leader>.', [[<cmd>lua require'plugins.quickswitch'.start_switch()<cr>]], { noremap = true, silent = true })

-- vim.api.nvim_set_var('which_key_map', which_key_map)
-- vim.fn['which_key#register']('<Space>', "g:which_key_map")

-- vim.api.nvim_set_keymap('n', '<leader>', "<cmd>WhichKey '<Space>'<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<leader>', "<cmd>WhichKeyVisual '<Space>'<CR>", { noremap = true, silent = true })

