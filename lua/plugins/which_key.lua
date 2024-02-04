return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function(plugin)
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
                r = { '<cmd>FzfLua oldfiles<cr>', 'history' },
                s = { '<cmd>write<cr>', 'write-file' },
                S = { '<cmd>wall<cr>', 'write-all-file' },
            },
            w = {
                name = "+windows",
                j = { '<c-w>j', 'window-down' },
                k = { '<c-w>k', 'window-up' },
                h = { '<c-w>h', 'window-left' },
                l = { '<c-w>l', 'window-right' },

                o = { '<c-w>o', 'only-this-window' },
                c = { '<c-w>c', 'close' },
                v = { '<c-w>v', 'split-vertical' },
                s = { '<c-w>s', 'split-horizontal' },
            },
            b = {
                name = "+buffers",
                k = { '<cmd>Sayonara!<cr>', 'kill-buffer' },
                b = { '<cmd>FzfLua buffers<cr>', 'switch-buffer' },
            },
            t = {
                name = "+options",
                u = { '<cmd>UndotreeToggle<cr>', 'undo-tree'},
            },
            g = {
                name = "+git",
            },
            c = {
                name = '+code',
            },
            s = {
                name = "+search",
                p = { '<cmd>FzfLua live_grep<cr>', 'ripgrep' },
                b = { '<cmd>FzfLua lines<cr>', 'buffer-lines' },
                s = { '<cmd>FzfLua lsp_live_workspace_symbols<cr>', 'lsp-workspace-symbols' },
                d = { '<cmd>FzfLua lsp_document_symbols<cr>', 'lsp-document-symbols' },
            },
            ['`'] = { '<cmd>NvimTreeToggle<cr>', 'tree-toggle' },
            ['~'] = { '<cmd>NvimTreeFindFile<cr>', 'tree-find-file' },
            l = { '<cmd>FzfLua<cr>', 'fzf' },
            r = { '<cmd>FzfLua resume<cr>', 'resume-fzf'},
            q = {
                name = "+quickfix",
                q = { '<cmd>copen<cr>', 'open' },
                c = { '<cmd>cclose<cr>', 'close' },
                p = { '<cmd>colder<cr>', 'older-list' },
                n = { '<cmd>cnewer<cr>', 'newer-list' },
                h = { '<cmd>FzfLua quickfix_stack<cr>', 'list-history' },
            },
            ['<space>'] = { '<cmd>FzfLua files<cr>', 'find-file' },
        }, { prefix = "<leader>" })

        -- vim.api.nvim_set_var('which_key_map', which_key_map)
        -- vim.fn['which_key#register']('<Space>', "g:which_key_map")

        -- vim.api.nvim_set_keymap('n', '<leader>', "<cmd>WhichKey '<Space>'<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap('v', '<leader>', "<cmd>WhichKeyVisual '<Space>'<CR>", { noremap = true, silent = true })
    end,
}
