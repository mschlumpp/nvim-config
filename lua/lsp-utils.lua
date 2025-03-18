local M = {}

local navic = require 'nvim-navic'

function M.make_on_attach(config)
    return function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(name, value)
            vim.api.nvim_set_option_value(name, value, { buf = bufnr })
        end

        if config.before then config.before(client) end

        local opts = { noremap = true, silent = true }
        -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<leader>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
        buf_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('i', '<c-q>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>cn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<M-CR>', '<cmd>FzfLua lsp_code_actions<CR>', opts)
        buf_set_keymap('v', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', ']g',
            '<cmd>lua vim.diagnostic.goto_next({ float = true, popup_opts = { border = "single"}})<cr>', opts)
        buf_set_keymap('n', '[g',
            '<cmd>lua vim.diagnostic.goto_prev({ float = true, popup_opts = { border = "single"}})<cr>', opts)

        buf_set_keymap('n', '<leader>e',
            '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", { border = "single"}})<CR>', opts)
        buf_set_keymap('n', '<leader>E', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)

        if client.server_capabilities.documentFormattingProvider then
            buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
            buf_set_keymap('v', '<leader>=', '<cmd>lua vim.lsp.buf.format()<cr>', opts)
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
