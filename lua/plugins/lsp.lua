local lspconfig = require 'lspconfig'
local lspkind = require 'lspkind'
local lsp_status = require 'lsp-status'

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            spacing = 4,
        },
        signs = true,
        update_in_insert = true,
        underline = true
    }
)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = 'single',
    }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = 'single',
    }
)

local servers = {
    clangd = {
        init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            semanticHighlighting = true
        },
        flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 8000,
        },
        handlers = lsp_status.extensions.clangd.setup(),
        cmd = { "clangd", "--background-index", "--suggest-missing-includes", "--cross-file-rename", "--clang-tidy" }
    },
    gopls = { },
    pyright = { },
    jsonls = {
        cmd = {"json-languageserver"}
    },
    tsserver = {  },
    zls = { },
    rust_analyzer = {
        cmd = {"rust-analyzer"},
        flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 4000,
        },
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importMergeBehaviour = "last",
                },
                checkOnSave = {
                    command = "clippy",
                },
                completion = {
                    addCallArgumentSnippets = true,
                    addCallParenthesis = true,
                    ["postfix.enable"] = true,
                },
                procMacro = {
                    enable = true,
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
            }
        }
    }
}

local function make_on_attach(config) 
    return function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        if config.before then config.before(client) end

        local opts = {noremap = true, silent = true}
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<leader>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
        buf_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('i', '<c-q>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<M-CR>', '<cmd>lua require"telescope.builtin".lsp_code_actions(require"telescope.themes".get_cursor())<CR>', opts)
        buf_set_keymap('v', '<M-CR>', '<cmd>lua require"telescope.builtin".lsp_range_code_actions(require"telescope.themes".get_cursor())<CR>', opts)
        buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next({ float = true, popup_opts = { border = "single"}})<cr>', opts)
        buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev({ float = true, popup_opts = { border = "single"}})<cr>', opts)

        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", { border = "single"}})<CR>', opts)
        buf_set_keymap('n', '<leader>E', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)

        if client.resolved_capabilities.document_formatting then
            buf_set_keymap('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
            buf_set_keymap('v', '<leader>=', '<cmd>lua vim.lsp.buf.range_formatting()<cr>', opts)
        end

        if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
                augroup p_lsp_aucmds
                au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]], false)
        end

        lsp_status.on_attach(client)

        if config.after then config.after(client) end
    end
end

local snippet_capabilities = {
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = true,
                resolveSupport = {
                    properties = {
                        'documentation',
                        'detail',
                        'additionalTextEdits',
                    }
                }
            }
        }
    }
}

for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.capabilities = vim.tbl_deep_extend('force', 
        vim.lsp.protocol.make_client_capabilities(), 
        lsp_status.capabilities, -- As of 2021-06-15 this includes make_client_capabilities() but IHMO it should not
        snippet_capabilities
    )

    lspconfig[server].setup(config)
end

lspkind.init({})

lsp_status.config {
    status_symbol = '',
}
lsp_status.register_progress()
