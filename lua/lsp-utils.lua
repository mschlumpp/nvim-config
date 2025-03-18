local M = {}

local navic = require 'nvim-navic'

function M.make_on_attach(config)
    return function(client, bufnr)
        ---@param mode string|string[]
        ---@param lhs string
        ---@param rhs string|function
        ---@param opts? vim.keymap.set.Opts
        local function buf_set_keymap(mode, lhs, rhs, opts)
            local default_opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', default_opts, opts or {}))
        end

        --- @param name string
        --- @param value any
        local function buf_set_option(name, value)
            vim.api.nvim_set_option_value(name, value, { buf = bufnr })
        end

        if config.before then config.before(client) end

        buf_set_keymap('n', 'gd', Snacks.picker.lsp_definitions, { desc = "lsp-definitions" })
        buf_set_keymap('n', 'gD', Snacks.picker.lsp_declarations, { desc = "lsp-declarations" })
        buf_set_keymap('n', 'gi', Snacks.picker.lsp_implementations, { desc = "lsp-implementations" })
        buf_set_keymap('n', 'gy', Snacks.picker.lsp_type_definitions, { desc = "lsp-type-definitions" })
        buf_set_keymap('n', 'gr', Snacks.picker.lsp_references, { desc = "lsp-references" })

        buf_set_keymap('n', '<leader>co', vim.lsp.buf.outgoing_calls)
        buf_set_keymap('n', '<leader>ci', vim.lsp.buf.incoming_calls)
        buf_set_keymap('n', 'K', vim.lsp.buf.hover)
        buf_set_keymap('i', '<c-q>', vim.lsp.buf.signature_help)
        buf_set_keymap('n', '<leader>cn', vim.lsp.buf.rename)
        buf_set_keymap('n', '<M-CR>', '<cmd>FzfLua lsp_code_actions<CR>')
        buf_set_keymap('v', '<M-CR>', vim.lsp.buf.code_action)
        buf_set_keymap('n', ']g',
            function() vim.diagnostic.goto_next({ float = true, popup_opts = { border = "single" } }) end)
        buf_set_keymap('n', '[g',
            function() vim.diagnostic.goto_prev({ float = true, popup_opts = { border = "single" } }) end)

        buf_set_keymap('n', '<leader>e',
            function() vim.diagnostic.open_float({ bufnr = 0, scope = "line", popup_opts = { border = "single" } }) end)
        buf_set_keymap('n', '<leader>E', vim.diagnostic.setqflist)

        if client.server_capabilities.documentFormattingProvider then
            buf_set_keymap({ 'n', 'v' }, '<leader>=', vim.lsp.buf.format)
        end

        if client.server_capabilities.documentHighlightProvider then
            local lsp_aucmds = vim.api.nvim_create_augroup('p_lsp_aucmds', {})
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = lsp_aucmds,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.document_highlight()
                end
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                group = lsp_aucmds,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.clear_references()
                end
            })
        end

        buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')
        buf_set_option('tagfunc', 'v:lua.vim.lsp.tagfunc')

        if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if config.after then config.after(client, bufnr) end
        if config.chain then config.chain(client, bufnr) end
    end
end

return M
