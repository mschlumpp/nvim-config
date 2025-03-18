return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function(plugin)
        local wk = require 'which-key'

        wk.setup {
            preset = "modern",
            plugins = {
                spelling = {
                    enabled = true,
                },
            },
        }

        wk.add({
            -- { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "find-file" },
            { "<leader>`", "<cmd>NvimTreeToggle<cr>", desc = "tree-toggle" },
            { "<leader>b", group = "buffers" },
            -- { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "switch-buffer" },
            { "<leader>c", group = "code" },
            { "<leader>f", group = "files" },
            { "<leader>fS", "<cmd>wall<cr>", desc = "write-all-file" },
            { "<leader>ff", "<cmd>RnvimrToggle<cr>", desc = "file-explorer" },
            -- { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "history" },
            { "<leader>fs", "<cmd>write<cr>", desc = "write-file" },
            { "<leader>g", group = "git" },
            -- { "<leader>l", "<cmd>FzfLua<cr>", desc = "fzf" },
            { "<leader>q", group = "quickfix" },
            { "<leader>qc", "<cmd>cclose<cr>", desc = "close" },
            { "<leader>qh", "<cmd>FzfLua quickfix_stack<cr>", desc = "list-history" },
            { "<leader>qn", "<cmd>cnewer<cr>", desc = "newer-list" },
            { "<leader>qp", "<cmd>colder<cr>", desc = "older-list" },
            { "<leader>qq", "<cmd>copen<cr>", desc = "open" },
            -- { "<leader>r", "<cmd>FzfLua resume<cr>", desc = "resume-fzf" },
            { "<leader>s", group = "search" },
            -- { "<leader>sb", "<cmd>FzfLua lines<cr>", desc = "buffer-lines" },
            -- { "<leader>sd", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "lsp-document-symbols" },
            -- { "<leader>sp", "<cmd>FzfLua live_grep<cr>", desc = "ripgrep" },
            -- { "<leader>ss", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "lsp-workspace-symbols" },
            { "<leader>t", group = "options" },
            { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "undo-tree" },
            { "<leader>w", group = "windows" },
            { "<leader>wc", "<c-w>c", desc = "close" },
            { "<leader>wh", "<c-w>h", desc = "window-left" },
            { "<leader>wj", "<c-w>j", desc = "window-down" },
            { "<leader>wk", "<c-w>k", desc = "window-up" },
            { "<leader>wl", "<c-w>l", desc = "window-right" },
            { "<leader>wo", "<c-w>o", desc = "only-this-window" },
            { "<leader>ws", "<c-w>s", desc = "split-horizontal" },
            { "<leader>wv", "<c-w>v", desc = "split-vertical" },
            { "<leader>~", "<cmd>NvimTreeFindFile<cr>", desc = "tree-find-file" },
        })

        -- vim.api.nvim_set_var('which_key_map', which_key_map)
        -- vim.fn['which_key#register']('<Space>', "g:which_key_map")

        -- vim.api.nvim_set_keymap('n', '<leader>', "<cmd>WhichKey '<Space>'<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap('v', '<leader>', "<cmd>WhichKeyVisual '<Space>'<CR>", { noremap = true, silent = true })
    end,
}
